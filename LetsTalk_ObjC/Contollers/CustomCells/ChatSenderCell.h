//
//  ChatSenderCell.h
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatSenderCell : UITableViewCell
 
    @property (weak, nonatomic) IBOutlet UILabel *lblmsg;
    @property (weak, nonatomic) IBOutlet UIView *vwmsg;
    @property (weak, nonatomic) IBOutlet UIView *vwmain;
    @property (weak, nonatomic) IBOutlet UIButton *btnreact;
    @property (weak, nonatomic) IBOutlet UILabel *lbltime;
    @property (weak, nonatomic) IBOutlet UIButton *btnphoto;
- (IBAction)btnreactclicked:(id)sender;
    
@end
