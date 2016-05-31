#import "DUBSingleAccount.h"

@implementation DUBSingleAccount

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"self": @"self", @"id": @"_id", @"name": @"name", @"group": @"group", @"status": @"status", @"dubber_address": @"dubberAddress", @"time_zone": @"timeZone", @"address": @"address", @"phone": @"phone", @"metadata": @"metadata", @"date_created": @"dateCreated", @"date_updated": @"dateUpdated", @"subresource_uris": @"subresourceUris" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"self", @"_id", @"group", @"status", @"metadata", @"dateCreated", @"dateUpdated", @"subresourceUris"];

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
