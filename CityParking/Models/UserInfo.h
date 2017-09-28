//
//  UserInfo.h
//
//  Created by 帆 张 on 2017/9/28
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double zhye;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *payPwd;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *hyid;
@property (nonatomic, strong) NSString *phonenum;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) double logintype;
@property (nonatomic, strong) NSString *htlx;
@property (nonatomic, strong) NSString * pid;
@property (nonatomic, assign) double zfsz;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
