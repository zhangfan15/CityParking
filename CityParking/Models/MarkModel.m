//
//  MarkModel.m
//
//  Created by 帆 张 on 2017/9/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "MarkModel.h"


NSString *const kMarkModelCname = @"cname";
NSString *const kMarkModelSycw = @"sycw";
NSString *const kMarkModelPtype = @"ptype";
NSString *const kMarkModelCtype = @"ctype";
NSString *const kMarkModelTp = @"tp";
NSString *const kMarkModelJuli = @"juli";
NSString *const kMarkModelSumCar = @"sumCar";
NSString *const kMarkModelCharge = @"charge";
NSString *const kMarkModelTime = @"time";
NSString *const kMarkModelCkid = @"ckid";
NSString *const kMarkModelDz = @"dz";
NSString *const kMarkModelTotal = @"total";
NSString *const kMarkModelLat = @"lat";
NSString *const kMarkModelLng = @"lng";
NSString *const kMarkModelTotalNumber = @"totalNumber";


@interface MarkModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MarkModel

@synthesize cname = _cname;
@synthesize sycw = _sycw;
@synthesize ptype = _ptype;
@synthesize ctype = _ctype;
@synthesize tp = _tp;
@synthesize juli = _juli;
@synthesize sumCar = _sumCar;
@synthesize charge = _charge;
@synthesize time = _time;
@synthesize ckid = _ckid;
@synthesize dz = _dz;
@synthesize total = _total;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize totalNumber = _totalNumber;


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
            self.cname = [self objectOrNilForKey:kMarkModelCname fromDictionary:dict];
            self.sycw = [[self objectOrNilForKey:kMarkModelSycw fromDictionary:dict] doubleValue];
            self.ptype = [self objectOrNilForKey:kMarkModelPtype fromDictionary:dict];
            self.ctype = [self objectOrNilForKey:kMarkModelCtype fromDictionary:dict];
            self.tp = [self objectOrNilForKey:kMarkModelTp fromDictionary:dict];
            self.juli = [self objectOrNilForKey:kMarkModelJuli fromDictionary:dict];
            self.sumCar = [[self objectOrNilForKey:kMarkModelSumCar fromDictionary:dict] doubleValue];
            self.charge = [self objectOrNilForKey:kMarkModelCharge fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMarkModelTime fromDictionary:dict];
            self.ckid = [self objectOrNilForKey:kMarkModelCkid fromDictionary:dict];
            self.dz = [self objectOrNilForKey:kMarkModelDz fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kMarkModelTotal fromDictionary:dict] doubleValue];
            self.lat = [self objectOrNilForKey:kMarkModelLat fromDictionary:dict];
            self.lng = [self objectOrNilForKey:kMarkModelLng fromDictionary:dict];
            self.totalNumber = [self objectOrNilForKey:kMarkModelTotalNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cname forKey:kMarkModelCname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sycw] forKey:kMarkModelSycw];
    [mutableDict setValue:self.ptype forKey:kMarkModelPtype];
    [mutableDict setValue:self.ctype forKey:kMarkModelCtype];
    [mutableDict setValue:self.tp forKey:kMarkModelTp];
    [mutableDict setValue:self.juli forKey:kMarkModelJuli];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sumCar] forKey:kMarkModelSumCar];
    [mutableDict setValue:self.charge forKey:kMarkModelCharge];
    [mutableDict setValue:self.time forKey:kMarkModelTime];
    [mutableDict setValue:self.ckid forKey:kMarkModelCkid];
    [mutableDict setValue:self.dz forKey:kMarkModelDz];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kMarkModelTotal];
    [mutableDict setValue:self.lat forKey:kMarkModelLat];
    [mutableDict setValue:self.lng forKey:kMarkModelLng];
    [mutableDict setValue:self.totalNumber forKey:kMarkModelTotalNumber];

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

    self.cname = [aDecoder decodeObjectForKey:kMarkModelCname];
    self.sycw = [aDecoder decodeDoubleForKey:kMarkModelSycw];
    self.ptype = [aDecoder decodeObjectForKey:kMarkModelPtype];
    self.ctype = [aDecoder decodeObjectForKey:kMarkModelCtype];
    self.tp = [aDecoder decodeObjectForKey:kMarkModelTp];
    self.juli = [aDecoder decodeObjectForKey:kMarkModelJuli];
    self.sumCar = [aDecoder decodeDoubleForKey:kMarkModelSumCar];
    self.charge = [aDecoder decodeObjectForKey:kMarkModelCharge];
    self.time = [aDecoder decodeObjectForKey:kMarkModelTime];
    self.ckid = [aDecoder decodeObjectForKey:kMarkModelCkid];
    self.dz = [aDecoder decodeObjectForKey:kMarkModelDz];
    self.total = [aDecoder decodeDoubleForKey:kMarkModelTotal];
    self.lat = [aDecoder decodeObjectForKey:kMarkModelLat];
    self.lng = [aDecoder decodeObjectForKey:kMarkModelLng];
    self.totalNumber = [aDecoder decodeObjectForKey:kMarkModelTotalNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cname forKey:kMarkModelCname];
    [aCoder encodeDouble:_sycw forKey:kMarkModelSycw];
    [aCoder encodeObject:_ptype forKey:kMarkModelPtype];
    [aCoder encodeObject:_ctype forKey:kMarkModelCtype];
    [aCoder encodeObject:_tp forKey:kMarkModelTp];
    [aCoder encodeObject:_juli forKey:kMarkModelJuli];
    [aCoder encodeDouble:_sumCar forKey:kMarkModelSumCar];
    [aCoder encodeObject:_charge forKey:kMarkModelCharge];
    [aCoder encodeObject:_time forKey:kMarkModelTime];
    [aCoder encodeObject:_ckid forKey:kMarkModelCkid];
    [aCoder encodeObject:_dz forKey:kMarkModelDz];
    [aCoder encodeDouble:_total forKey:kMarkModelTotal];
    [aCoder encodeObject:_lat forKey:kMarkModelLat];
    [aCoder encodeObject:_lng forKey:kMarkModelLng];
    [aCoder encodeObject:_totalNumber forKey:kMarkModelTotalNumber];
}

- (id)copyWithZone:(NSZone *)zone
{
    MarkModel *copy = [[MarkModel alloc] init];
    
    if (copy) {

        copy.cname = [self.cname copyWithZone:zone];
        copy.sycw = self.sycw;
        copy.ptype = [self.ptype copyWithZone:zone];
        copy.ctype = [self.ctype copyWithZone:zone];
        copy.tp = [self.tp copyWithZone:zone];
        copy.juli = [self.juli copyWithZone:zone];
        copy.sumCar = self.sumCar;
        copy.charge = [self.charge copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.ckid = [self.ckid copyWithZone:zone];
        copy.dz = [self.dz copyWithZone:zone];
        copy.total = self.total;
        copy.lat = [self.lat copyWithZone:zone];
        copy.lng = [self.lng copyWithZone:zone];
        copy.totalNumber = [self.totalNumber copyWithZone:zone];
    }
    
    return copy;
}


@end
