#import <Foundation/Foundation.h>
#import "DUBObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "DUBErrorDetails.h"


@protocol DUBError
@end

@interface DUBError : DUBObject


@property(nonatomic) NSNumber* status;

@property(nonatomic) NSString* message;

@property(nonatomic) NSNumber* code;

@property(nonatomic) NSArray<DUBErrorDetails>* details;

@end