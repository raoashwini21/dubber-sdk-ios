#import "DUBRecordingsApi.h"
#import "DUBQueryParamCollection.h"
#import "DUBError.h"
#import "DUBSingleRecording.h"
#import "DUBRecordingList.h"
#import "DUBPostRecording.h"
#import "DUBRecordingTags.h"


@interface DUBRecordingsApi ()
    @property (readwrite, nonatomic, strong) NSMutableDictionary *defaultHeaders;
@end

@implementation DUBRecordingsApi

static DUBRecordingsApi* singletonAPI = nil;

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

+(DUBRecordingsApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBRecordingsApi alloc] init];
        [singletonAPI addHeader:headerValue forKey:key];
    }
    return singletonAPI;
}

+(DUBRecordingsApi*) sharedAPI {

    if (singletonAPI == nil) {
        singletonAPI = [[DUBRecordingsApi alloc] init];
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
/// Deletes the given recording
///  @param recordingId The recording id to delete 
///
///  @returns void
///
-(NSNumber*) deleteRecordingWithRecordingId: (NSString*) recordingId
    completionHandler: (void (^)(NSError* error)) handler {

    
    // verify the required parameter 'recordingId' is set
    if (recordingId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recordingId` when calling `deleteRecording`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/recordings/{recording_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (recordingId != nil) {
        pathParams[@"recording_id"] = recordingId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
/// Remove all tags for a recording
///  @param recordingId The recording id to remove tags from 
///
///  @returns DUBSingleRecording*
///
-(NSNumber*) deleteRecordingTagsWithRecordingId: (NSString*) recordingId
    completionHandler: (void (^)(DUBSingleRecording* output, NSError* error)) handler {

    
    // verify the required parameter 'recordingId' is set
    if (recordingId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recordingId` when calling `deleteRecordingTags`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/recordings/{recording_id}/tags"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (recordingId != nil) {
        pathParams[@"recording_id"] = recordingId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
                              responseType: @"DUBSingleRecording*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleRecording*)data, error);
                           }
          ];
}

///
/// 
/// Get the recordings for a given account
///  @param accountId The account id to get recordings for 
///
///  @param query A search query to find matching recordings (optional)
///
///  @param number A number to match for recordings 'to' or 'from' value (optional)
///
///  @param count The max count of recordings to return (optional)
///
///  @param afterId The recording id to get all recordings after, must be used in conjunction with before_id (optional)
///
///  @param beforeId The recording id to get all recordings before, must be used in conjunction with after_id (optional)
///
///  @param page The page of recordings to return, cannot be used with before_id/after_id (optional)
///
///  @returns DUBRecordingList*
///
-(NSNumber*) getAccountRecordingsWithAccountId: (NSString*) accountId
    query: (NSString*) query
    number: (NSString*) number
    count: (NSNumber*) count
    afterId: (NSString*) afterId
    beforeId: (NSString*) beforeId
    page: (NSNumber*) page
    completionHandler: (void (^)(DUBRecordingList* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `getAccountRecordings`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/recordings"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (accountId != nil) {
        pathParams[@"account_id"] = accountId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (query != nil) {
        
        queryParams[@"query"] = query;
    }
    if (number != nil) {
        
        queryParams[@"number"] = number;
    }
    if (count != nil) {
        
        queryParams[@"count"] = count;
    }
    if (afterId != nil) {
        
        queryParams[@"after_id"] = afterId;
    }
    if (beforeId != nil) {
        
        queryParams[@"before_id"] = beforeId;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
                              responseType: @"DUBRecordingList*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBRecordingList*)data, error);
                           }
          ];
}

///
/// 
/// Get the details for a given recording
///  @param recordingId The recording id to get 
///
///  @param listener Url encoded email address of listener for the recording, will default to current user with authorization code/implicit flows. If not provided with password flow recording_url will not be returned (optional)
///
///  @returns DUBSingleRecording*
///
-(NSNumber*) getRecordingWithRecordingId: (NSString*) recordingId
    listener: (NSString*) listener
    completionHandler: (void (^)(DUBSingleRecording* output, NSError* error)) handler {

    
    // verify the required parameter 'recordingId' is set
    if (recordingId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recordingId` when calling `getRecording`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/recordings/{recording_id}"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (recordingId != nil) {
        pathParams[@"recording_id"] = recordingId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (listener != nil) {
        
        queryParams[@"listener"] = listener;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
                              responseType: @"DUBRecordingList*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBRecordingList*)data, error);
                           }
          ];
}

///
/// 
/// Get the unidentified recordings for a given group (group authentication required)
///  @param groupId The group id to get unidentified recordings for 
///
///  @param query A search query to find matching recordings (optional)
///
///  @param number A number to match for recordings 'to' or 'from' value (optional)
///
///  @param count The max count of recordings to return (optional)
///
///  @param afterId The recording id to get all recordings after, must be used in conjunction with before_id (optional)
///
///  @param beforeId The recording id to get all recordings before, must be used in conjunction with after_id (optional)
///
///  @param page The page of recordings to return, cannot be used with before_id/after_id (optional)
///
///  @returns DUBRecordingList*
///
-(NSNumber*) getUnidentifiedRecordingsWithGroupId: (NSString*) groupId
    query: (NSString*) query
    number: (NSString*) number
    count: (NSNumber*) count
    afterId: (NSString*) afterId
    beforeId: (NSString*) beforeId
    page: (NSNumber*) page
    completionHandler: (void (^)(DUBRecordingList* output, NSError* error)) handler {

    
    // verify the required parameter 'groupId' is set
    if (groupId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `groupId` when calling `getUnidentifiedRecordings`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/groups/{group_id}/unidentified_recordings"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (groupId != nil) {
        pathParams[@"group_id"] = groupId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if (query != nil) {
        
        queryParams[@"query"] = query;
    }
    if (number != nil) {
        
        queryParams[@"number"] = number;
    }
    if (count != nil) {
        
        queryParams[@"count"] = count;
    }
    if (afterId != nil) {
        
        queryParams[@"after_id"] = afterId;
    }
    if (beforeId != nil) {
        
        queryParams[@"before_id"] = beforeId;
    }
    if (page != nil) {
        
        queryParams[@"page"] = page;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
                              responseType: @"DUBRecordingList*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBRecordingList*)data, error);
                           }
          ];
}

///
/// 
/// Create a new recording in the given account
///  @param accountId The account id to create the recording in 
///
///  @param recording Details of the recording to create 
///
///  @returns DUBSingleRecording*
///
-(NSNumber*) postAccountRecordingWithAccountId: (NSString*) accountId
    recording: (DUBPostRecording*) recording
    completionHandler: (void (^)(DUBSingleRecording* output, NSError* error)) handler {

    
    // verify the required parameter 'accountId' is set
    if (accountId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `accountId` when calling `postAccountRecording`"];
    }
    
    // verify the required parameter 'recording' is set
    if (recording == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recording` when calling `postAccountRecording`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/accounts/{account_id}/recordings"];

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
    
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    
    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
    
    bodyParam = recording;
    
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
                              responseType: @"DUBSingleRecording*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleRecording*)data, error);
                           }
            ];

}

///
/// 
/// Create tags for a recording, overrides any existing tags
///  @param recordingId The recording id to create tags for 
///
///  @param tags The tags to create 
///
///  @returns DUBSingleRecording*
///
-(NSNumber*) postRecordingTagsWithRecordingId: (NSString*) recordingId
    tags: (DUBRecordingTags*) tags
    completionHandler: (void (^)(DUBSingleRecording* output, NSError* error)) handler {

    
    // verify the required parameter 'recordingId' is set
    if (recordingId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recordingId` when calling `postRecordingTags`"];
    }
    
    // verify the required parameter 'tags' is set
    if (tags == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `tags` when calling `postRecordingTags`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/recordings/{recording_id}/tags"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (recordingId != nil) {
        pathParams[@"recording_id"] = recordingId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
    
    bodyParam = tags;
    
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
                              responseType: @"DUBSingleRecording*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleRecording*)data, error);
                           }
          ];
}

///
/// 
/// Create a new unidentified recording in the given group
///  @param groupId The group id to create the unidentified recording in 
///
///  @param recording Details of the recording to create 
///
///  @returns DUBSingleRecording*
///
-(NSNumber*) postUnidentifiedRecordingWithGroupId: (NSString*) groupId
    recording: (DUBPostRecording*) recording
    completionHandler: (void (^)(DUBSingleRecording* output, NSError* error)) handler {

    
    // verify the required parameter 'groupId' is set
    if (groupId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `groupId` when calling `postUnidentifiedRecording`"];
    }
    
    // verify the required parameter 'recording' is set
    if (recording == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recording` when calling `postUnidentifiedRecording`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/groups/{group_id}/unidentified_recordings"];

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
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
    
    bodyParam = recording;
    

    
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
                              responseType: @"DUBSingleRecording*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleRecording*)data, error);
                           }
          ];
}

///
/// 
/// Deletes the details for a given recording
///  @param recordingId The recording id to update metadata 
///
///  @param metadata The metadata to update 
///
///  @returns DUBSingleRecording*
///
-(NSNumber*) putRecordingMetadataWithRecordingId: (NSString*) recordingId
    metadata: (NSObject*) metadata
    completionHandler: (void (^)(DUBSingleRecording* output, NSError* error)) handler {

    
    // verify the required parameter 'recordingId' is set
    if (recordingId == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `recordingId` when calling `putRecordingMetadata`"];
    }
    
    // verify the required parameter 'metadata' is set
    if (metadata == nil) {
        [NSException raise:@"Invalid parameter" format:@"Missing the required parameter `metadata` when calling `putRecordingMetadata`"];
    }
    

    NSMutableString* resourcePath = [NSMutableString stringWithFormat:@"/v1/recordings/{recording_id}/metadata"];

    // remove format in URL if needed
    if ([resourcePath rangeOfString:@".{format}"].location != NSNotFound) {
        [resourcePath replaceCharactersInRange: [resourcePath rangeOfString:@".{format}"] withString:@".json"];
    }

    NSMutableDictionary *pathParams = [[NSMutableDictionary alloc] init];
    if (recordingId != nil) {
        pathParams[@"recording_id"] = recordingId;
    }
    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionaryWithDictionary:self.defaultHeaders];

    

    // HTTP header `Accept`
    headerParams[@"Content-Type"] = [DUBApiClient selectHeaderAccept:@[@"application/json"]];
    if ([headerParams[@"Content-Type"] length] == 0) {
        [headerParams removeObjectForKey:@"Content-Type"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Content-Type"]) {
        responseContentType = [headerParams[@"Content-Type"] componentsSeparatedByString:@", "][0];
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
    
    bodyParam = metadata;
    

    
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
                              responseType: @"DUBSingleRecording*"
                           completionBlock: ^(id data, NSError *error) {
                               handler((DUBSingleRecording*)data, error);
                           }
          ];
}



@end
