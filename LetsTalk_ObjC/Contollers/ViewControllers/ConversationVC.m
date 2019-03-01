//
//  ConversationVC.m
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import "ConversationVC.h"
#import "ModelStructChat.h"
#import <AVKit/AVKit.h>
#import "EXPhotoViewer.h"
#import "MTDURLPreview.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
typedef void(^compeletionData)(BOOL,NSMutableDictionary*);
@interface ConversationVC ()
{
    NSMutableArray *arrMsgs;
    UIImagePickerController *imagePicker;
    NSArray *nib;
    CLLocationCoordinate2D annotationCoord;
    MKPointAnnotation *annotationPoint;
    MKCoordinateRegion viewRegion;
    MKCoordinateSpan span;
    ModelStructChat *copyobj;
    ModelStructChat *editedobj;
    BOOL isedit,isdelete;
    int selectedRow;
    AVPlayer *player;
    AVPlayerLayer *playerLayer;
   NSTimer* timer;
}
@end

@implementation ConversationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view endEditing:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btngalleryclicked:(id)sender
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = @[@"public.image", @"public.movie"];
    [self presentViewController:imagePicker animated:YES completion:^{
        self.vwattach.hidden = true;
    }];
}
- (IBAction)btnpopupclicked:(id)sender
{
    self.vwattach.hidden = true;
}
- (IBAction)btncameraclicked:(id)sender
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:YES completion:^{
        self.vwattach.hidden = true;
    }];
}
- (IBAction)btnlocationclicked:(id)sender
{
    [self.view endEditing:true];
    [self.inputvalues resignFirstResponder];
     self.vwattach.hidden = true;
    ABCGooglePlacesSearchViewController *searchViewController = [[ABCGooglePlacesSearchViewController alloc] init];
    [searchViewController setDelegate:self];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}


-(void)addLongGestureToview:(UIView *)vw
{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    if([vw.accessibilityLabel isEqualToString:@"mine"])
    {
        lpgr.accessibilityLabel = @"1";
    }
    else
    {
         lpgr.accessibilityLabel = @"-1";
    }
    [vw setUserInteractionEnabled:YES];
    [vw addGestureRecognizer:lpgr];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    [self.inputvalues resignFirstResponder];
    CGPoint p = [gestureRecognizer locationInView:self.tblchat];
    NSIndexPath *indexPath = [self.tblchat indexPathForRowAtPoint:p];
    ModelStructChat *obj = arrMsgs[indexPath.row];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Select an option" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        copyobj = obj;
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    if( [gestureRecognizer.accessibilityLabel isEqualToString:@"1" ])
    {
        if([obj.kmediatype isEqualToString:@"0"] || [obj.kmediatype isEqualToString:@"5"]) // text and link editable
        {
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
            {
                isedit = true;
                selectedRow = (int)indexPath.row;
                editedobj = obj;
                self.inputvalues.textView.text = editedobj.kmsg;
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }]];
        }
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            isdelete = true;
            selectedRow = (int)indexPath.row;
            NSDictionary *dic = @{@"message":@"This message has been removed.",@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"0",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"1",@"isedit":isdelete == true ? @"1" : @"0"};
            [arrMsgs replaceObjectAtIndex:selectedRow withObject:[[ModelStructChat alloc]initWithDictionary:dic]];
            [self.tblchat beginUpdates];
            [self.tblchat reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self.tblchat endUpdates];
            [self dismissViewControllerAnimated:YES completion:^{
                isdelete = false;
                [self.tblchat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
            }];
        }]];
    }
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Forward" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
   
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)setInputbar
{
    self.inputvalues.placeholder = @"Write a message...";
    self.inputvalues.delegate = self;
    self.inputvalues.backgroundColor = [UIColor whiteColor];
    self.inputvalues.leftButtonImage = [UIImage imageNamed:@"ic_attach"];
}
-(void)layoutUI
{
    
    [self.tblchat setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.tblchat addGestureRecognizer:tap];
    [self.tblchat registerNib:[UINib nibWithNibName:@"ChatSenderCell" bundle:nil] forCellReuseIdentifier:@"ChatSenderCell"];
    [self.tblchat registerNib:[UINib nibWithNibName:@"ChatReceiverCell" bundle:nil] forCellReuseIdentifier:@"ChatReceiverCell"];
    [self.tblchat registerNib:[UINib nibWithNibName:@"ChatSenderAttachCell" bundle:nil] forCellReuseIdentifier:@"ChatSenderAttachCell"];
    [self.tblchat registerNib:[UINib nibWithNibName:@"ChatReceiverAttachCell" bundle:nil] forCellReuseIdentifier:@"ChatReceiverAttachCell"];
    
    UIView *footervw = [[UIView alloc] initWithFrame:CGRectZero];
    self.tblchat.tableFooterView = footervw;
    _tblchat.delegate = self;
    _tblchat.dataSource = self;
    self.tblchat.estimatedRowHeight = 75;
    _vwattach.hidden = true;
    imagePicker= [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    arrMsgs = [NSMutableArray new];
    NSDictionary *dic = @{@"message":@"Hiii",@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"0",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":@"0"};
    [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
    dic = @{@"message":@"This does display the view on screen. But the problem is, it doesn't accept any user interaction. In my custom view, I have a UITableView which does display the data but it doesn't scroll or get tapped due to lack of user interaction",@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"0",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":@"0"};
    [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
   dic = @{@"message":@"You cannot enter foreground from background just like that. When you send the VoIP-push the app will go into background.",@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"0",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":@"0"};
    [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
    
    [self setInputbar];
}

-(void)dismissKeyboard
{
    [self.inputvalues resignFirstResponder];
    self.vwattach.hidden = true;
    
}
- (void)tableViewScrollToBottomAnimated:(BOOL)animated
{
    if(arrMsgs.count > 0)
    {
        [_tblchat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:arrMsgs.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}
#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModelStructChat *obj = arrMsgs[indexPath.row];
    if(indexPath.row % 2 == 0)
    {
        if(obj.kmediatype.intValue > 0)
        {
            
                ChatSenderAttachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatSenderAttachCell"];
                if (!cell)
                {
                    cell = [[ChatSenderAttachCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatSenderAttachCell"];
                }
                cell.accessibilityLabel = @"someone";
                cell.btnzoomandplay.tag = indexPath.row;
                cell.lbltime.text = obj.kdatetime;
                cell.imgplay.hidden = obj.kmediatype.intValue == 2 ? false : true;
                if(obj.kmediatype.intValue == 3)
                {
                    cell.vwmap.hidden = false;
                    cell.vwimage.hidden = true;
                    cell.vwlinkpreview.hidden = true;
                    annotationPoint = [[MKPointAnnotation alloc] init];
                    span.latitudeDelta = 0.01f;
                    span.longitudeDelta = 0.01f;
                    annotationCoord.latitude = obj.klatitude.floatValue;
                    annotationCoord.longitude = obj.klongitude.floatValue;
                    viewRegion.center = annotationCoord;
                    viewRegion.span = span;
                    annotationPoint.coordinate = annotationCoord;
                    [cell.maplocation addAnnotation:annotationPoint];
                    [cell.maplocation setRegion:viewRegion animated:YES];
                    cell.lbllocation.text = obj.kmsg;
                }
                else if(obj.kmediatype.intValue == 5)
                {
                    cell.vwmap.hidden = true;
                    cell.vwimage.hidden = true;
                    cell.vwlinkpreview.hidden = false;
                    cell.lblurl.text = obj.kmsg;
                    cell.lbldesc.text = obj.kdesc;
                    cell.lbltitle.text = obj.ktitle;
                    [cell.imglink sd_setImageWithURL:[NSURL URLWithString:obj.kmedia] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        cell.imgsmalllink.image = cell.imglink.image;
                    }];
                }
                else
                {
                    cell.vwmap.hidden = true;
                    cell.vwimage.hidden = false;
                    cell.vwlinkpreview.hidden = true;
                    cell.imgreceived.image = obj.kmediaImage;
                }
                [cell.btnzoomandplay addTarget:self
                                        action:@selector(zoomcontent:)
                              forControlEvents:UIControlEventTouchUpInside];
                [self addLongGestureToview:cell];
                return cell;
        }
        else
        {
            ChatSenderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatSenderCell"];
            if (!cell)
            {
                cell = [[ChatSenderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatSenderCell"];
            }
            cell.accessibilityLabel = @"someone";
            cell.lblmsg.text = obj.kmsg;
            cell.lbltime.text = obj.kdatetime;
            cell.lblmsg.numberOfLines = 0;
            [cell.lblmsg sizeToFit];
            [self addLongGestureToview:cell];
            return cell;
        }
    }
    else
    {
        if(obj.kmediatype.intValue > 0)
        {
                ChatReceiverAttachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatReceiverAttachCell"];
                if (!cell)
                {
                    cell = [[ChatReceiverAttachCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatReceiverAttachCell"];
                }
                cell.accessibilityLabel = @"mine";
                cell.btnzoom.tag = indexPath.row;
                cell.lbltime.text = obj.kdatetime;
                cell.imgplay.hidden = obj.kmediatype.intValue == 2 ? false : true;
                if(obj.kmediatype.intValue == 3) // map cell
                {
                    cell.vwmap.hidden = false;
                    cell.vwlinkpreview.hidden = true;
                    cell.vwimage.hidden = true;
                    annotationPoint = [[MKPointAnnotation alloc] init];
                    span.latitudeDelta = 0.01f;
                    span.longitudeDelta = 0.01f;
                    annotationCoord.latitude = obj.klatitude.floatValue;
                    annotationCoord.longitude = obj.klongitude.floatValue;
                    viewRegion.center = annotationCoord;
                    viewRegion.span = span;
                    annotationPoint.coordinate = annotationCoord;
                    [cell.maplocation addAnnotation:annotationPoint];
                    [cell.maplocation setRegion:viewRegion animated:YES];
                    cell.lbllocation.text = obj.kmsg;
                }
                else if(obj.kmediatype.intValue == 5) // link preview cell
                {
                    cell.vwmap.hidden = true;
                    cell.vwlinkpreview.hidden = false;
                    cell.vwimage.hidden = true;
                    cell.lblurl.text = obj.kmsg;
                    cell.lbldesc.text = obj.kdesc;
                    cell.lbltitle.text = obj.ktitle;
                    [cell.imglink sd_setImageWithURL:[NSURL URLWithString:obj.kmedia] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        cell.imgsmalllink.image = cell.imglink.image;
                    }];
                }
                else // image cell
                {
                    cell.vwmap.hidden = true;
                    cell.vwlinkpreview.hidden = true;
                    cell.vwimage.hidden = false;
                    cell.imgsent.image = obj.kmediaImage;
                }
                [cell.btnzoom addTarget:self
                                 action:@selector(zoomcontent:)
                       forControlEvents:UIControlEventTouchUpInside];
                [self addLongGestureToview:cell];
                return cell;
        }
        else
        {
            //Text message cell
            ChatReceiverCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ChatReceiverCell"];
            if (!cell1)
            {
                cell1 = [[ChatReceiverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatReceiverCell"];
            }
            cell1.lblmsg.text = obj.kmsg;
            cell1.lbltime.text = obj.kdatetime;
            cell1.lblmsg.numberOfLines = 0;
            [cell1.lblmsg sizeToFit];
            cell1.accessibilityLabel = @"mine";
            if([obj.kdeleted isEqualToString:@"1"])
            {
                cell1.btnpencil.hidden = false;
                [cell1.btnpencil setImage:[UIImage imageNamed:@"ic_trash"] forState:UIControlStateNormal];
            }
            else
            {
                if([obj.kisedited isEqualToString:@"0"])
                {
                    cell1.btnpencil.hidden = true;
                    [cell1.btnpencil setImage:[UIImage imageNamed:@"ic_edited"] forState:UIControlStateNormal];
                }
                else
                {
                    cell1.btnpencil.hidden = false;
                    [cell1.btnpencil setImage:[UIImage imageNamed:@"ic_edited"] forState:UIControlStateNormal];
                }
            }
            [self addLongGestureToview:cell1];
            return cell1;
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMsgs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - image picker delegate

-(UIImage *)generateThumbImage : (NSURL *)url
{
    AVAsset *asset = [AVAsset assetWithURL:url];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CMTime time = [asset duration];
    time.value = 0;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbnail;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.vwattach.hidden = true;
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *mediatp = info[UIImagePickerControllerMediaType] ;
    if([mediatp isEqualToString:@"public.image"])
    {
        NSDictionary *dic = @{@"message":@"",@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"1",@"media":@"",@"mediaImage":[info objectForKey:UIImagePickerControllerOriginalImage],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":@"0"};
        [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
    }
    else
    {
        NSLog(@"url ---> %@",[info objectForKey:UIImagePickerControllerMediaURL]);
        UIImage *img = [self generateThumbImage:[info objectForKey:UIImagePickerControllerMediaURL]];
        NSDictionary *dic = @{@"message":@"",@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"2",@"media":@"",@"mediaImage":img,@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":@"0",@"url":[NSString stringWithFormat:@"%@",[info objectForKey:UIImagePickerControllerMediaURL]]};
        [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
    }
    [self.tblchat beginUpdates];
    [self.tblchat insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:arrMsgs.count-1 inSection:0]]
                        withRowAnimation:UITableViewRowAnimationNone];
    [self.tblchat endUpdates];
    [self tableViewScrollToBottomAnimated:false];
}
-(void)ExtractUrlPreview:(NSString *)urlval :(compeletionData) compblock
{
    [MTDURLPreview loadPreviewWithURL:[NSURL URLWithString:urlval] completion:^(MTDURLPreview *preview, NSError *error)
     {
         NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        if (error)
        {
            compblock(NO,dic);
        }
        if ([preview.title length] > 0 && [preview.domain length] > 0)
        {
            
            [dic setValue:[NSString stringWithFormat:@"%@",preview.title] forKey:@"title"];
            if([preview.content length] > 0)
            {
                 [dic setValue:[NSString stringWithFormat:@"%@",preview.content] forKey:@"desc"];
            }
            else
            {
                 [dic setValue:@"" forKey:@"desc"];
            }
            [dic setValue:[NSString stringWithFormat:@"%@",urlval] forKey:@"link"];
            [dic setValue:[NSString stringWithFormat:@"%@",preview.domain] forKey:@"url"];
            [dic setValue:[NSString stringWithFormat:@"%@",preview.imageURL] forKey:@"img"];
             compblock(YES,dic);
        }
        else
        {
             compblock(NO,dic);
        }
    }];
}
#pragma mark - Inputbar delegate
-(void)inputbarDidPressRightButton:(Inputbar *)inputbar
{
    NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [detect matchesInString:inputbar.text options:0 range:NSMakeRange(0, [inputbar.text length])];
    
    NSURL *url = [NSURL URLWithString:inputbar.text];
    if (url && url.scheme && url.host && matches > 0)
    {
        [self ExtractUrlPreview:inputbar.text :^(BOOL isdone, NSMutableDictionary * dict)
        {
            if(isdone == true)
            {
                NSDictionary *dic = @{@"message":[dict valueForKey:@"url"],@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"5",@"media":[dict valueForKey:@"img"],@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":[dict valueForKey:@"title"],@"desc":[dict valueForKey:@"desc"],@"url":[dict valueForKey:@"link"],@"isedit":isedit == true ? @"1" : @"0",@"isdelete":@"0"};
                if(isedit == false)
                {
                    [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
                    
                }
                else
                {
                    [arrMsgs replaceObjectAtIndex:selectedRow withObject:[[ModelStructChat alloc]initWithDictionary:dic]];
                }
            }
            else
            {
                NSDictionary *dic = @{@"message":inputbar.text,@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"0",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":isedit == true ? @"1" : @"0"};
                if(isedit == false)
                {
                    [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
                }
                else
                {
                    [arrMsgs replaceObjectAtIndex:selectedRow withObject:[[ModelStructChat alloc]initWithDictionary:dic]];
                }
            }
             if(isedit == true)
            {
                [self.tblchat beginUpdates];
                [self.tblchat reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:selectedRow inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                [self.tblchat endUpdates];
                [self.tblchat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
                isedit = false;
            }
            else
            {
                [self.tblchat beginUpdates];
                [self.tblchat insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:arrMsgs.count-1 inSection:0]]
                                    withRowAnimation:UITableViewRowAnimationNone];
                [self.tblchat endUpdates];
                [self tableViewScrollToBottomAnimated:false];
            }
        }];
    }
    else
    {
        NSDictionary *dic = @{@"message":inputbar.text,@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"0",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":@"",@"longitude":@"",@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":isedit == true ? @"1" : @"0"};
        if(isedit == false)
        {
            [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
        }
        else
        {
            [arrMsgs replaceObjectAtIndex:selectedRow withObject:[[ModelStructChat alloc]initWithDictionary:dic]];
        }
        if(isedit == true)
        {
            [self.tblchat beginUpdates];
            [self.tblchat reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:selectedRow inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tblchat endUpdates];
            [self.tblchat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectedRow inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:false];
            isedit = false;
        }
        else
        {
            [self.tblchat beginUpdates];
            [self.tblchat insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:arrMsgs.count-1 inSection:0]]
                                withRowAnimation:UITableViewRowAnimationNone];
            [self.tblchat endUpdates];
            [self tableViewScrollToBottomAnimated:false];
        }
    }
}
-(void)inputbarDidPressLeftButton:(Inputbar *)inputbar
{
    [self.inputvalues resignFirstResponder];
    if(self.vwattach.isHidden == false)
    {
        self.vwattach.hidden = true;
    }
    else
    {
        self.vwattach.hidden = false;
    }
}
-(void)inputbarDidChangeHeight:(CGFloat)new_height
{
    if(new_height > 49)
    {
        self.heightinput.constant = new_height;
    }
    else
    {
        self.heightinput.constant =  49;
    }
    [self.view layoutIfNeeded];
}
-(void)inputbarDidBecomeFirstResponder:(Inputbar *)inputbar
{
    [self tableViewScrollToBottomAnimated:false];
}
    
#pragma mark - ABCGooglePlacesSearchViewControllerDelegate Methods

-(void)searchViewController:(ABCGooglePlacesSearchViewController *)controller didReturnPlace:(ABCGooglePlace *)place
{
    NSDictionary *dic = @{@"message":place.formatted_address,@"datetime":@"09:20 PM",@"senderimage":@"",@"mediatype":@"3",@"media":@"",@"mediaImage":[UIImage imageNamed:@"ic_attach"],@"latitude":[NSString stringWithFormat:@"%f",place.location.coordinate.latitude],@"longitude":[NSString stringWithFormat:@"%f", place.location.coordinate.longitude],@"title":@"",@"desc":@"",@"isdelete":@"0",@"isedit":@"0"};
    [arrMsgs addObject:[[ModelStructChat alloc]initWithDictionary:dic]];
    [self.tblchat beginUpdates];
    [self.tblchat insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:arrMsgs.count-1 inSection:0]]
                        withRowAnimation:UITableViewRowAnimationNone];
    [self.tblchat endUpdates];
    [self tableViewScrollToBottomAnimated:false];
}
#pragma mark - show  map
-(void)zoomcontent:(UIButton *)sender
{
     [self.view endEditing:true];
    ModelStructChat *obj = arrMsgs[sender.tag];
    self.vwvideo.hidden = true;
    if(obj.kmediatype.intValue == 3)
    {
        _lbladdress.text = obj.kmsg;
         self.vwweb.hidden = true;
        [self prepareMap:obj.klatitude :obj.klongitude];
    }
    else if(obj.kmediatype.intValue == 5)
    {
        [self.activity startAnimating];
        self.activity.hidden = false;
        self.vwmap.hidden = true;
        _lblwebtitle.text = obj.kmsg;
        NSURL *url = [NSURL URLWithString:obj.kurl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
         self.vwweb.hidden = false;
    }
    else if(obj.kmediatype.intValue == 2)
    {
        self.vwvideo.hidden = false;
    

        player = [AVPlayer playerWithURL:[NSURL URLWithString:obj.kurl]];
        playerLayer = [AVPlayerLayer layer];
        playerLayer.player = player;
        playerLayer.frame = self.vwplayer.bounds;
        self.vwplayer.center = self.vwvideo.center;
        playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.vwplayer.layer addSublayer:playerLayer];
        [player play];
        [self.btnplaypause setImage:[UIImage imageNamed:@"ic_pause"] forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(stopped:)
         name:AVPlayerItemDidPlayToEndTimeNotification
         object:player.currentItem];
    }
    else
    {
        self.vwweb.hidden = true;
        UIImageView *img = [[UIImageView alloc]initWithImage:obj.kmediaImage];
        [EXPhotoViewer showImageFrom:img];
    }
}
- (void) stopped:(NSNotification *) notification
{
    [player seekToTime: CMTimeMakeWithSeconds(0, 1)];
     [self updateSliderLabels];
    [self.btnplaypause setImage:[UIImage imageNamed:@"ic_playicon"] forState:UIControlStateNormal];
}
-(void)prepareMap :(NSString *)lat :(NSString *)lon
{
    self.vwmap.hidden = false;
    annotationPoint = [[MKPointAnnotation alloc] init];
    span.latitudeDelta = 0.01f;
    span.longitudeDelta = 0.01f;
    annotationCoord.latitude = lat.floatValue;
    annotationCoord.longitude = lon.floatValue;
    viewRegion.center = annotationCoord;
    viewRegion.span = span;
    annotationPoint.coordinate = annotationCoord;
    
    [self.mapview addAnnotation:annotationPoint];
    [self.mapview setRegion:viewRegion animated:YES];
}
- (IBAction)btnbackclicked:(id)sender
{
    self.vwweb.hidden = true;
    self.vwmap.hidden = true;
    self.vwvideo.hidden = true;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
    [playerLayer removeFromSuperlayer];
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

- (IBAction)btnplaypauseclicked:(id)sender
{
    if(player.rate > 0)
    {
        [player pause];
        [self.btnplaypause setImage:[UIImage imageNamed:@"ic_playicon"] forState:UIControlStateNormal];
    }
    else
    {
        [player play];
    }
}
- (IBAction)slidervaluechanged:(id)sender
{
}
- (void)updateSliderLabels
{
}

- (void)timerFired:(NSTimer*)timer
{
}
#pragma mark - keyboard movements
-(void)managekeyboardsize :(CGRect)frame
{
    if(frame.origin.y != SCREEN_HEIGHT)
    {
        self.bottominput.constant = frame.size.height - (UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom);
        [self tableViewScrollToBottomAnimated:false];
    }
    else
    {
        self.bottominput.constant = 0;
    }
    [self.view layoutIfNeeded];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self managekeyboardsize:keyboardSize];
   
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    CGRect keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self managekeyboardsize:keyboardSize];
}

@end
