#import <Foundation/Foundation.h>
#import "DUBError.h"
#import "DUBUserList.h"
#import "DUBSingleUser.h"
#import "DUBUser.h"
#import "DUBUpdateUser.h"
#import "DUBObject.h"
#import "DUBApiClient.h"


/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */

@interface DUBUsersApi: NSObject

@property(nonatomic, assign)DUBApiClient *apiClient;

-(instancetype) initWithApiClient:(DUBApiClient *)apiClient;
-(void) addHeader:(NSString*)value forKey:(NSString*)key;
-(unsigned long) requestQueueSize;
+(DUBUsersApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key;
+(DUBUsersApi*) sharedAPI;
///
///
/// 
/// Deletes the given user
///
/// @param userId The user id to delete
/// 
///
/// @return 
-(NSNumber*) deleteUserWithUserId: (NSString*) userId
    completionHandler: (void (^)(NSError* error)) handler;


///
///
/// 
/// Get the users for a given account
///
/// @param accountId The account id to get users for
/// 
///
/// @return DUBUserList*
-(NSNumber*) getAccountUsersWithAccountId: (NSString*) accountId
    completionHandler: (void (^)(DUBUserList* output, NSError* error)) handler;


///
///
/// 
/// Get the details for a given user
///
/// @param userId The user id to get
/// 
///
/// @return DUBSingleUser*
-(NSNumber*) getUserWithUserId: (NSString*) userId
    completionHandler: (void (^)(DUBSingleUser* output, NSError* error)) handler;


///
///
/// 
/// Create a new user in the given account
///
/// @param accountId The account id to create the user in
/// @param user Details of the user to create
/// 
///
/// @return DUBSingleUser*
-(NSNumber*) postAccountUsersWithAccountId: (NSString*) accountId
    user: (DUBUser*) user
    completionHandler: (void (^)(DUBSingleUser* output, NSError* error)) handler;


///
///
/// 
/// Update the details for a given user
///
/// @param userId The user id to update
/// @param user The user details to be updated
/// 
///
/// @return DUBSingleUser*
-(NSNumber*) putUserWithUserId: (NSString*) userId
    user: (DUBUpdateUser*) user
    completionHandler: (void (^)(DUBSingleUser* output, NSError* error)) handler;



@end
