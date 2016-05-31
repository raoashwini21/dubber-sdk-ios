#import "DUBCallsApi.h"
#import "DUBQueryParamCollection.h"
#import "DUBCallConfiguration.h"
#import "DUBError.h"
#import "DUBCall.h"


@interface DUBCallsApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation DUBCallsApi

static DUBCallsApi* singletonAPI = nil;

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

+(DUBCallsApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBCallsApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(DUBCallsApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBCallsApi alloc] init];
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
/// Get the call configuration for WebRTC client
///  @param accountId The account id to get call configuration for 
///
///  @returns DUBCallConfiguration*
///
-(NSNumber*) getCallConfigurationWithAccountId: (NSString*) accountId
    completionHandler: (void (^)(DUBCallConfiguration* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `getCallConfiguration`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/calls/config"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (accountId != nil) {
        pathParams[@"account_id"] = accountId;
    }
    

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
    NSString *requestContentType = [DUBApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithPath: resourcePath
                                    method: @"GET"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"DUBCallConfiguration*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBCallConfiguration*)data, error);
                           }
          ];
}

///
/// 
/// Create a new call
///  @param accountId The account id to create call in 
///
///  @param call The call details to create 
///
///  @returns DUBCall*
///
-(NSNumber*) postCallWithAccountId: (NSString*) accountId
    call: (DUBCall*) call
    completionHandler: (void (^)(DUBCall* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `postCall`"];
    }
    
    // verify the required parameter 'call' is set
    if (call == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `call` when calling `postCall`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/calls"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (accountId != nil) {
        pathParams[@"account_id"] = accountId;
    }
    

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
    NSString *requestContentType = [DUBApiClient selectHeaderContentType:@[@"application/json"]];

    // Authentication setting
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    bodyParam = call;
    

    
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
                              responseType: @"DUBCall*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBCall*)data, error);
                           }
          ];
}



@end
