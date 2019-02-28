#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ABCGoogleAutoCompleteResult : NSObject

@property (readonly) NSString *name;
@property (readonly) NSString *description;
@property (readonly) NSString *placeID;

@property (readonly) CLLocationCoordinate2D locationCoordinates;

-(instancetype)initWithJSONData:(NSDictionary *)jsonDictionary;

@end
