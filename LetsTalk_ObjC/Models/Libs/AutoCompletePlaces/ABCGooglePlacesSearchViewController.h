#import <UIKit/UIKit.h>
#import "ABCGooglePlace.h"

@class ABCGooglePlacesSearchViewController;

@protocol ABCGooglePlacesSearchViewControllerDelegate <NSObject>

-(void)searchViewController:(ABCGooglePlacesSearchViewController *)controller didReturnPlace:(ABCGooglePlace *)place;


@end

@interface ABCGooglePlacesSearchViewController : UIViewController

@property (nonatomic) id<ABCGooglePlacesSearchViewControllerDelegate> delegate;

@end
