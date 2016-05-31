# Dubber SDK for iOS
IOS SDK for Dubber RESTfull APIs

## Frameworks supported
- Xcode Version 7 or later
- Cocoapods version 0.38.2 or later
- ios version 9

## Dependencies
- AFNetworking 2.3
- JSONModel 1.1
- ISO8601 0.3

## Installation (if `pod` in not installed)

  1. Open terminal and goto the Project directory
  2. Run the command `pod init`
  3. Add the following line to created Podfile
        pod 'DubberSDK', git: 'https://github.com/DubberSoftware/dubber-sdk-ios.git'
  4. Execute `pod install` from terminal to install the dependency in to your project

## Connecting to the Dubber API
Once you have a valid access token, you must configure the SDK by passing the access token and
selecting the API environment (e.g. sandbox, au, uk etc). You can then call one of the end points with the appropriate details.
The example below shows a call to get all the recordings for account ACCOUNT_ID that match a query QUERY.

```ios

#import "DUBRecordingsApi.h"
#import "DUBApiClient.h"

...

  NSURL *url = [NSURL URLWithString:@"https://api.dubber.net/sandbox"];
  DUBApiClient *conf = [[DUBApiClient alloc]init];
  DUBRecordingsApi *recording_api = [[DUBRecordingsApi alloc]initWithApiClient:[conf initWithBaseURL:url]];

 NSString *str = [NSString stringWithFormat:@"%@",access_token];
 NSString *acc_id = [NSString stringWithFormat:@"%@",account_id];
 NSString *token = [@"Bearer " stringByAppendingString:str];
 [recording_api addHeader:token forKey:@"Authorization"];
[recording_api getAccountRecordingsWithAccountId:acc_id query:query_value number:NULL count:NULL afterId:NULL beforeId:NULL page:NULL completionHandler: ^(id data, NSError *error) {
   handler:;
   if (error) {
       result_view.text = [NSString stringWithFormat: @"%@",
                           error.userInfo[@"DUBResponseObject"]];
   } else {
       result_view.text = [NSString stringWithFormat: @"%@",
                           data];
   }
}
...

```
