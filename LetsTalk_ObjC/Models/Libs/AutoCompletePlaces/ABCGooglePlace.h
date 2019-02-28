#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ABCGooglePlace : NSObject

@property (readonly) NSString *name;
@property (readonly) CLLocation *location;
@property (readonly) NSString *formatted_address;

-(instancetype)initWithJSONData:(NSDictionary *)jsonDictionary;

@end
