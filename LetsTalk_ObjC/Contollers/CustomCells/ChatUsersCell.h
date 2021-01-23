//
//  ChatUsersCell.h
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatUsersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblmessage;
@property (weak, nonatomic) IBOutlet UILabel *lbltime;
@property (weak, nonatomic) IBOutlet UIImageView *imgpicture;
@property (weak, nonatomic) IBOutlet UILabel *lblnotification;
@end
