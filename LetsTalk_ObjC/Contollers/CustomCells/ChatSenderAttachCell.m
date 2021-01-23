//
//  ChatSenderAttachCell.m
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import "ChatSenderAttachCell.h"
@implementation ChatSenderAttachCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.vwattach.clipsToBounds = true;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.vwattach.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(15.0, 15.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.vwattach.bounds;
    maskLayer.path = maskPath.CGPath;
    self.vwattach.layer.mask = maskLayer;
    self.btnprofile.layer.cornerRadius = self.btnprofile.layer.frame.size.height / 2;
    self.btnprofile.layer.borderColor = [UIColor blackColor].CGColor;
    self.btnprofile.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

    @end
