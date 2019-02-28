#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABCGooglePlacesAPIClient : NSObject

@property (strong, nonatomic) NSMutableArray *searchResults;

+ (instancetype)sharedInstance;

- (void)retrieveGooglePlaceInformation:(NSString *)searchWord withCompletion:(void (^)(BOOL isSuccess, NSError *error))completion;

- (void)retrieveJSONDetailsAbout:(NSString *)place withCompletion:(void (^)(NSDictionary *placeInformation, NSError *error))completion;

@end
