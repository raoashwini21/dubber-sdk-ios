#import "DUBOAuthApi.h"
#import "DUBQueryParamCollection.h"
#import "DUBError.h"


@interface DUBOAuthApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation DUBOAuthApi

static DUBOAuthApi* singletonAPI = nil;

#pragma mark - Initialize methods

- (id) init {
    self = [super init];
    if (self) {
        DUBConfiguration *config = [DUBConfiguration sharedConfig];
        if (config.apiClient == nil) {
            config.apiClient = [[DUBApiClient alloc] init];
        }
        self.apiClient = config.apiClient;
        self.defaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id) initWithApiClient:(DUBApiClient *)apiClient {
    self = [super init];
    if (self) {
        self.apiClient = apiClient;
        self.defaultHeaders = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -

+(DUBOAuthApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBOAuthApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(DUBOAuthApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBOAuthApi alloc] init];
    }
    return singletonAPI;
}

-(void) addHeader:(NSString*)value forKey:(NSString*)key {
    [self.defaultHeaders setValue:value forKey:key];
}

-(void) setHeaderValue:(NSString*) value
           forKey:(NSString*)key {
    [self.defaultHeaders setValue:value forKey:key];
}

-(unsigned long) requestQueueSize {
    return [DUBApiClient requestQueueSize];
}

#pragma mark - Api Methods

///
/// 
/// Revoke an OAuth 2.0 token
///  @param token The token to revoke 
///
///  @param clientId The client id associated with the token 
///
///  @returns void
///
-(NSNumber*) revokeTokenWithToken: (NSString*) token
    clientId: (NSString*) clientId
    completionHandler: (void (^)(NSError* error)) handler {

    
    // verify the required parameter 'token' is set
    if (token == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `token` when calling `revokeToken`"];
    }
    
    // verify the required parameter 'clientId' is set
    if (clientId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `clientId` when calling `revokeToken`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/revoke"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Accept"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [DUBApiClient selectHeaderContentType:@[@"application/x-www-form-urlencoded"]];

    // Authentication setting
    NSArray *authSettings = @[];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    
    
    if (token) {
        formParams[@"token"] = token;
    }
    
    
    
    if (clientId) {
        formParams[@"client_id"] = clientId;
    }
    
    
    

    
    return [self.apiClient requestWithPath: resourcePath
                                    method: @"POST"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: nil
                           completionBlock: ^(id data, NSError *error) {
                               handler(error);
                           }
          ];
}



@end
