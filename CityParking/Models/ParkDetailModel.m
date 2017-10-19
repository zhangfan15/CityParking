//
//  ParkDetailModel.m
//
//  Created by 帆 张 on 2017/10/18
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ParkDetailModel.h"


NSString *const kParkDetailModelFloor = @"floor";
NSString *const kParkDetailModelTime = @"time";
NSString *const kParkDetailModelId = @"id";
NSString *const kParkDetailModelCode = @"code";
NSString *const kParkDetailModelCkid = @"ckid";
NSString *const kParkDetailModelPlateNumber = @"plate_number";
NSString *const kParkDetailModelCname = @"cname";
NSString *const kParkDetailModelFlag = @"flag";
NSString *const kParkDetailModelPtype = @"ptype";
NSString *const kParkDetailModelAccid = @"accid";


@interface ParkDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ParkDetailModel

@synthesize floor = _floor;
@synthesize time = _time;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize code = _code;
@synthesize ckid = _ckid;
@synthesize plateNumber = _plateNumber;
@synthesize cname = _cname;
@synthesize flag = _flag;
@synthesize ptype = _ptype;
@synthesize accid = _accid;


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
            self.floor = [[self objectOrNilForKey:kParkDetailModelFloor fromDictionary:dict] doubleValue];
            self.time = [self objectOrNilForKey:kParkDetailModelTime fromDictionary:dict];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kParkDetailModelId fromDictionary:dict];
            self.code = [self objectOrNilForKey:kParkDetailModelCode fromDictionary:dict];
            self.ckid = [self objectOrNilForKey:kParkDetailModelCkid fromDictionary:dict];
            self.plateNumber = [self objectOrNilForKey:kParkDetailModelPlateNumber fromDictionary:dict];
            self.cname = [self objectOrNilForKey:kParkDetailModelCname fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kParkDetailModelFlag fromDictionary:dict];
            self.ptype = [self objectOrNilForKey:kParkDetailModelPtype fromDictionary:dict];
            self.accid = [self objectOrNilForKey:kParkDetailModelAccid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.floor] forKey:kParkDetailModelFloor];
    [mutableDict setValue:self.time forKey:kParkDetailModelTime];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kParkDetailModelId];
    [mutableDict setValue:self.code forKey:kParkDetailModelCode];
    [mutableDict setValue:self.ckid forKey:kParkDetailModelCkid];
    [mutableDict setValue:self.plateNumber forKey:kParkDetailModelPlateNumber];
    [mutableDict setValue:self.cname forKey:kParkDetailModelCname];
    [mutableDict setValue:self.flag forKey:kParkDetailModelFlag];
    [mutableDict setValue:self.ptype forKey:kParkDetailModelPtype];
    [mutableDict setValue:self.accid forKey:kParkDetailModelAccid];

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

    self.floor = [aDecoder decodeDoubleForKey:kParkDetailModelFloor];
    self.time = [aDecoder decodeObjectForKey:kParkDetailModelTime];
    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kParkDetailModelId];
    self.code = [aDecoder decodeObjectForKey:kParkDetailModelCode];
    self.ckid = [aDecoder decodeObjectForKey:kParkDetailModelCkid];
    self.plateNumber = [aDecoder decodeObjectForKey:kParkDetailModelPlateNumber];
    self.cname = [aDecoder decodeObjectForKey:kParkDetailModelCname];
    self.flag = [aDecoder decodeObjectForKey:kParkDetailModelFlag];
    self.ptype = [aDecoder decodeObjectForKey:kParkDetailModelPtype];
    self.accid = [aDecoder decodeObjectForKey:kParkDetailModelAccid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_floor forKey:kParkDetailModelFloor];
    [aCoder encodeObject:_time forKey:kParkDetailModelTime];
    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kParkDetailModelId];
    [aCoder encodeObject:_code forKey:kParkDetailModelCode];
    [aCoder encodeObject:_ckid forKey:kParkDetailModelCkid];
    [aCoder encodeObject:_plateNumber forKey:kParkDetailModelPlateNumber];
    [aCoder encodeObject:_cname forKey:kParkDetailModelCname];
    [aCoder encodeObject:_flag forKey:kParkDetailModelFlag];
    [aCoder encodeObject:_ptype forKey:kParkDetailModelPtype];
    [aCoder encodeObject:_accid forKey:kParkDetailModelAccid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ParkDetailModel *copy = [[ParkDetailModel alloc] init];
    
    if (copy) {

        copy.floor = self.floor;
        copy.time = [self.time copyWithZone:zone];
        copy.internalBaseClassIdentifier = [self.internalBaseClassIdentifier copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
        copy.ckid = [self.ckid copyWithZone:zone];
        copy.plateNumber = [self.plateNumber copyWithZone:zone];
        copy.cname = [self.cname copyWithZone:zone];
        copy.flag = [self.flag copyWithZone:zone];
        copy.ptype = [self.ptype copyWithZone:zone];
        copy.accid = [self.accid copyWithZone:zone];
    }
    
    return copy;
}


@end
