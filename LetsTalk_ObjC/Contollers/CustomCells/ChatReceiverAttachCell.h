//
//  ChatReceiverAttachCell.h
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ChatReceiverAttachCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *lbltime;
@property (weak, nonatomic) IBOutlet UIImageView *imgshadow;
@property (weak, nonatomic) IBOutlet UILabel *lbllocation;
    @property (weak, nonatomic) IBOutlet UIButton *btnzoom;
    @property (weak, nonatomic) IBOutlet UIImageView *imgplay;
@property (weak, nonatomic) IBOutlet UIView *vwmap;
@property (weak, nonatomic) IBOutlet MKMapView *maplocation;
@property (weak, nonatomic) IBOutlet UIView *vwattach;
@property (weak, nonatomic) IBOutlet UIView *vwimage;
@property (weak, nonatomic) IBOutlet UIImageView *imgsent;
@property (weak, nonatomic) IBOutlet UIView *vwlinkpreview;
@property (weak, nonatomic) IBOutlet UIImageView *imglink;
@property (weak, nonatomic) IBOutlet UIImageView *imgsmalllink;
@property (weak, nonatomic) IBOutlet UILabel *lblurl;
@property (weak, nonatomic) IBOutlet UILabel *lbldesc;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@end
