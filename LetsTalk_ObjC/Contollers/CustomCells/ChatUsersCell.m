//
//  ChatUsersCell.m
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import "ChatUsersCell.h"

@implementation ChatUsersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgpicture.layer.cornerRadius = self.imgpicture.frame.size.width/2;
    self.imgpicture.layer.masksToBounds = YES;
    self.lblnotification.layer.cornerRadius = self.lblnotification.frame.size.width/2;
    self.lblnotification.layer.masksToBounds = YES;
    self.lblname.text = @"";
    self.lblmessage.text = @"";
    self.lbltime.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
