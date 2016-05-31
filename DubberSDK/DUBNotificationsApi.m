#import "DUBNotificationsApi.h"
#import "DUBQueryParamCollection.h"
#import "DUBOpenJson.h"
#import "DUBSingleNotification.h"
#import "DUBError.h"
#import "DUBNotificationList.h"
#import "DUBNotification.h"
#import "DUBUpdateNotification.h"
#import "DUBUnclaimedNotification.h"


@interface DUBNotificationsApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation DUBNotificationsApi

static DUBNotificationsApi* singletonAPI = nil;

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

+(DUBNotificationsApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBNotificationsApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(DUBNotificationsApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBNotificationsApi alloc] init];
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
/// Activate the given notification using Delayed Activation
///  @param notificationId The notification id to activate 
///
///  @param xHookSecret The secret that was sent out with the initial notification post 
///
///  @param body Body is ignored but required for a valid post 
///
///  @returns DUBSingleNotification*
///
-(NSNumber*) activateNotificationWithNotificationId: (NSString*) notificationId
    xHookSecret: (NSString*) xHookSecret
    body: (DUBOpenJson*) body
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler {

    
    // verify the required parameter 'notificationId' is set
    if (notificationId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notificationId` when calling `activateNotification`"];
    }
    
    // verify the required parameter 'xHookSecret' is set
    if (xHookSecret == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `xHookSecret` when calling `activateNotification`"];
    }
    
    // verify the required parameter 'body' is set
    if (body == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `body` when calling `activateNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/notifications/{notification_id}/activate"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (notificationId != nil) {
        pathParams[@"notification_id"] = notificationId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    if (xHookSecret != nil) {
        headerParams[@"X-Hook-Secret"] = xHookSecret;
    }
    

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
    
    bodyParam = body;
    

    
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
                              responseType: @"DUBSingleNotification*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleNotification*)data, error);
                           }
          ];
}

///
/// 
/// Delete the given notification
///  @param notificationId The notification id to delete 
///
///  @returns void
///
-(NSNumber*) deleteNotificationWithNotificationId: (NSString*) notificationId
    completionHandler: (void (^)(NSError* error)) handler {

    
    // verify the required parameter 'notificationId' is set
    if (notificationId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notificationId` when calling `deleteNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/notifications/{notification_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (notificationId != nil) {
        pathParams[@"notification_id"] = notificationId;
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
/// Get the notifications for a given account
///  @param accountId The account id to get notifications for 
///
///  @returns DUBNotificationList*
///
-(NSNumber*) getAccountNotificationsWithAccountId: (NSString*) accountId
    completionHandler: (void (^)(DUBNotificationList* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `getAccountNotifications`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/notifications"];

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
                              responseType: @"DUBNotificationList*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBNotificationList*)data, error);
                           }
          ];
}

///
/// 
/// Get the notifications for a given group
///  @param groupId The group id to get notifications for 
///
///  @returns DUBNotificationList*
///
-(NSNumber*) getGroupNotificationsWithGroupId: (NSString*) groupId
    completionHandler: (void (^)(DUBNotificationList* output, NSError* error)) handler {

    
    // verify the required parameter 'groupId' is set
    if (groupId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `groupId` when calling `getGroupNotifications`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/groups/{group_id}/notifications"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (groupId != nil) {
        pathParams[@"group_id"] = groupId;
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
                              responseType: @"DUBNotificationList*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBNotificationList*)data, error);
                           }
          ];
}

///
/// 
/// Get the details for a given notification
///  @param notificationId The notification id to get 
///
///  @returns DUBSingleNotification*
///
-(NSNumber*) getNotificationWithNotificationId: (NSString*) notificationId
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler {

    
    // verify the required parameter 'notificationId' is set
    if (notificationId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notificationId` when calling `getNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/notifications/{notification_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (notificationId != nil) {
        pathParams[@"notification_id"] = notificationId;
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
                              responseType: @"DUBSingleNotification*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleNotification*)data, error);
                           }
          ];
}

///
/// 
/// Create a new notifications for the given account
///  @param accountId The account id to add notification 
///
///  @param notification The notification details to create 
///
///  @returns DUBSingleNotification*
///
-(NSNumber*) postAccountNotificationWithAccountId: (NSString*) accountId
    notification: (DUBNotification*) notification
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `postAccountNotification`"];
    }
    
    // verify the required parameter 'notification' is set
    if (notification == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notification` when calling `postAccountNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/notifications"];

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
    
    bodyParam = notification;
    

    
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
                              responseType: @"DUBSingleNotification*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleNotification*)data, error);
                           }
          ];
}

///
/// 
/// Create a new notifications for the given group
///  @param groupId The group id to add notification 
///
///  @param notification The notification details to create 
///
///  @returns DUBSingleNotification*
///
-(NSNumber*) postGroupNotificationWithGroupId: (NSString*) groupId
    notification: (DUBNotification*) notification
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler {

    
    // verify the required parameter 'groupId' is set
    if (groupId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `groupId` when calling `postGroupNotification`"];
    }
    
    // verify the required parameter 'notification' is set
    if (notification == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notification` when calling `postGroupNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/groups/{group_id}/notifications"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (groupId != nil) {
        pathParams[@"group_id"] = groupId;
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
    
    bodyParam = notification;
    

    
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
                              responseType: @"DUBSingleNotification*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleNotification*)data, error);
                           }
          ];
}

///
/// 
/// Update the details for a given notification
///  @param notificationId The notification id to update 
///
///  @param notification The notification details to be updated 
///
///  @returns DUBSingleNotification*
///
-(NSNumber*) putNotificationWithNotificationId: (NSString*) notificationId
    notification: (DUBUpdateNotification*) notification
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler {

    
    // verify the required parameter 'notificationId' is set
    if (notificationId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notificationId` when calling `putNotification`"];
    }
    
    // verify the required parameter 'notification' is set
    if (notification == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notification` when calling `putNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/notifications/{notification_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (notificationId != nil) {
        pathParams[@"notification_id"] = notificationId;
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
    
    bodyParam = notification;
    

    
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
                              responseType: @"DUBSingleNotification*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleNotification*)data, error);
                           }
          ];
}

///
/// 
/// Release any unclaimed messages for the given notification
///  @param notificationId The notification id to release unclaimed messages for 
///
///  @returns DUBUnclaimedNotification*
///
-(NSNumber*) unclaimedNotificationWithNotificationId: (NSString*) notificationId
    completionHandler: (void (^)(DUBUnclaimedNotification* output, NSError* error)) handler {

    
    // verify the required parameter 'notificationId' is set
    if (notificationId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `notificationId` when calling `unclaimedNotification`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/notifications/{notification_id}/unclaimed"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (notificationId != nil) {
        pathParams[@"notification_id"] = notificationId;
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
                              responseType: @"DUBUnclaimedNotification*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBUnclaimedNotification*)data, error);
                           }
          ];
}



@end
