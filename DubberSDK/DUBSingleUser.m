#import "DUBSingleUser.h"

@implementation DUBSingleUser

- (instancetype)init {
  self = [super init];

  if (self) {
    // initalise property's default value, if any
    
  }

  return self;
}


/**
 * Maps json key to property name.
 * This method is used by `JSONModel`.
 */
+ (JSONKeyMapper *)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"self": @"self", @"id": @"_id", @"role": @"role", @"username": @"username", @"first_name": @"firstName", @"last_name": @"lastName", @"confirmed": @"confirmed", @"mobile_number": @"mobileNumber", @"language": @"language", @"date_created": @"dateCreated", @"date_updated": @"dateUpdated", @"account": @"account" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"self", @"_id", @"username", @"confirmed", @"mobileNumber", @"language", @"dateCreated", @"dateUpdated", @"account"];

  if ([optionalProperties containsObject:propertyName]) {
    return YES;
  }
  else {
    return NO;
  }
}

/**
 * Gets the string presentation of the object.
 * This method will be called when logging model object using `NSLog`.
 */
- (NSString *)description {
    return [[self toDictionary] description];
}

@end
