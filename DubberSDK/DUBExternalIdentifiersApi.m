#import "DUBExternalIdentifiersApi.h"
#import "DUBQueryParamCollection.h"
#import "DUBError.h"
#import "DUBFindExternalIdentifier.h"
#import "DUBExternalIdentifier.h"
#import "DUBUpdateExternalIdentifier.h"


@interface DUBExternalIdentifiersApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation DUBExternalIdentifiersApi

static DUBExternalIdentifiersApi* singletonAPI = nil;

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

+(DUBExternalIdentifiersApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBExternalIdentifiersApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(DUBExternalIdentifiersApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBExternalIdentifiersApi alloc] init];
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
/// Deletes the given external identifier (group authentication required)
///  @param externalIdentifierId The external identifier id to delete 
///
///  @returns void
///
-(NSNumber*) deleteExternalIdentifierWithExternalIdentifierId: (NSString*) externalIdentifierId
    completionHandler: (void (^)(NSError* error)) handler {

    
    // verify the required parameter 'externalIdentifierId' is set
    if (externalIdentifierId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `externalIdentifierId` when calling `deleteExternalIdentifier`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/external_identifiers/{external_identifier_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (externalIdentifierId != nil) {
        pathParams[@"external_identifier_id"] = externalIdentifierId;
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
    NSArray *authSettings = @[@"password_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    
    

    
    return [self.apiClient requestWithPath: resourcePath
                                    method: @"DELETE"
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

///
/// 
/// Find a resource based on an external identifier (group authentication required)
///  @param externalType The external type of the external identifier to find 
///
///  @param serviceProvider The service provider of the external identifier to find 
///
///  @param identifier The identifier of the external identifier to find 
///
///  @returns DUBFindExternalIdentifier*
///
-(NSNumber*) findExternalIdentifierWithExternalType: (NSString*) externalType
    serviceProvider: (NSString*) serviceProvider
    identifier: (NSString*) identifier
    completionHandler: (void (^)(DUBFindExternalIdentifier* output, NSError* error)) handler {

    
    // verify the required parameter 'externalType' is set
    if (externalType == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `externalType` when calling `findExternalIdentifier`"];
    }
    
    // verify the required parameter 'serviceProvider' is set
    if (serviceProvider == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `serviceProvider` when calling `findExternalIdentifier`"];
    }
    
    // verify the required parameter 'identifier' is set
    if (identifier == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `identifier` when calling `findExternalIdentifier`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/external_identifiers/find"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (externalType != nil) {
        
        queryParams[@"external_type"] = externalType;
    }
    if (serviceProvider != nil) {
        
        queryParams[@"service_provider"] = serviceProvider;
    }
    if (identifier != nil) {
        
        queryParams[@"identifier"] = identifier;
    }
    
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
    NSArray *authSettings = @[@"password_flow"];

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
                              responseType: @"DUBFindExternalIdentifier*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBFindExternalIdentifier*)data, error);
                           }
          ];
}

///
/// 
/// Get the details for a given external identifier (group authentication required)
///  @param externalIdentifierId The external identifier id to get 
///
///  @returns DUBExternalIdentifier*
///
-(NSNumber*) getExternalIdentifierWithExternalIdentifierId: (NSString*) externalIdentifierId
    completionHandler: (void (^)(DUBExternalIdentifier* output, NSError* error)) handler {

    
    // verify the required parameter 'externalIdentifierId' is set
    if (externalIdentifierId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `externalIdentifierId` when calling `getExternalIdentifier`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/external_identifiers/{external_identifier_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (externalIdentifierId != nil) {
        pathParams[@"external_identifier_id"] = externalIdentifierId;
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
    NSArray *authSettings = @[@"password_flow"];

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
                              responseType: @"DUBExternalIdentifier*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBExternalIdentifier*)data, error);
                           }
          ];
}

///
/// 
/// Create a new external identifier for a user (group authentication required)
///  @param userId The user id to add external identifier to 
///
///  @param externalIdentifier The external identifier details to create 
///
///  @returns DUBExternalIdentifier*
///
-(NSNumber*) postExternalIdentifierWithUserId: (NSString*) userId
    externalIdentifier: (DUBExternalIdentifier*) externalIdentifier
    completionHandler: (void (^)(DUBExternalIdentifier* output, NSError* error)) handler {

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `postExternalIdentifier`"];
    }
    
    // verify the required parameter 'externalIdentifier' is set
    if (externalIdentifier == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `externalIdentifier` when calling `postExternalIdentifier`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/users/{user_id}/external_identifiers"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (userId != nil) {
        pathParams[@"user_id"] = userId;
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
    NSArray *authSettings = @[@"password_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    bodyParam = externalIdentifier;
    

    
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
                              responseType: @"DUBExternalIdentifier*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBExternalIdentifier*)data, error);
                           }
          ];
}

///
/// 
/// Update the details for a given external identifier (group authentication required)
///  @param externalIdentifierId The external identifier id to update 
///
///  @param externalIdentifier The external identifier details to be updated 
///
///  @returns DUBExternalIdentifier*
///
-(NSNumber*) putExternalIdentifierWithExternalIdentifierId: (NSString*) externalIdentifierId
    externalIdentifier: (DUBUpdateExternalIdentifier*) externalIdentifier
    completionHandler: (void (^)(DUBExternalIdentifier* output, NSError* error)) handler {

    
    // verify the required parameter 'externalIdentifierId' is set
    if (externalIdentifierId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `externalIdentifierId` when calling `putExternalIdentifier`"];
    }
    
    // verify the required parameter 'externalIdentifier' is set
    if (externalIdentifier == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `externalIdentifier` when calling `putExternalIdentifier`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/external_identifiers/{external_identifier_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (externalIdentifierId != nil) {
        pathParams[@"external_identifier_id"] = externalIdentifierId;
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
    NSArray *authSettings = @[@"password_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    bodyParam = externalIdentifier;
    

    
    return [self.apiClient requestWithPath: resourcePath
                                    method: @"PUT"
                                pathParams: pathParams
                               queryParams: queryParams
                                formParams: formParams
                                     files: localVarFiles
                                      body: bodyParam
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                              responseType: @"DUBExternalIdentifier*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBExternalIdentifier*)data, error);
                           }
          ];
}



@end
