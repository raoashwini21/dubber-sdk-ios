#import <Foundation/Foundation.h>
#import "DUBError.h"
#import "DUBObject.h"
#import "DUBApiClient.h"


/**
 * NOTE: This class is auto generated by the swagger code generator program. 
 * https://github.com/swagger-api/swagger-codegen 
 * Do not edit the class manually.
 */

@interface DUBProfileApi: NSObject

@property(nonatomic, assign)DUBApiClient *apiClient;

-(instancetype) initWithApiClient:(DUBApiClient *)apiClient;
-(void) addHeader:(NSString*)value forKey:(NSString*)key;
-(unsigned long) requestQueueSize;
+(DUBProfileApi*) apiWithHeader:(NSString*)headerValue key:(NSString*)key;
+(DUBProfileApi*) sharedAPI;
///
///
/// 
/// Get the details for the currently authenticated resource
///
/// 
///
/// @return NSDictionary* /* NSString, NSString */
-(NSNumber*) getProfileWithCompletionHandler: 
    (void (^)(NSDictionary* /* NSString, NSString */ output, NSError* error)) handler;



@end