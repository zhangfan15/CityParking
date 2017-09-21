//
//  Data.m
//
//  Created by 帆 张 on 2017/9/20
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Data.h"


NSString *const kDataCname = @"cname";
NSString *const kDataSycw = @"sycw";
NSString *const kDataPtype = @"ptype";
NSString *const kDataCtype = @"ctype";
NSString *const kDataTp = @"tp";
NSString *const kDataJuli = @"juli";
NSString *const kDataSumCar = @"sumCar";
NSString *const kDataCharge = @"charge";
NSString *const kDataTime = @"time";
NSString *const kDataCkid = @"ckid";
NSString *const kDataDz = @"dz";
NSString *const kDataTotal = @"total";
NSString *const kDataLat = @"lat";
NSString *const kDataLng = @"lng";
NSString *const kDataTotalNumber = @"totalNumber";


@interface Data ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Data

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
            self.cname = [self objectOrNilForKey:kDataCname fromDictionary:dict];
            self.sycw = [[self objectOrNilForKey:kDataSycw fromDictionary:dict] doubleValue];
            self.ptype = [self objectOrNilForKey:kDataPtype fromDictionary:dict];
            self.ctype = [self objectOrNilForKey:kDataCtype fromDictionary:dict];
            self.tp = [self objectOrNilForKey:kDataTp fromDictionary:dict];
            self.juli = [self objectOrNilForKey:kDataJuli fromDictionary:dict];
            self.sumCar = [[self objectOrNilForKey:kDataSumCar fromDictionary:dict] doubleValue];
            self.charge = [self objectOrNilForKey:kDataCharge fromDictionary:dict];
            self.time = [self objectOrNilForKey:kDataTime fromDictionary:dict];
            self.ckid = [self objectOrNilForKey:kDataCkid fromDictionary:dict];
            self.dz = [self objectOrNilForKey:kDataDz fromDictionary:dict];
            self.total = [[self objectOrNilForKey:kDataTotal fromDictionary:dict] doubleValue];
            self.lat = [self objectOrNilForKey:kDataLat fromDictionary:dict];
            self.lng = [self objectOrNilForKey:kDataLng fromDictionary:dict];
            self.totalNumber = [self objectOrNilForKey:kDataTotalNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cname forKey:kDataCname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sycw] forKey:kDataSycw];
    [mutableDict setValue:self.ptype forKey:kDataPtype];
    [mutableDict setValue:self.ctype forKey:kDataCtype];
    [mutableDict setValue:self.tp forKey:kDataTp];
    [mutableDict setValue:self.juli forKey:kDataJuli];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sumCar] forKey:kDataSumCar];
    [mutableDict setValue:self.charge forKey:kDataCharge];
    [mutableDict setValue:self.time forKey:kDataTime];
    [mutableDict setValue:self.ckid forKey:kDataCkid];
    [mutableDict setValue:self.dz forKey:kDataDz];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kDataTotal];
    [mutableDict setValue:self.lat forKey:kDataLat];
    [mutableDict setValue:self.lng forKey:kDataLng];
    [mutableDict setValue:self.totalNumber forKey:kDataTotalNumber];

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

    self.cname = [aDecoder decodeObjectForKey:kDataCname];
    self.sycw = [aDecoder decodeDoubleForKey:kDataSycw];
    self.ptype = [aDecoder decodeObjectForKey:kDataPtype];
    self.ctype = [aDecoder decodeObjectForKey:kDataCtype];
    self.tp = [aDecoder decodeObjectForKey:kDataTp];
    self.juli = [aDecoder decodeObjectForKey:kDataJuli];
    self.sumCar = [aDecoder decodeDoubleForKey:kDataSumCar];
    self.charge = [aDecoder decodeObjectForKey:kDataCharge];
    self.time = [aDecoder decodeObjectForKey:kDataTime];
    self.ckid = [aDecoder decodeObjectForKey:kDataCkid];
    self.dz = [aDecoder decodeObjectForKey:kDataDz];
    self.total = [aDecoder decodeDoubleForKey:kDataTotal];
    self.lat = [aDecoder decodeObjectForKey:kDataLat];
    self.lng = [aDecoder decodeObjectForKey:kDataLng];
    self.totalNumber = [aDecoder decodeObjectForKey:kDataTotalNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cname forKey:kDataCname];
    [aCoder encodeDouble:_sycw forKey:kDataSycw];
    [aCoder encodeObject:_ptype forKey:kDataPtype];
    [aCoder encodeObject:_ctype forKey:kDataCtype];
    [aCoder encodeObject:_tp forKey:kDataTp];
    [aCoder encodeObject:_juli forKey:kDataJuli];
    [aCoder encodeDouble:_sumCar forKey:kDataSumCar];
    [aCoder encodeObject:_charge forKey:kDataCharge];
    [aCoder encodeObject:_time forKey:kDataTime];
    [aCoder encodeObject:_ckid forKey:kDataCkid];
    [aCoder encodeObject:_dz forKey:kDataDz];
    [aCoder encodeDouble:_total forKey:kDataTotal];
    [aCoder encodeObject:_lat forKey:kDataLat];
    [aCoder encodeObject:_lng forKey:kDataLng];
    [aCoder encodeObject:_totalNumber forKey:kDataTotalNumber];
}

- (id)copyWithZone:(NSZone *)zone
{
    Data *copy = [[Data alloc] init];
    
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
