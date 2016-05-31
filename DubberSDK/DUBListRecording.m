#import "DUBListRecording.h"

@implementation DUBListRecording

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
  return [[JSONKeyMapper alloc] initWithDictionary:@{ @"id": @"_id", @"to": @"to", @"to_label": @"toLabel", @"from": @"from", @"from_label": @"fromLabel", @"status": @"status", @"transfers": @"transfers", @"additional_parties": @"additionalParties", @"duration": @"duration", @"call_type": @"callType", @"recording_type": @"recordingType", @"channel": @"channel", @"start_time": @"startTime", @"end_time": @"endTime", @"tags": @"tags", @"metadata": @"metadata", @"meta_tags": @"metaTags", @"date_created": @"dateCreated", @"date_updated": @"dateUpdated", @"self": @"self" }];
}

/**
 * Indicates whether the property with the given name is optional.
 * If `propertyName` is optional, then return `YES`, otherwise return `NO`.
 * This method is used by `JSONModel`.
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
  NSArray *optionalProperties = @[@"_id", @"toLabel", @"fromLabel", @"status", @"transfers", @"additionalParties", @"duration", @"recordingType", @"channel", @"endTime", @"tags", @"metadata", @"metaTags", @"dateCreated", @"dateUpdated", @"self"];

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
