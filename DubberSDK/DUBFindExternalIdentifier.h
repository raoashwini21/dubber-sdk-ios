#import <Foundation/Foundation.h>
#import "DUBObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "DUBExternalIdentifier.h"
#import "DUBIdentifiedResource.h"


@protocol DUBFindExternalIdentifier
@end

@interface DUBFindExternalIdentifier : DUBExternalIdentifier


@property(nonatomic) NSString* self;

@property(nonatomic) NSString* user;

@property(nonatomic) NSString* _id;

@property(nonatomic) NSString* externalType;

@property(nonatomic) NSString* serviceProvider;

@property(nonatomic) NSString* identifier;

@property(nonatomic) DUBIdentifiedResource* identifiedResource;

@end