//
//  MyParkingModel.m
//
//  Created by 帆 张 on 2017/10/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "MyParkingModel.h"


NSString *const kMyParkingModelId = @"id";
NSString *const kMyParkingModelState = @"state";
NSString *const kMyParkingModelParkingNumber = @"parkingNumber";
NSString *const kMyParkingModelParkinglockid = @"parkinglockid";
NSString *const kMyParkingModelNote = @"note";
NSString *const kMyParkingModelCkid = @"ckid";
NSString *const kMyParkingModelVillagename = @"villagename";
NSString *const kMyParkingModelHyid = @"hyid";
NSString *const kMyParkingModelStreet = @"street";
NSString *const kMyParkingModelArea = @"area";
NSString *const kMyParkingModelTime = @"time";
NSString *const kMyParkingModelCeilphone = @"ceilphone";
NSString *const kMyParkingModelCity = @"city";
NSString *const kMyParkingModelAccid = @"accid";
NSString *const kMyParkingModelStatus = @"status";
NSString *const kMyParkingModelName = @"name";


@interface MyParkingModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MyParkingModel

@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize state = _state;
@synthesize parkingNumber = _parkingNumber;
@synthesize parkinglockid = _parkinglockid;
@synthesize note = _note;
@synthesize ckid = _ckid;
@synthesize villagename = _villagename;
@synthesize hyid = _hyid;
@synthesize street = _street;
@synthesize area = _area;
@synthesize time = _time;
@synthesize ceilphone = _ceilphone;
@synthesize city = _city;
@synthesize accid = _accid;
@synthesize status = _status;
@synthesize name = _name;


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
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kMyParkingModelId fromDictionary:dict] doubleValue];
            self.state = [[self objectOrNilForKey:kMyParkingModelState fromDictionary:dict] doubleValue];
            self.parkingNumber = [self objectOrNilForKey:kMyParkingModelParkingNumber fromDictionary:dict];
            self.parkinglockid = [self objectOrNilForKey:kMyParkingModelParkinglockid fromDictionary:dict];
            self.note = [self objectOrNilForKey:kMyParkingModelNote fromDictionary:dict];
            self.ckid = [self objectOrNilForKey:kMyParkingModelCkid fromDictionary:dict];
            self.villagename = [self objectOrNilForKey:kMyParkingModelVillagename fromDictionary:dict];
            self.hyid = [self objectOrNilForKey:kMyParkingModelHyid fromDictionary:dict];
            self.street = [self objectOrNilForKey:kMyParkingModelStreet fromDictionary:dict];
            self.area = [self objectOrNilForKey:kMyParkingModelArea fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMyParkingModelTime fromDictionary:dict];
            self.ceilphone = [self objectOrNilForKey:kMyParkingModelCeilphone fromDictionary:dict];
            self.city = [self objectOrNilForKey:kMyParkingModelCity fromDictionary:dict];
            self.accid = [self objectOrNilForKey:kMyParkingModelAccid fromDictionary:dict];
            self.status = [self objectOrNilForKey:kMyParkingModelStatus fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMyParkingModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kMyParkingModelId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kMyParkingModelState];
    [mutableDict setValue:self.parkingNumber forKey:kMyParkingModelParkingNumber];
    [mutableDict setValue:self.parkinglockid forKey:kMyParkingModelParkinglockid];
    [mutableDict setValue:self.note forKey:kMyParkingModelNote];
    [mutableDict setValue:self.ckid forKey:kMyParkingModelCkid];
    [mutableDict setValue:self.villagename forKey:kMyParkingModelVillagename];
    [mutableDict setValue:self.hyid forKey:kMyParkingModelHyid];
    [mutableDict setValue:self.street forKey:kMyParkingModelStreet];
    [mutableDict setValue:self.area forKey:kMyParkingModelArea];
    [mutableDict setValue:self.time forKey:kMyParkingModelTime];
    [mutableDict setValue:self.ceilphone forKey:kMyParkingModelCeilphone];
    [mutableDict setValue:self.city forKey:kMyParkingModelCity];
    [mutableDict setValue:self.accid forKey:kMyParkingModelAccid];
    [mutableDict setValue:self.status forKey:kMyParkingModelStatus];
    [mutableDict setValue:self.name forKey:kMyParkingModelName];

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

    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kMyParkingModelId];
    self.state = [aDecoder decodeDoubleForKey:kMyParkingModelState];
    self.parkingNumber = [aDecoder decodeObjectForKey:kMyParkingModelParkingNumber];
    self.parkinglockid = [aDecoder decodeObjectForKey:kMyParkingModelParkinglockid];
    self.note = [aDecoder decodeObjectForKey:kMyParkingModelNote];
    self.ckid = [aDecoder decodeObjectForKey:kMyParkingModelCkid];
    self.villagename = [aDecoder decodeObjectForKey:kMyParkingModelVillagename];
    self.hyid = [aDecoder decodeObjectForKey:kMyParkingModelHyid];
    self.street = [aDecoder decodeObjectForKey:kMyParkingModelStreet];
    self.area = [aDecoder decodeObjectForKey:kMyParkingModelArea];
    self.time = [aDecoder decodeObjectForKey:kMyParkingModelTime];
    self.ceilphone = [aDecoder decodeObjectForKey:kMyParkingModelCeilphone];
    self.city = [aDecoder decodeObjectForKey:kMyParkingModelCity];
    self.accid = [aDecoder decodeObjectForKey:kMyParkingModelAccid];
    self.status = [aDecoder decodeObjectForKey:kMyParkingModelStatus];
    self.name = [aDecoder decodeObjectForKey:kMyParkingModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kMyParkingModelId];
    [aCoder encodeDouble:_state forKey:kMyParkingModelState];
    [aCoder encodeObject:_parkingNumber forKey:kMyParkingModelParkingNumber];
    [aCoder encodeObject:_parkinglockid forKey:kMyParkingModelParkinglockid];
    [aCoder encodeObject:_note forKey:kMyParkingModelNote];
    [aCoder encodeObject:_ckid forKey:kMyParkingModelCkid];
    [aCoder encodeObject:_villagename forKey:kMyParkingModelVillagename];
    [aCoder encodeObject:_hyid forKey:kMyParkingModelHyid];
    [aCoder encodeObject:_street forKey:kMyParkingModelStreet];
    [aCoder encodeObject:_area forKey:kMyParkingModelArea];
    [aCoder encodeObject:_time forKey:kMyParkingModelTime];
    [aCoder encodeObject:_ceilphone forKey:kMyParkingModelCeilphone];
    [aCoder encodeObject:_city forKey:kMyParkingModelCity];
    [aCoder encodeObject:_accid forKey:kMyParkingModelAccid];
    [aCoder encodeObject:_status forKey:kMyParkingModelStatus];
    [aCoder encodeObject:_name forKey:kMyParkingModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyParkingModel *copy = [[MyParkingModel alloc] init];
    
    if (copy) {

        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.state = self.state;
        copy.parkingNumber = [self.parkingNumber copyWithZone:zone];
        copy.parkinglockid = [self.parkinglockid copyWithZone:zone];
        copy.note = [self.note copyWithZone:zone];
        copy.ckid = [self.ckid copyWithZone:zone];
        copy.villagename = [self.villagename copyWithZone:zone];
        copy.hyid = [self.hyid copyWithZone:zone];
        copy.street = [self.street copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.ceilphone = [self.ceilphone copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.accid = [self.accid copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
