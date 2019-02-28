//
//  ModelStructChat.m
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
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
