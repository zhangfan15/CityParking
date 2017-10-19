//
//  ShareOrderModel.m
//
//  Created by 帆 张 on 2017/10/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ShareOrderModel.h"


NSString *const kShareOrderModelAcczt = @"acczt";
NSString *const kShareOrderModelShareid = @"shareid";
NSString *const kShareOrderModelEndTime = @"endTime";
NSString *const kShareOrderModelHyid = @"hyid";
NSString *const kShareOrderModelCname = @"cname";
NSString *const kShareOrderModelPlateNumber = @"plateNumber";
NSString *const kShareOrderModelStartTime = @"startTime";
NSString *const kShareOrderModelAccid = @"accid";
NSString *const kShareOrderModelPhonenum = @"phonenum";


@interface ShareOrderModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShareOrderModel

@synthesize acczt = _acczt;
@synthesize shareid = _shareid;
@synthesize endTime = _endTime;
@synthesize hyid = _hyid;
@synthesize cname = _cname;
@synthesize plateNumber = _plateNumber;
@synthesize startTime = _startTime;
@synthesize accid = _accid;
@synthesize phonenum = _phonenum;


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
            self.acczt = [[self objectOrNilForKey:kShareOrderModelAcczt fromDictionary:dict] doubleValue];
            self.shareid = [self objectOrNilForKey:kShareOrderModelShareid fromDictionary:dict];
            self.endTime = [self objectOrNilForKey:kShareOrderModelEndTime fromDictionary:dict];
            self.hyid = [self objectOrNilForKey:kShareOrderModelHyid fromDictionary:dict];
            self.cname = [self objectOrNilForKey:kShareOrderModelCname fromDictionary:dict];
            self.plateNumber = [self objectOrNilForKey:kShareOrderModelPlateNumber fromDictionary:dict];
            self.startTime = [self objectOrNilForKey:kShareOrderModelStartTime fromDictionary:dict];
            self.accid = [self objectOrNilForKey:kShareOrderModelAccid fromDictionary:dict];
            self.phonenum = [self objectOrNilForKey:kShareOrderModelPhonenum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acczt] forKey:kShareOrderModelAcczt];
    [mutableDict setValue:self.shareid forKey:kShareOrderModelShareid];
    [mutableDict setValue:self.endTime forKey:kShareOrderModelEndTime];
    [mutableDict setValue:self.hyid forKey:kShareOrderModelHyid];
    [mutableDict setValue:self.cname forKey:kShareOrderModelCname];
    [mutableDict setValue:self.plateNumber forKey:kShareOrderModelPlateNumber];
    [mutableDict setValue:self.startTime forKey:kShareOrderModelStartTime];
    [mutableDict setValue:self.accid forKey:kShareOrderModelAccid];
    [mutableDict setValue:self.phonenum forKey:kShareOrderModelPhonenum];

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

    self.acczt = [aDecoder decodeDoubleForKey:kShareOrderModelAcczt];
    self.shareid = [aDecoder decodeObjectForKey:kShareOrderModelShareid];
    self.endTime = [aDecoder decodeObjectForKey:kShareOrderModelEndTime];
    self.hyid = [aDecoder decodeObjectForKey:kShareOrderModelHyid];
    self.cname = [aDecoder decodeObjectForKey:kShareOrderModelCname];
    self.plateNumber = [aDecoder decodeObjectForKey:kShareOrderModelPlateNumber];
    self.startTime = [aDecoder decodeObjectForKey:kShareOrderModelStartTime];
    self.accid = [aDecoder decodeObjectForKey:kShareOrderModelAccid];
    self.phonenum = [aDecoder decodeObjectForKey:kShareOrderModelPhonenum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_acczt forKey:kShareOrderModelAcczt];
    [aCoder encodeObject:_shareid forKey:kShareOrderModelShareid];
    [aCoder encodeObject:_endTime forKey:kShareOrderModelEndTime];
    [aCoder encodeObject:_hyid forKey:kShareOrderModelHyid];
    [aCoder encodeObject:_cname forKey:kShareOrderModelCname];
    [aCoder encodeObject:_plateNumber forKey:kShareOrderModelPlateNumber];
    [aCoder encodeObject:_startTime forKey:kShareOrderModelStartTime];
    [aCoder encodeObject:_accid forKey:kShareOrderModelAccid];
    [aCoder encodeObject:_phonenum forKey:kShareOrderModelPhonenum];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShareOrderModel *copy = [[ShareOrderModel alloc] init];
    
    if (copy) {

        copy.acczt = self.acczt;
        copy.shareid = [self.shareid copyWithZone:zone];
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.hyid = [self.hyid copyWithZone:zone];
        copy.cname = [self.cname copyWithZone:zone];
        copy.plateNumber = [self.plateNumber copyWithZone:zone];
        copy.startTime = [self.startTime copyWithZone:zone];
        copy.accid = [self.accid copyWithZone:zone];
        copy.phonenum = [self.phonenum copyWithZone:zone];
    }
    
    return copy;
}


@end
