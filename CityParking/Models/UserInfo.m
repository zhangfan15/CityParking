//
//  UserInfo.m
//
//  Created by 帆 张 on 2017/9/28
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"


NSString *const kUserInfoZhye = @"zhye";
NSString *const kUserInfoEmail = @"email";
NSString *const kUserInfoSex = @"sex";
NSString *const kUserInfoPayPwd = @"payPwd";
NSString *const kUserInfoTime = @"time";
NSString *const kUserInfoHyid = @"hyid";
NSString *const kUserInfoPhonenum = @"phonenum";
NSString *const kUserInfoUsername = @"username";
NSString *const kUserInfoLogintype = @"logintype";
NSString *const kUserInfoHtlx = @"htlx";
NSString *const kUserInfoPid = @"pid";
NSString *const kUserInfoZfsz = @"zfsz";


@interface UserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfo

@synthesize zhye = _zhye;
@synthesize email = _email;
@synthesize sex = _sex;
@synthesize payPwd = _payPwd;
@synthesize time = _time;
@synthesize hyid = _hyid;
@synthesize phonenum = _phonenum;
@synthesize username = _username;
@synthesize logintype = _logintype;
@synthesize htlx = _htlx;
@synthesize pid = _pid;
@synthesize zfsz = _zfsz;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.zhye = [[self objectOrNilForKey:kUserInfoZhye fromDictionary:dict] doubleValue];
            self.email = [self objectOrNilForKey:kUserInfoEmail fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kUserInfoSex fromDictionary:dict];
            self.payPwd = [self objectOrNilForKey:kUserInfoPayPwd fromDictionary:dict];
            self.time = [self objectOrNilForKey:kUserInfoTime fromDictionary:dict];
            self.hyid = [self objectOrNilForKey:kUserInfoHyid fromDictionary:dict];
            self.phonenum = [self objectOrNilForKey:kUserInfoPhonenum fromDictionary:dict];
            self.username = [self objectOrNilForKey:kUserInfoUsername fromDictionary:dict];
            self.logintype = [[self objectOrNilForKey:kUserInfoLogintype fromDictionary:dict] doubleValue];
            self.htlx = [self objectOrNilForKey:kUserInfoHtlx fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kUserInfoPid fromDictionary:dict];
            self.zfsz = [[self objectOrNilForKey:kUserInfoZfsz fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.zhye] forKey:kUserInfoZhye];
    [mutableDict setValue:self.email forKey:kUserInfoEmail];
    [mutableDict setValue:self.sex forKey:kUserInfoSex];
    [mutableDict setValue:self.payPwd forKey:kUserInfoPayPwd];
    [mutableDict setValue:self.time forKey:kUserInfoTime];
    [mutableDict setValue:self.hyid forKey:kUserInfoHyid];
    [mutableDict setValue:self.phonenum forKey:kUserInfoPhonenum];
    [mutableDict setValue:self.username forKey:kUserInfoUsername];
    [mutableDict setValue:[NSNumber numberWithDouble:self.logintype] forKey:kUserInfoLogintype];
    [mutableDict setValue:self.htlx forKey:kUserInfoHtlx];
    [mutableDict setValue:self.pid forKey:kUserInfoPid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.zfsz] forKey:kUserInfoZfsz];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.zhye = [aDecoder decodeDoubleForKey:kUserInfoZhye];
    self.email = [aDecoder decodeObjectForKey:kUserInfoEmail];
    self.sex = [aDecoder decodeObjectForKey:kUserInfoSex];
    self.payPwd = [aDecoder decodeObjectForKey:kUserInfoPayPwd];
    self.time = [aDecoder decodeObjectForKey:kUserInfoTime];
    self.hyid = [aDecoder decodeObjectForKey:kUserInfoHyid];
    self.phonenum = [aDecoder decodeObjectForKey:kUserInfoPhonenum];
    self.username = [aDecoder decodeObjectForKey:kUserInfoUsername];
    self.logintype = [aDecoder decodeDoubleForKey:kUserInfoLogintype];
    self.htlx = [aDecoder decodeObjectForKey:kUserInfoHtlx];
    self.pid = [aDecoder decodeObjectForKey:kUserInfoPid];
    self.zfsz = [aDecoder decodeDoubleForKey:kUserInfoZfsz];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_zhye forKey:kUserInfoZhye];
    [aCoder encodeObject:_email forKey:kUserInfoEmail];
    [aCoder encodeObject:_sex forKey:kUserInfoSex];
    [aCoder encodeObject:_payPwd forKey:kUserInfoPayPwd];
    [aCoder encodeObject:_time forKey:kUserInfoTime];
    [aCoder encodeObject:_hyid forKey:kUserInfoHyid];
    [aCoder encodeObject:_phonenum forKey:kUserInfoPhonenum];
    [aCoder encodeObject:_username forKey:kUserInfoUsername];
    [aCoder encodeDouble:_logintype forKey:kUserInfoLogintype];
    [aCoder encodeObject:_htlx forKey:kUserInfoHtlx];
    [aCoder encodeObject:_pid forKey:kUserInfoPid];
    [aCoder encodeDouble:_zfsz forKey:kUserInfoZfsz];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfo *copy = [[UserInfo alloc] init];
    
    if (copy) {

        copy.zhye = self.zhye;
        copy.email = [self.email copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.payPwd = [self.payPwd copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.hyid = [self.hyid copyWithZone:zone];
        copy.phonenum = [self.phonenum copyWithZone:zone];
        copy.username = [self.username copyWithZone:zone];
        copy.logintype = self.logintype;
        copy.htlx = [self.htlx copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
        copy.zfsz = self.zfsz;
    }
    
    return copy;
}


@end
