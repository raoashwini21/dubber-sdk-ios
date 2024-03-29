#import "DUBApiClient.h"

NSString *const DUBResponseObjectErrorKey = @"DUBResponseObject";

static long requestId = 0;
static bool offlineState = false;
static NSMutableSet * queuedRequests = nil;
static bool cacheEnabled = false;
static AFNetworkReachabilityStatus reachabilityStatus = AFNetworkReachabilityStatusNotReachable;
static void (^reachabilityChangeBlock)(int);


@interface DUBApiClient ()

@property (readwrite, nonatomic) NSDictionary *HTTPResponseHeaders;

@end

@implementation DUBApiClient

- (instancetype)init {
    NSString *baseUrl = [[DUBConfiguration sharedConfig] host];
    return [self initWithBaseURL:[NSURL URLWithString:baseUrl]];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.securityPolicy = [self customSecurityPolicy];
        // configure reachability
        [self configureCacheReachibility];
    }
    return self;
}

+ (void)initialize {
    if (self == [DUBApiClient class]) {
        queuedRequests = [[NSMutableSet alloc] init];
        // initialize URL cache
        [self configureCacheWithMemoryAndDiskCapacity:4*1024*1024 diskSize:32*1024*1024];
    }
}

#pragma mark - Setter Methods

+ (void) setOfflineState:(BOOL) state {
    offlineState = state;
}

+ (void) setCacheEnabled:(BOOL)enabled {
    cacheEnabled = enabled;
}

+(void) setReachabilityStatus:(AFNetworkReachabilityStatus)status {
    reachabilityStatus = status;
}

- (void)setHeaderValue:(NSString*) value
                forKey:(NSString*) forKey {
    [self.requestSerializer setValue:value forHTTPHeaderField:forKey];
}

#pragma mark - Log Methods

+ (void)debugLog:(NSString *)method
         message:(NSString *)format, ... {
    DUBConfiguration *config = [DUBConfiguration sharedConfig];
    if (!config.debug) {
        return;
    }

    NSMutableString *message = [NSMutableString stringWithCapacity:1];

    if (method) {
        [message appendString:[NSString stringWithFormat:@"%@: ", method]];
    }

    va_list args;
    va_start(args, format);

    [message appendString:[[NSString alloc] initWithFormat:format arguments:args]];

    // If set logging file handler, log into file,
    // otherwise log into console.
    if (config.loggingFileHanlder) {
        [config.loggingFileHanlder seekToEndOfFile];
        [config.loggingFileHanlder writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else {
        NSLog(@"%@", message);
    }

    va_end(args);
}

- (void)logResponse:(AFHTTPRequestOperation *)operation
         forRequest:(NSURLRequest *)request
              error:(NSError*)error {

    NSString *message = [NSString stringWithFormat:@"\n[DEBUG] HTTP request body \n~BEGIN~\n %@\n~END~\n"\
                         "[DEBUG] HTTP response body \n~BEGIN~\n %@\n~END~\n",
                        [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding],
                        operation.responseString];

    DUBDebugLog(message);
}

#pragma mark - Cache Methods

+(void)clearCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

+(void)configureCacheWithMemoryAndDiskCapacity: (unsigned long) memorySize
                                      diskSize: (unsigned long) diskSize {
    NSAssert(memorySize > 0, @"invalid in-memory cache size");
    NSAssert(diskSize >= 0, @"invalid disk cache size");

    NSURLCache *cache =
    [[NSURLCache alloc]
     initWithMemoryCapacity:memorySize
     diskCapacity:diskSize
     diskPath:@"swagger_url_cache"];

    [NSURLCache setSharedURLCache:cache];
}

#pragma mark - Utility Methods

/*
 * Detect `Accept` from accepts
 */
+ (NSString *) selectHeaderAccept:(NSArray *)accepts {
    if (accepts == nil || [accepts count] == 0) {
        return @"";
    }

    NSMutableArray *lowerAccepts = [[NSMutableArray alloc] initWithCapacity:[accepts count]];
    for (NSString *string in accepts) {
        NSString * lowerAccept = [string lowercaseString];
	// use rangeOfString instead of containsString for iOS 7 support
	if ([lowerAccept rangeOfString:@"application/json"].location != NSNotFound) {
            return @"application/json";
        }
        [lowerAccepts addObject:lowerAccept];
    }

    if (lowerAccepts.count == 1) {
        return [lowerAccepts firstObject];
    }

    return [lowerAccepts componentsJoinedByString:@", "];
}

/*
 * Detect `Content-Type` from contentTypes
 */
+ (NSString *) selectHeaderContentType:(NSArray *)contentTypes
{
    if (contentTypes == nil || [contentTypes count] == 0) {
        return @"application/json";
    }

    NSMutableArray *lowerContentTypes = [[NSMutableArray alloc] initWithCapacity:[contentTypes count]];
    [contentTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [lowerContentTypes addObject:[obj lowercaseString]];
    }];

    if ([lowerContentTypes containsObject:@"application/json"]) {
        return @"application/json";
    }
    else {
        return lowerContentTypes[0];
    }
}

+ (NSString*)escape:(id)unescaped {
    if ([unescaped isKindOfClass:[NSString class]]){
        return (NSString *)CFBridgingRelease
        (CFURLCreateStringByAddingPercentEscapes(
                                                 NULL,
                                                 (__bridge CFStringRef) unescaped,
                                                 NULL,
                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                 kCFStringEncodingUTF8));
    }
    else {
        return [NSString stringWithFormat:@"%@", unescaped];
    }
}

#pragma mark - Request Methods

+(unsigned long)requestQueueSize {
    return [queuedRequests count];
}

+(NSNumber*) nextRequestId {
    @synchronized(self) {
        long nextId = ++requestId;
        DUBDebugLog(@"got id %ld", nextId);
        return [NSNumber numberWithLong:nextId];
    }
}

+(NSNumber*) queueRequest {
    NSNumber* requestId = [DUBApiClient nextRequestId];
    DUBDebugLog(@"added %@ to request queue", requestId);
    [queuedRequests addObject:requestId];
    return requestId;
}

+(void) cancelRequest:(NSNumber*)requestId {
    [queuedRequests removeObject:requestId];
}

-(Boolean) executeRequestWithId:(NSNumber*) requestId {
    NSSet* matchingItems = [queuedRequests objectsPassingTest:^BOOL(id obj, BOOL *stop) {
        if ([obj intValue]  == [requestId intValue]) {
            return YES;
        }
        else {
            return NO;
        }
    }];

    if (matchingItems.count == 1) {
        DUBDebugLog(@"removed request id %@", requestId);
        [queuedRequests removeObject:requestId];
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - Reachability Methods

+(AFNetworkReachabilityStatus) getReachabilityStatus {
    return reachabilityStatus;
}

+(bool) getOfflineState {
    return offlineState;
}

+(void) setReachabilityChangeBlock:(void(^)(int))changeBlock {
    reachabilityChangeBlock = changeBlock;
}

- (void) configureCacheReachibility {
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        reachabilityStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                DUBDebugLog(@"reachability changed to AFNetworkReachabilityStatusUnknown");
                [DUBApiClient setOfflineState:true];
                break;

            case AFNetworkReachabilityStatusNotReachable:
                DUBDebugLog(@"reachability changed to AFNetworkReachabilityStatusNotReachable");
                [DUBApiClient setOfflineState:true];
                break;

            case AFNetworkReachabilityStatusReachableViaWWAN:
                DUBDebugLog(@"reachability changed to AFNetworkReachabilityStatusReachableViaWWAN");
                [DUBApiClient setOfflineState:false];
                break;

            case AFNetworkReachabilityStatusReachableViaWiFi:
                DUBDebugLog(@"reachability changed to AFNetworkReachabilityStatusReachableViaWiFi");
                [DUBApiClient setOfflineState:false];
                break;
            default:
                break;
        }

        // call the reachability block, if configured
        if (reachabilityChangeBlock != nil) {
            reachabilityChangeBlock(status);
        }
    }];

    [self.reachabilityManager startMonitoring];
}

#pragma mark - Deserialize methods

- (id) deserialize:(id) data class:(NSString *) class {
    NSRegularExpression *regexp = nil;
    NSTextCheckingResult *match = nil;
    NSMutableArray *resultArray = nil;
    NSMutableDictionary *resultDict = nil;
    NSString *innerType = nil;

    // return nil if data is nil or class is nil
    if (!data || !class) {
        return nil;
    }

    // remove "*" from class, if ends with "*"
    if ([class hasSuffix:@"*"]) {
        class = [class substringToIndex:[class length] - 1];
    }

    // pure object
    if ([class isEqualToString:@"NSObject"]) {
        return data;
    }

    // list of models
    NSString *arrayOfModelsPat = @"NSArray<(.+)>";
    regexp = [NSRegularExpression regularExpressionWithPattern:arrayOfModelsPat
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:nil];

    match = [regexp firstMatchInString:class
                               options:0
                                 range:NSMakeRange(0, [class length])];

    if (match) {
        NSArray *dataArray = data;
        innerType = [class substringWithRange:[match rangeAtIndex:1]];

        resultArray = [NSMutableArray arrayWithCapacity:[dataArray count]];
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [resultArray addObject:[self deserialize:obj class:innerType]];
            }
        ];

        return resultArray;
    }

    // list of primitives
    NSString *arrayOfPrimitivesPat = @"NSArray\\* /\\* (.+) \\*/";
    regexp = [NSRegularExpression regularExpressionWithPattern:arrayOfPrimitivesPat
                                                       options:NSRegularExpressionCaseInsensitive
                                                         error:nil];
    match = [regexp firstMatchInString:class
                               options:0
                                 range:NSMakeRange(0, [class length])];

    if (match) {
        NSArray *dataArray = data;
        innerType = [class substringWithRange:[match rangeAtIndex:1]];

        resultArray = [NSMutableArray arrayWithCapacity:[dataArray count]];
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [resultArray addObject:[self deserialize:obj class:innerType]];
        }];

        return resultArray;
    }

    // map
    NSString *dictPat = @"NSDictionary\\* /\\* (.+?), (.+) \\*/";
    regexp = [NSRegularExpression regularExpressionWithPattern:dictPat
                                                       options:NSRegularExpressionCaseInsensitive
                                                         error:nil];
    match = [regexp firstMatchInString:class
                               options:0
                                 range:NSMakeRange(0, [class length])];

    if (match) {
        NSDictionary *dataDict = data;
        NSString *valueType = [class substringWithRange:[match rangeAtIndex:2]];

        resultDict = [NSMutableDictionary dictionaryWithCapacity:[dataDict count]];
        [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [resultDict setValue:[self deserialize:obj class:valueType] forKey:key];
        }];

        return resultDict;
    }

    // primitives
    NSArray *primitiveTypes = @[@"NSString", @"NSDate", @"NSNumber"];

    if ([primitiveTypes containsObject:class]) {
        if ([class isEqualToString:@"NSString"]) {
            return [NSString stringWithString:data];
        }
        else if ([class isEqualToString:@"NSDate"]) {
            return [NSDate dateWithISO8601String:data];
        }
        else if ([class isEqualToString:@"NSNumber"]) {
            // NSNumber from NSNumber
            if ([data isKindOfClass:[NSNumber class]]) {
                return data;
            }
            else if ([data isKindOfClass:[NSString class]]) {
                // NSNumber (NSCFBoolean) from NSString
                if ([[data lowercaseString] isEqualToString:@"true"] || [[data lowercaseString] isEqualToString:@"false"]) {
                    return [NSNumber numberWithBool:[data boolValue]];
                // NSNumber from NSString
                } else {
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    formatter.numberStyle = NSNumberFormatterDecimalStyle;
                    return [formatter numberFromString:data];
                }
            }
        }
    }

   // model
    Class ModelClass = NSClassFromString(class);
    if ([ModelClass instancesRespondToSelector:@selector(initWithDictionary:error:)]) {
        return [[ModelClass alloc] initWithDictionary:data error:nil];
    }

    return nil;
}

#pragma mark - Operation Methods

- (void) operationWithCompletionBlock: (NSURLRequest *)request
                            requestId: (NSNumber *) requestId
                      completionBlock: (void (^)(id, NSError *))completionBlock {
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request
                                                               success:^(AFHTTPRequestOperation *operation, id response) {
                                                                   if ([self executeRequestWithId:requestId]) {
                                                                       [self logResponse:operation forRequest:request error:nil];
                                                                       NSDictionary *responseHeaders = [[operation response] allHeaderFields];
                                                                       self.HTTPResponseHeaders = responseHeaders;
                                                                       completionBlock(response, nil);
                                                                   }
                                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                   if ([self executeRequestWithId:requestId]) {
                                                                       NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                                                                       if (operation.responseObject) {
                                                                           // Add in the (parsed) response body.
                                                                           userInfo[DUBResponseObjectErrorKey] = operation.responseObject;
                                                                       }
                                                                       NSError *augmentedError = [error initWithDomain:error.domain code:error.code userInfo:userInfo];
                                                                        [self logResponse:nil forRequest:request error:augmentedError];

                                                                       NSDictionary *responseHeaders = [[operation response] allHeaderFields];
                                                                       self.HTTPResponseHeaders = responseHeaders;

                                                                       completionBlock(nil, augmentedError);
                                                                   }
                                                               }];

    [self.operationQueue addOperation:op];
}

- (void) downloadOperationWithCompletionBlock: (NSURLRequest *)request
                                    requestId: (NSNumber *) requestId
                              completionBlock: (void (^)(id, NSError *))completionBlock {
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request
                                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                   DUBConfiguration *config = [DUBConfiguration sharedConfig];
                                                                   NSString *directory = nil;
                                                                   if (config.tempFolderPath) {
                                                                       directory = config.tempFolderPath;
                                                                   }
                                                                   else {
                                                                       directory = NSTemporaryDirectory();
                                                                   }

                                                                   NSDictionary *headers = operation.response.allHeaderFields;
                                                                   NSString *filename = nil;
                                                                   if ([headers objectForKey:@"Content-Disposition"]) {

                                                                       NSString *pattern = @"filename=['\"]?([^'\"\\s]+)['\"]?";
                                                                       NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                                                                                 error:nil];
                                                                       NSString *contentDispositionHeader = [headers objectForKey:@"Content-Disposition"];
                                                                       NSTextCheckingResult *match = [regexp firstMatchInString:contentDispositionHeader
                                                                                                                        options:0
                                                                                                                          range:NSMakeRange(0, [contentDispositionHeader length])];
                                                                       filename = [contentDispositionHeader substringWithRange:[match rangeAtIndex:1]];
                                                                   }
                                                                   else {
                                                                       filename = [NSString stringWithFormat:@"%@", [[NSProcessInfo processInfo] globallyUniqueString]];
                                                                   }

                                                                   NSString *filepath = [directory stringByAppendingPathComponent:filename];
                                                                   NSURL *file = [NSURL fileURLWithPath:filepath];

                                                                   [operation.responseData writeToURL:file atomically:YES];
                                                                   self.HTTPResponseHeaders = headers;
                                                                   completionBlock(file, nil);
                                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                                                                   if ([self executeRequestWithId:requestId]) {
                                                                       NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
                                                                       if (operation.responseObject) {
                                                                           userInfo[DUBResponseObjectErrorKey] = operation.responseObject;
                                                                       }

                                                                       NSError *augmentedError = [error initWithDomain:error.domain code:error.code userInfo:userInfo];


                                                                        [self logResponse:nil forRequest:request error:augmentedError];

                                                                       NSDictionary *responseHeaders = [[operation response] allHeaderFields];
                                                                       self.HTTPResponseHeaders = responseHeaders;
                                                                       completionBlock(nil, augmentedError);
                                                                   }
                                                               }];

    [self.operationQueue addOperation:op];
}

#pragma mark - Perform Request Methods

-(NSNumber*) requestWithPath: (NSString*) path
                      method: (NSString*) method
                  pathParams: (NSDictionary *) pathParams
                 queryParams: (NSDictionary*) queryParams
                  formParams: (NSDictionary *) formParams
                       files: (NSDictionary *) files
                        body: (id) body
                headerParams: (NSDictionary*) headerParams
                authSettings: (NSArray *) authSettings
          requestContentType: (NSString*) requestContentType
         responseContentType: (NSString*) responseContentType
                responseType: (NSString *) responseType
             completionBlock: (void (^)(id, NSError *))completionBlock {
    // setting request serializer
    if ([requestContentType isEqualToString:@"application/json"]) {
        self.requestSerializer = [DUBJSONRequestSerializer serializer];
    }
    else if ([requestContentType isEqualToString:@"application/x-www-form-urlencoded"]) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else if ([requestContentType isEqualToString:@"multipart/form-data"]) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else {
        NSAssert(false, @"unsupport request type %@", requestContentType);
    }

    // setting response serializer
    if ([responseContentType isEqualToString:@"application/json"]) {
        self.responseSerializer = [DUBJSONResponseSerializer serializer];
    }
    else {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }

    // sanitize parameters
    pathParams = [self sanitizeForSerialization:pathParams];
    queryParams = [self sanitizeForSerialization:queryParams];
    headerParams = [self sanitizeForSerialization:headerParams];
    formParams = [self sanitizeForSerialization:formParams];
    body = [self sanitizeForSerialization:body];

    // auth setting
    [self updateHeaderParams:&headerParams queryParams:&queryParams WithAuthSettings:authSettings];

    NSMutableString *resourcePath = [NSMutableString stringWithString:path];
    [pathParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [resourcePath replaceCharactersInRange:[resourcePath rangeOfString:[NSString stringWithFormat:@"%@%@%@", @"{", key, @"}"]]
                                    withString:[DUBApiClient escape:obj]];
    }];

    NSMutableURLRequest * request = nil;

    NSString* pathWithQueryParams = [self pathWithQueryParamsToString:resourcePath queryParams:queryParams];
    if ([pathWithQueryParams hasPrefix:@"/"]) {
        pathWithQueryParams = [pathWithQueryParams substringFromIndex:1];
    }

    NSString* urlString = [[NSURL URLWithString:pathWithQueryParams relativeToURL:self.baseURL] absoluteString];
    if (files.count > 0) {
        request = [self.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                               URLString:urlString
                                                              parameters:nil
                                               constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                   [formParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                                       NSString *objString = [self parameterToString:obj];
                                                       NSData *data = [objString dataUsingEncoding:NSUTF8StringEncoding];
                                                       [formData appendPartWithFormData:data name:key];
                                                   }];
                                                   [files enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                                       NSURL *filePath = (NSURL *)obj;
                                                       [formData appendPartWithFileURL:filePath name:key error:nil];
                                                   }];
                                               } error:nil];
    }
    else {
        if (formParams) {
            request = [self.requestSerializer requestWithMethod:method
                                                      URLString:urlString
                                                     parameters:formParams
                                                          error:nil];
        }
        if (body) {
            request = [self.requestSerializer requestWithMethod:method
                                                      URLString:urlString
                                                     parameters:body
                                                          error:nil];
        }
    }

    // request cache
    BOOL hasHeaderParams = false;
    if (headerParams != nil && [headerParams count] > 0) {
        hasHeaderParams = true;
    }
    if (offlineState) {
        DUBDebugLog(@"%@ cache forced", resourcePath);
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    else if(!hasHeaderParams && [method isEqualToString:@"GET"] && cacheEnabled) {
        DUBDebugLog(@"%@ cache enabled", resourcePath);
        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    }
    else {
        DUBDebugLog(@"%@ cache disabled", resourcePath);
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    }

    if (hasHeaderParams){
        for(NSString * key in [headerParams keyEnumerator]){
            [request setValue:[headerParams valueForKey:key] forHTTPHeaderField:key];
        }
    }
    [self.requestSerializer setValue:responseContentType forHTTPHeaderField:@"Accept"];


    // Always disable cookies!
    [request setHTTPShouldHandleCookies:NO];

    NSNumber* requestId = [DUBApiClient queueRequest];
    if ([responseType isEqualToString:@"NSURL*"]) {
        [self downloadOperationWithCompletionBlock:request requestId:requestId completionBlock:^(id data, NSError *error) {
            completionBlock(data, error);
        }];
    }
    else {
        [self operationWithCompletionBlock:request requestId:requestId completionBlock:^(id data, NSError *error) {
            completionBlock([self deserialize:data class:responseType], error);
        }];
    }
    return requestId;
}

#pragma mark -

- (NSString*) pathWithQueryParamsToString:(NSString*) path
                              queryParams:(NSDictionary*) queryParams {
    NSString * separator = nil;
    int counter = 0;

    NSMutableString * requestUrl = [NSMutableString stringWithFormat:@"%@", path];
    if (queryParams != nil){
        for(NSString * key in [queryParams keyEnumerator]){
            if (counter == 0) separator = @"?";
            else separator = @"&";
            id queryParam = [queryParams valueForKey:key];
            if ([queryParam isKindOfClass:[NSString class]]){
                [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                                          [DUBApiClient escape:key], [DUBApiClient escape:[queryParams valueForKey:key]]]];
            }
            else if ([queryParam isKindOfClass:[DUBQueryParamCollection class]]){
                DUBQueryParamCollection * coll = (DUBQueryParamCollection*) queryParam;
                NSArray* values = [coll values];
                NSString* format = [coll format];

                if ([format isEqualToString:@"csv"]) {
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                        [DUBApiClient escape:key], [NSString stringWithFormat:@"%@", [values componentsJoinedByString:@","]]]];

                }
                else if ([format isEqualToString:@"tsv"]) {
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                        [DUBApiClient escape:key], [NSString stringWithFormat:@"%@", [values componentsJoinedByString:@"\t"]]]];

                }
                else if ([format isEqualToString:@"pipes"]) {
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                        [DUBApiClient escape:key], [NSString stringWithFormat:@"%@", [values componentsJoinedByString:@"|"]]]];

                }
                else if ([format isEqualToString:@"multi"]) {
                    for(id obj in values) {
                        [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                            [DUBApiClient escape:key], [NSString stringWithFormat:@"%@", obj]]];
                        counter += 1;
                    }

                }
            }
            else {
                [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                                          [DUBApiClient escape:key], [NSString stringWithFormat:@"%@", [queryParams valueForKey:key]]]];
            }

            counter += 1;
        }
    }
    return requestUrl;
}

/**
 * Update header and query params based on authentication settings
 */
- (void) updateHeaderParams:(NSDictionary *__autoreleasing *)headers
                queryParams:(NSDictionary *__autoreleasing *)querys
           WithAuthSettings:(NSArray *)authSettings {

    if (!authSettings || [authSettings count] == 0) {
        return;
    }

    NSMutableDictionary *headersWithAuth = [NSMutableDictionary dictionaryWithDictionary:*headers];
    NSMutableDictionary *querysWithAuth = [NSMutableDictionary dictionaryWithDictionary:*querys];

    DUBConfiguration *config = [DUBConfiguration sharedConfig];
    for (NSString *auth in authSettings) {
        NSDictionary *authSetting = [[config authSettings] objectForKey:auth];

        if (authSetting) {
            if ([authSetting[@"in"] isEqualToString:@"header"]) {
                [headersWithAuth setObject:authSetting[@"value"] forKey:authSetting[@"key"]];
            }
            else if ([authSetting[@"in"] isEqualToString:@"query"]) {
                [querysWithAuth setObject:authSetting[@"value"] forKey:authSetting[@"key"]];
            }
        }
    }

    *headers = [NSDictionary dictionaryWithDictionary:headersWithAuth];
    *querys = [NSDictionary dictionaryWithDictionary:querysWithAuth];
}

- (id) sanitizeForSerialization:(id) object {
    if (object == nil) {
        return nil;
    }
    else if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[DUBQueryParamCollection class]]) {
        return object;
    }
    else if ([object isKindOfClass:[NSDate class]]) {
        return [object ISO8601String];
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        NSArray *objectArray = object;
        NSMutableArray *sanitizedObjs = [NSMutableArray arrayWithCapacity:[objectArray count]];
        [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (obj) {
                [sanitizedObjs addObject:[self sanitizeForSerialization:obj]];
            }
        }];
        return sanitizedObjs;
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objectDict = object;
        NSMutableDictionary *sanitizedObjs = [NSMutableDictionary dictionaryWithCapacity:[objectDict count]];
        [object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj) {
                [sanitizedObjs setValue:[self sanitizeForSerialization:obj] forKey:key];
            }
        }];
        return sanitizedObjs;
    }
    else if ([object isKindOfClass:[DUBObject class]]) {
        return [object toDictionary];
    }
    else {
        NSException *e = [NSException
                          exceptionWithName:@"InvalidObjectArgumentException"
                          reason:[NSString stringWithFormat:@"*** The argument object: %@ is invalid", object]
                          userInfo:nil];
        @throw e;
    }
}

- (AFSecurityPolicy *) customSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

    DUBConfiguration *config = [DUBConfiguration sharedConfig];

    if (config.sslCaCert) {
        NSData *certData = [NSData dataWithContentsOfFile:config.sslCaCert];
        [securityPolicy setPinnedCertificates:@[certData]];
    }

    if (config.verifySSL) {
        [securityPolicy setAllowInvalidCertificates:NO];
    }
    else {
        [securityPolicy setAllowInvalidCertificates:YES];
        [securityPolicy setValidatesDomainName:NO];
    }

    return securityPolicy;
}

- (NSString *) parameterToString:(id)param {
    if ([param isKindOfClass:[NSString class]]) {
        return param;
    }
    else if ([param isKindOfClass:[NSNumber class]]) {
        return [param stringValue];
    }
    else if ([param isKindOfClass:[NSDate class]]) {
        return [param ISO8601String];
    }
    else if ([param isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableParam;
        [param enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [mutableParam addObject:[self parameterToString:obj]];
        }];
        return [mutableParam componentsJoinedByString:@","];
    }
    else {
        NSException *e = [NSException
                          exceptionWithName:@"InvalidObjectArgumentException"
                          reason:[NSString stringWithFormat:@"*** The argument object: %@ is invalid", param]
                          userInfo:nil];
        @throw e;
    }
}

@end
