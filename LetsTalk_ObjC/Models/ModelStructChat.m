//
//  ModelStructChat.m
//  LetsTalk_ObjC
//
//  Created by Payal on 23/01/21.
//  Copyright © 2021 TheKarma. All rights reserved.
//

#import "ModelStructChat.h"

@implementation ModelStructChat
    
- (instancetype)initWithDictionary:(NSDictionary *)dict
    {
        self = [super init];
        if (self)
        {
            _kmsg = dict[@"message"];
            _kmedia = dict[@"media"];
            _kmediatype = dict[@"mediatype"];
            _kdatetime = dict[@"datetime"];
            _kmediaImage = dict[@"mediaImage"];
            _ksenderimage = dict[@"senderimage"];
             _klatitude = dict[@"latitude"];
             _klongitude = dict[@"longitude"];
            _ktitle = dict[@"title"];
            _kurl = dict[@"url"];
            _kdesc = dict[@"desc"];
            _kisedited = dict[@"isedit"];
            _kdeleted = dict[@"isdelete"];
        }
        return self;
    }
@end
