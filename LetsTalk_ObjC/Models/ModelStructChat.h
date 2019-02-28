//
//  ModelStructChat.h
//  LetsTalk_ObjC
//
//  Created by Admin on 06/02/18.
//  Copyright © 2018 Vishwkarma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ModelStructChat : NSObject
@property (nonatomic, strong) NSString * kmsg;
@property (nonatomic, strong) NSString *kdatetime;
@property (nonatomic, strong) NSString * ksenderimage;
@property (nonatomic, strong) NSString *kmediatype;
@property (nonatomic, strong) NSString *kmedia;
@property (nonatomic, strong) NSString *klatitude;
@property (nonatomic, strong) NSString *klongitude;
@property (nonatomic, strong) UIImage *kmediaImage;
@property (nonatomic, strong) NSString *ktitle;
@property (nonatomic, strong) NSString *kdesc;
@property (nonatomic, strong) NSString *kurl;
@property (nonatomic, strong) NSString *kisedited;
@property (nonatomic, strong) NSString *kdeleted;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
