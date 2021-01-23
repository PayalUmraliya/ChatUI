//
//  ChatSenderAttachCell.h
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ChatSenderAttachCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *lbltime;
    @property (weak, nonatomic) IBOutlet UIImageView *imgreceived;
    @property (weak, nonatomic) IBOutlet UIImageView *imgplay;
    @property (weak, nonatomic) IBOutlet UIButton *btnprofile;
    @property (weak, nonatomic) IBOutlet UIButton *btnzoomandplay;
    @property (weak, nonatomic) IBOutlet UILabel *lbllocation;
    @property (weak, nonatomic) IBOutlet MKMapView *maplocation;
@property (weak, nonatomic) IBOutlet UIView *vwlinkpreview;
@property (weak, nonatomic) IBOutlet UIImageView *imglink;
@property (weak, nonatomic) IBOutlet UIImageView *imgsmalllink;
@property (weak, nonatomic) IBOutlet UILabel *lblurl;
@property (weak, nonatomic) IBOutlet UIImageView *imgshadow;
@property (weak, nonatomic) IBOutlet UILabel *lbldesc;
@property (weak, nonatomic) IBOutlet UIView *vwimage;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UIView *vwattach;
@property (weak, nonatomic) IBOutlet UIView *vwmap;

    @end
