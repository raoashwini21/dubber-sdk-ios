#import <Foundation/Foundation.h>
#import "DUBOpenJson.h"
#import "DUBSingleNotification.h"
#import "DUBError.h"
#import "DUBNotificationList.h"
#import "DUBNotification.h"
#import "DUBUpdateNotification.h"
#import "DUBUnclaimedNotification.h"
#import "DUBObject.h"
#import "DUBApiClient.h"


/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */

@interface DUBNotificationsApi: NSObject

@property(nonatomic, assign)DUBApiClient *apiClient;

-(instancetype) initWithApiClient:(DUBApiClient *)apiClient;
-(void) addHeader:(NSString*)value forKey:(NSString*)key;
-(unsigned long) requestQueueSize;
+(DUBNotificationsApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key;
+(DUBNotificationsApi*) sharedAPI;
///
///
/// 
/// Activate the given notification using Delayed Activation
///
/// @param notificationId The notification id to activate
/// @param xHookSecret The secret that was sent out with the initial notification post
/// @param body Body is ignored but required for a valid post
/// 
///
/// @return DUBSingleNotification*
-(NSNumber*) activateNotificationWithNotificationId: (NSString*) notificationId
    xHookSecret: (NSString*) xHookSecret
    body: (DUBOpenJson*) body
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler;


///
///
/// 
/// Delete the given notification
///
/// @param notificationId The notification id to delete
/// 
///
/// @return 
-(NSNumber*) deleteNotificationWithNotificationId: (NSString*) notificationId
    completionHandler: (void (^)(NSError* error)) handler;


///
///
/// 
/// Get the notifications for a given account
///
/// @param accountId The account id to get notifications for
/// 
///
/// @return DUBNotificationList*
-(NSNumber*) getAccountNotificationsWithAccountId: (NSString*) accountId
    completionHandler: (void (^)(DUBNotificationList* output, NSError* error)) handler;


///
///
/// 
/// Get the notifications for a given group
///
/// @param groupId The group id to get notifications for
/// 
///
/// @return DUBNotificationList*
-(NSNumber*) getGroupNotificationsWithGroupId: (NSString*) groupId
    completionHandler: (void (^)(DUBNotificationList* output, NSError* error)) handler;


///
///
/// 
/// Get the details for a given notification
///
/// @param notificationId The notification id to get
/// 
///
/// @return DUBSingleNotification*
-(NSNumber*) getNotificationWithNotificationId: (NSString*) notificationId
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler;


///
///
/// 
/// Create a new notifications for the given account
///
/// @param accountId The account id to add notification
/// @param notification The notification details to create
/// 
///
/// @return DUBSingleNotification*
-(NSNumber*) postAccountNotificationWithAccountId: (NSString*) accountId
    notification: (DUBNotification*) notification
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler;


///
///
/// 
/// Create a new notifications for the given group
///
/// @param groupId The group id to add notification
/// @param notification The notification details to create
/// 
///
/// @return DUBSingleNotification*
-(NSNumber*) postGroupNotificationWithGroupId: (NSString*) groupId
    notification: (DUBNotification*) notification
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler;


///
///
/// 
/// Update the details for a given notification
///
/// @param notificationId The notification id to update
/// @param notification The notification details to be updated
/// 
///
/// @return DUBSingleNotification*
-(NSNumber*) putNotificationWithNotificationId: (NSString*) notificationId
    notification: (DUBUpdateNotification*) notification
    completionHandler: (void (^)(DUBSingleNotification* output, NSError* error)) handler;


///
///
/// 
/// Release any unclaimed messages for the given notification
///
/// @param notificationId The notification id to release unclaimed messages for
/// 
///
/// @return DUBUnclaimedNotification*
-(NSNumber*) unclaimedNotificationWithNotificationId: (NSString*) notificationId
    completionHandler: (void (^)(DUBUnclaimedNotification* output, NSError* error)) handler;



@end
