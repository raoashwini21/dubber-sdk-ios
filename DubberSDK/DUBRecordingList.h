#import <Foundation/Foundation.h>
#import "DUBObject.h"

/**
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen
 * Do not edit the class manually.
 */

#import "DUBListRecording.h"


@protocol DUBRecordingList
@end

@interface DUBRecordingList : DUBObject


@property(nonatomic) NSString* self;

@property(nonatomic) NSArray<DUBListRecording>* recordings;
/* If there are any additional recordings not returned when using before_recording and after_recording [optional]
 */
@property(nonatomic) NSNumber* gap;

@end
