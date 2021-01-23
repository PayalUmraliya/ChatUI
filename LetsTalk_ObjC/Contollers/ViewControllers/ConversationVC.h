//
//  ConversationVC.h
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inputbar.h"
#import "ChatSenderCell.h"
#import "ChatReceiverCell.h"
#import "ChatSenderAttachCell.h"
#import "ChatReceiverAttachCell.h"
#import "AppDelegate.h"
#import "ABCGooglePlacesSearchViewController.h"
#import <WebKit/WebKit.h>
@interface ConversationVC : UIViewController<InputbarDelegate,
    UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ABCGooglePlacesSearchViewControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightinput;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottominput;
@property (weak, nonatomic) IBOutlet UILabel *lbladdress;
@property (weak, nonatomic) IBOutlet UILabel *lblwebtitle;
@property (weak, nonatomic) IBOutlet UIView *vwvideo;
@property (weak, nonatomic) IBOutlet Inputbar *inputvalues;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
- (IBAction)btnbackclicked:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UIView *vwplayer;
@property (weak, nonatomic) IBOutlet UIButton *btnback;
@property (weak, nonatomic) IBOutlet UITableView *tblchat;
    @property (weak, nonatomic) IBOutlet UIView *vwattach;
@property (weak, nonatomic) IBOutlet UIView *vwmap;
@property (weak, nonatomic) IBOutlet UIView *vwweb;
- (IBAction)btnplaypauseclicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnplaypause;
@property (weak, nonatomic) IBOutlet UILabel *lbltimeremain;
@property (weak, nonatomic) IBOutlet UISlider *slidertime;
- (IBAction)slidervaluechanged:(id)sender;
@property (weak, nonatomic) IBOutlet WKWebView *webview;
- (IBAction)btngalleryclicked:(id)sender;
- (IBAction)btncameraclicked:(id)sender;
- (IBAction)btnlocationclicked:(id)sender;
- (IBAction)btnpopupclicked:(id)sender;
    @end
