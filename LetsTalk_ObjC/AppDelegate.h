//
//  AppDelegate.h
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define loadVC(StroyBoardName,VCIdentifer) [[UIStoryboard storyboardWithName:StroyBoardName bundle:NULL]instantiateViewControllerWithIdentifier:VCIdentifer]
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

