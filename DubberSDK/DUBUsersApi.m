#import "DUBUsersApi.h"
#import "DUBQueryParamCollection.h"
#import "DUBError.h"
#import "DUBUserList.h"
#import "DUBSingleUser.h"
#import "DUBUser.h"
#import "DUBUpdateUser.h"


@interface DUBUsersApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation DUBUsersApi

static DUBUsersApi* singletonAPI = nil;

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

+(DUBUsersApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBUsersApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(DUBUsersApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBUsersApi alloc] init];
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
/// Deletes the given user
///  @param userId The user id to delete 
///
///  @returns void
///
-(NSNumber*) deleteUserWithUserId: (NSString*) userId
    completionHandler: (void (^)(NSError* error)) handler {

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `deleteUser`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/users/{user_id}"];

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
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow", @"password_flow"];

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
/// Get the users for a given account
///  @param accountId The account id to get users for 
///
///  @returns DUBUserList*
///
-(NSNumber*) getAccountUsersWithAccountId: (NSString*) accountId
    completionHandler: (void (^)(DUBUserList* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `getAccountUsers`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/users"];

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
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow", @"password_flow"];

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
                              responseType: @"DUBUserList*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBUserList*)data, error);
                           }
          ];
}

///
/// 
/// Get the details for a given user
///  @param userId The user id to get 
///
///  @returns DUBSingleUser*
///
-(NSNumber*) getUserWithUserId: (NSString*) userId
    completionHandler: (void (^)(DUBSingleUser* output, NSError* error)) handler {

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `getUser`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/users/{user_id}"];

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
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow", @"password_flow"];

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
                              responseType: @"DUBSingleUser*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleUser*)data, error);
                           }
          ];
}

///
/// 
/// Create a new user in the given account
///  @param accountId The account id to create the user in 
///
///  @param user Details of the user to create 
///
///  @returns DUBSingleUser*
///
-(NSNumber*) postAccountUsersWithAccountId: (NSString*) accountId
    user: (DUBUser*) user
    completionHandler: (void (^)(DUBSingleUser* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `postAccountUsers`"];
    }
    
    // verify the required parameter 'user' is set
    if (user == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `user` when calling `postAccountUsers`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/users"];

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
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow", @"password_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    bodyParam = user;
    

    
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
                              responseType: @"DUBSingleUser*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleUser*)data, error);
                           }
          ];
}

///
/// 
/// Update the details for a given user
///  @param userId The user id to update 
///
///  @param user The user details to be updated 
///
///  @returns DUBSingleUser*
///
-(NSNumber*) putUserWithUserId: (NSString*) userId
    user: (DUBUpdateUser*) user
    completionHandler: (void (^)(DUBSingleUser* output, NSError* error)) handler {

    
    // verify the required parameter 'userId' is set
    if (userId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `userId` when calling `putUser`"];
    }
    
    // verify the required parameter 'user' is set
    if (user == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `user` when calling `putUser`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/users/{user_id}"];

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
    NSArray *authSettings = @[@"authorization_code_flow", @"implicit_flow", @"password_flow"];

    id bodyParam = nil;
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *localVarFiles = [[NSMutableDictionary alloc] init];
    
    bodyParam = user;
    

    
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
                              responseType: @"DUBSingleUser*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleUser*)data, error);
                           }
          ];
}



@end
