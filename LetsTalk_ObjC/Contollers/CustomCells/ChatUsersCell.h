//
//  ChatUsersCell.h
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatUsersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lblmessage;
@property (weak, nonatomic) IBOutlet UILabel *lbltime;
@property (weak, nonatomic) IBOutlet UIImageView *imgpicture;
@property (weak, nonatomic) IBOutlet UILabel *lblnotification;
@end
