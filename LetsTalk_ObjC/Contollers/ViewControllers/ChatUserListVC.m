//
//  ChatUserListVC.m
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import "ChatUserListVC.h"
#import "ConversationVC.h"
#import "ChatUsersCell.h"
@interface ChatUserListVC ()
    {
        NSMutableArray *arrFriends;
    }
@end

@implementation ChatUserListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)layoutUI
    {
        UIView *footervw = [[UIView alloc] initWithFrame:CGRectZero];
        self.tbllist.tableFooterView = footervw;
        _tbllist.delegate = self;
        _tbllist.dataSource = self;
        self.tbllist.estimatedRowHeight = 75;
        arrFriends = [NSMutableArray new];
        [arrFriends addObject:@"Devika"];
        [arrFriends addObject:@"Prachi"];
    }
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        ChatUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatUsersCell"];
        if (!cell)
        {
            cell = [[ChatUsersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatUsersCell"];
        }
        cell.lbltime.text = @"12:10 PM";
        cell.lblname.text = arrFriends[indexPath.row];
        cell.lblmessage.text = @"Some Message";
        cell.lblnotification.text = @"1";
        return cell;
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return arrFriends.count;
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        ConversationVC *convo = loadVC(@"Chats", @"idConversationVC");
        [self.navigationController pushViewController:convo animated:true];
    }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return UITableViewAutomaticDimension;
    }
@end
