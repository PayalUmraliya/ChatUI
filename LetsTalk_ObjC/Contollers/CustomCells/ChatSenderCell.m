//
//  ChatSenderCell.m
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import "ChatSenderCell.h"

@implementation ChatSenderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnphoto.layer.cornerRadius = self.btnphoto.layer.frame.size.height / 2;
    self.btnphoto.layer.borderColor = [UIColor blackColor].CGColor;
    self.btnphoto.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnreactclicked:(id)sender {
}
@end
