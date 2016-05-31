#import <Foundation/Foundation.h>
#import "DUBSingleAccount.h"
#import "DUBError.h"
#import "DUBAccount.h"
#import "DUBUpdateAccount.h"
#import "DUBObject.h"
#import "DUBApiClient.h"


/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */

@interface DUBAccountsApi: NSObject

@property(nonatomic, assign)DUBApiClient *apiClient;

-(instancetype) initWithApiClient:(DUBApiClient *)apiClient;
-(void) addHeader:(NSString*)value forKey:(NSString*)key;
-(unsigned long) requestQueueSize;
+(DUBAccountsApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key;
+(DUBAccountsApi*) sharedAPI;
///
///
/// 
/// Get the details for a given account
///
/// @param accountId The account id to get
/// 
///
/// @return DUBSingleAccount*
-(NSNumber*) getAccountWithAccountId: (NSString*) accountId
    completionHandler: (void (^)(DUBSingleAccount* output, NSError* error)) handler;


///
///
/// 
/// Create a new account (group authentication required)
///
/// @param account The account details to create
/// 
///
/// @return DUBSingleAccount*
-(NSNumber*) postAccountWithAccount: (DUBAccount*) account
    completionHandler: (void (^)(DUBSingleAccount* output, NSError* error)) handler;


///
///
/// 
/// Update the details for a given account
///
/// @param accountId The account id to update
/// @param account The account details to be updated, NB: if the address element is included all valid address attributes must also be included
/// 
///
/// @return DUBSingleAccount*
-(NSNumber*) putAccountWithAccountId: (NSString*) accountId
    account: (DUBUpdateAccount*) account
    completionHandler: (void (^)(DUBSingleAccount* output, NSError* error)) handler;



@end
