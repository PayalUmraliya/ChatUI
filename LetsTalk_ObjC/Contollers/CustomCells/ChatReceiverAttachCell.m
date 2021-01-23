//
//  ChatReceiverAttachCell.m
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import "ChatReceiverAttachCell.h"
@implementation ChatReceiverAttachCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.vwattach.clipsToBounds = true;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.vwattach.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft)
                                                         cornerRadii:CGSizeMake(15.0, 15.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.vwattach.bounds;
    maskLayer.path = maskPath.CGPath;
    self.vwattach.layer.mask = maskLayer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


    @end
