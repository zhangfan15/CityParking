//
//  ZuCheOrderModel.m
//
//  Created by 帆 张 on 2017/10/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ZuCheOrderModel.h"


NSString *const kZuCheOrderModelQcckid = @"qcckid";
NSString *const kZuCheOrderModelHcckid = @"hcckid";
NSString *const kZuCheOrderModelId = @"id";
NSString *const kZuCheOrderModelEndTime = @"endTime";
NSString *const kZuCheOrderModelHyid = @"hyid";
NSString *const kZuCheOrderModelPlateNumber = @"plateNumber";
NSString *const kZuCheOrderModelStartTime = @"startTime";
NSString *const kZuCheOrderModelState = @"state";


@interface ZuCheOrderModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZuCheOrderModel

@synthesize qcckid = _qcckid;
@synthesize hcckid = _hcckid;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize endTime = _endTime;
@synthesize hyid = _hyid;
@synthesize plateNumber = _plateNumber;
@synthesize startTime = _startTime;
@synthesize state = _state;


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
            self.qcckid = [self objectOrNilForKey:kZuCheOrderModelQcckid fromDictionary:dict];
            self.hcckid = [self objectOrNilForKey:kZuCheOrderModelHcckid fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kZuCheOrderModelId fromDictionary:dict] doubleValue];
            self.endTime = [self objectOrNilForKey:kZuCheOrderModelEndTime fromDictionary:dict];
            self.hyid = [self objectOrNilForKey:kZuCheOrderModelHyid fromDictionary:dict];
            self.plateNumber = [self objectOrNilForKey:kZuCheOrderModelPlateNumber fromDictionary:dict];
            self.startTime = [self objectOrNilForKey:kZuCheOrderModelStartTime fromDictionary:dict];
            self.state = [[self objectOrNilForKey:kZuCheOrderModelState fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qcckid forKey:kZuCheOrderModelQcckid];
    [mutableDict setValue:self.hcckid forKey:kZuCheOrderModelHcckid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kZuCheOrderModelId];
    [mutableDict setValue:self.endTime forKey:kZuCheOrderModelEndTime];
    [mutableDict setValue:self.hyid forKey:kZuCheOrderModelHyid];
    [mutableDict setValue:self.plateNumber forKey:kZuCheOrderModelPlateNumber];
    [mutableDict setValue:self.startTime forKey:kZuCheOrderModelStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kZuCheOrderModelState];

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

    self.qcckid = [aDecoder decodeObjectForKey:kZuCheOrderModelQcckid];
    self.hcckid = [aDecoder decodeObjectForKey:kZuCheOrderModelHcckid];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kZuCheOrderModelId];
    self.endTime = [aDecoder decodeObjectForKey:kZuCheOrderModelEndTime];
    self.hyid = [aDecoder decodeObjectForKey:kZuCheOrderModelHyid];
    self.plateNumber = [aDecoder decodeObjectForKey:kZuCheOrderModelPlateNumber];
    self.startTime = [aDecoder decodeObjectForKey:kZuCheOrderModelStartTime];
    self.state = [aDecoder decodeDoubleForKey:kZuCheOrderModelState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_qcckid forKey:kZuCheOrderModelQcckid];
    [aCoder encodeObject:_hcckid forKey:kZuCheOrderModelHcckid];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kZuCheOrderModelId];
    [aCoder encodeObject:_endTime forKey:kZuCheOrderModelEndTime];
    [aCoder encodeObject:_hyid forKey:kZuCheOrderModelHyid];
    [aCoder encodeObject:_plateNumber forKey:kZuCheOrderModelPlateNumber];
    [aCoder encodeObject:_startTime forKey:kZuCheOrderModelStartTime];
    [aCoder encodeDouble:_state forKey:kZuCheOrderModelState];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZuCheOrderModel *copy = [[ZuCheOrderModel alloc] init];
    
    if (copy) {

        copy.qcckid = [self.qcckid copyWithZone:zone];
        copy.hcckid = [self.hcckid copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.endTime = [self.endTime copyWithZone:zone];
        copy.hyid = [self.hyid copyWithZone:zone];
        copy.plateNumber = [self.plateNumber copyWithZone:zone];
        copy.startTime = [self.startTime copyWithZone:zone];
        copy.state = self.state;
    }
    
    return copy;
}


@end
