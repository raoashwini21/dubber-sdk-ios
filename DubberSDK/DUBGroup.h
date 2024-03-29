#import <Foundation/Foundation.h>
#import "DUBObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "DUBAddress.h"


@protocol DUBGroup
@end

@interface DUBGroup : DUBObject


@property(nonatomic) NSString* self;

@property(nonatomic) NSString* _id;

@property(nonatomic) NSString* name;

@property(nonatomic) NSString* label;

@property(nonatomic) NSString* status;

@property(nonatomic) NSString* timeZone;

@property(nonatomic) DUBAddress* address;

@property(nonatomic) NSString* phone;

@property(nonatomic) NSString* fax;

@property(nonatomic) NSString* dateCreated;

@property(nonatomic) NSString* dateUpdated;

@property(nonatomic) NSDictionary* /* NSString, NSString */ subresourceUris;

@end
