//
//  BookingOrderModel.m
//
//  Created by 帆 张 on 2017/10/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "BookingOrderModel.h"


NSString *const kBookingOrderModelTime = @"time";
NSString *const kBookingOrderModelOrderStatus = @"orderStatus";
NSString *const kBookingOrderModelArrdate = @"arrdate";
NSString *const kBookingOrderModelAccid = @"accid";
NSString *const kBookingOrderModelDeviceType = @"deviceType";
NSString *const kBookingOrderModelCname = @"cname";
NSString *const kBookingOrderModelLng = @"lng";
NSString *const kBookingOrderModelJuli = @"juli";
NSString *const kBookingOrderModelYylx = @"yylx";
NSString *const kBookingOrderModelDz = @"dz";
NSString *const kBookingOrderModelId = @"id";
NSString *const kBookingOrderModelHyid = @"hyid";
NSString *const kBookingOrderModelPlateNumber = @"plate_number";
NSString *const kBookingOrderModelParkingNumber = @"parkingNumber";
NSString *const kBookingOrderModelDepdate = @"depdate";
NSString *const kBookingOrderModelZffs = @"zffs";
NSString *const kBookingOrderModelTp = @"tp";
NSString *const kBookingOrderModelPayStatus = @"payStatus";
NSString *const kBookingOrderModelCkid = @"ckid";
NSString *const kBookingOrderModelLat = @"lat";
NSString *const kBookingOrderModelPrice = @"price";
NSString *const kBookingOrderModelChannelId = @"channelId";


@interface BookingOrderModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BookingOrderModel

@synthesize time = _time;
@synthesize orderStatus = _orderStatus;
@synthesize arrdate = _arrdate;
@synthesize accid = _accid;
@synthesize deviceType = _deviceType;
@synthesize cname = _cname;
@synthesize lng = _lng;
@synthesize juli = _juli;
@synthesize yylx = _yylx;
@synthesize dz = _dz;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize hyid = _hyid;
@synthesize plateNumber = _plateNumber;
@synthesize parkingNumber = _parkingNumber;
@synthesize depdate = _depdate;
@synthesize zffs = _zffs;
@synthesize tp = _tp;
@synthesize payStatus = _payStatus;
@synthesize ckid = _ckid;
@synthesize lat = _lat;
@synthesize price = _price;
@synthesize channelId = _channelId;


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
            self.time = [self objectOrNilForKey:kBookingOrderModelTime fromDictionary:dict];
            self.orderStatus = [self objectOrNilForKey:kBookingOrderModelOrderStatus fromDictionary:dict];
            self.arrdate = [self objectOrNilForKey:kBookingOrderModelArrdate fromDictionary:dict];
            self.accid = [self objectOrNilForKey:kBookingOrderModelAccid fromDictionary:dict];
            self.deviceType = [[self objectOrNilForKey:kBookingOrderModelDeviceType fromDictionary:dict] doubleValue];
            self.cname = [self objectOrNilForKey:kBookingOrderModelCname fromDictionary:dict];
            self.lng = [self objectOrNilForKey:kBookingOrderModelLng fromDictionary:dict];
            self.juli = [self objectOrNilForKey:kBookingOrderModelJuli fromDictionary:dict];
            self.yylx = [self objectOrNilForKey:kBookingOrderModelYylx fromDictionary:dict];
            self.dz = [self objectOrNilForKey:kBookingOrderModelDz fromDictionary:dict];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kBookingOrderModelId fromDictionary:dict] doubleValue];
            self.hyid = [self objectOrNilForKey:kBookingOrderModelHyid fromDictionary:dict];
            self.plateNumber = [self objectOrNilForKey:kBookingOrderModelPlateNumber fromDictionary:dict];
            self.parkingNumber = [self objectOrNilForKey:kBookingOrderModelParkingNumber fromDictionary:dict];
            self.depdate = [self objectOrNilForKey:kBookingOrderModelDepdate fromDictionary:dict];
            self.zffs = [self objectOrNilForKey:kBookingOrderModelZffs fromDictionary:dict];
            self.tp = [self objectOrNilForKey:kBookingOrderModelTp fromDictionary:dict];
            self.payStatus = [self objectOrNilForKey:kBookingOrderModelPayStatus fromDictionary:dict];
            self.ckid = [self objectOrNilForKey:kBookingOrderModelCkid fromDictionary:dict];
            self.lat = [self objectOrNilForKey:kBookingOrderModelLat fromDictionary:dict];
            self.price = [[self objectOrNilForKey:kBookingOrderModelPrice fromDictionary:dict] doubleValue];
            self.channelId = [self objectOrNilForKey:kBookingOrderModelChannelId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.time forKey:kBookingOrderModelTime];
    [mutableDict setValue:self.orderStatus forKey:kBookingOrderModelOrderStatus];
    [mutableDict setValue:self.arrdate forKey:kBookingOrderModelArrdate];
    [mutableDict setValue:self.accid forKey:kBookingOrderModelAccid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deviceType] forKey:kBookingOrderModelDeviceType];
    [mutableDict setValue:self.cname forKey:kBookingOrderModelCname];
    [mutableDict setValue:self.lng forKey:kBookingOrderModelLng];
    [mutableDict setValue:self.juli forKey:kBookingOrderModelJuli];
    [mutableDict setValue:self.yylx forKey:kBookingOrderModelYylx];
    [mutableDict setValue:self.dz forKey:kBookingOrderModelDz];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kBookingOrderModelId];
    [mutableDict setValue:self.hyid forKey:kBookingOrderModelHyid];
    [mutableDict setValue:self.plateNumber forKey:kBookingOrderModelPlateNumber];
    [mutableDict setValue:self.parkingNumber forKey:kBookingOrderModelParkingNumber];
    [mutableDict setValue:self.depdate forKey:kBookingOrderModelDepdate];
    [mutableDict setValue:self.zffs forKey:kBookingOrderModelZffs];
    [mutableDict setValue:self.tp forKey:kBookingOrderModelTp];
    [mutableDict setValue:self.payStatus forKey:kBookingOrderModelPayStatus];
    [mutableDict setValue:self.ckid forKey:kBookingOrderModelCkid];
    [mutableDict setValue:self.lat forKey:kBookingOrderModelLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kBookingOrderModelPrice];
    [mutableDict setValue:self.channelId forKey:kBookingOrderModelChannelId];

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

    self.time = [aDecoder decodeObjectForKey:kBookingOrderModelTime];
    self.orderStatus = [aDecoder decodeObjectForKey:kBookingOrderModelOrderStatus];
    self.arrdate = [aDecoder decodeObjectForKey:kBookingOrderModelArrdate];
    self.accid = [aDecoder decodeObjectForKey:kBookingOrderModelAccid];
    self.deviceType = [aDecoder decodeDoubleForKey:kBookingOrderModelDeviceType];
    self.cname = [aDecoder decodeObjectForKey:kBookingOrderModelCname];
    self.lng = [aDecoder decodeObjectForKey:kBookingOrderModelLng];
    self.juli = [aDecoder decodeObjectForKey:kBookingOrderModelJuli];
    self.yylx = [aDecoder decodeObjectForKey:kBookingOrderModelYylx];
    self.dz = [aDecoder decodeObjectForKey:kBookingOrderModelDz];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kBookingOrderModelId];
    self.hyid = [aDecoder decodeObjectForKey:kBookingOrderModelHyid];
    self.plateNumber = [aDecoder decodeObjectForKey:kBookingOrderModelPlateNumber];
    self.parkingNumber = [aDecoder decodeObjectForKey:kBookingOrderModelParkingNumber];
    self.depdate = [aDecoder decodeObjectForKey:kBookingOrderModelDepdate];
    self.zffs = [aDecoder decodeObjectForKey:kBookingOrderModelZffs];
    self.tp = [aDecoder decodeObjectForKey:kBookingOrderModelTp];
    self.payStatus = [aDecoder decodeObjectForKey:kBookingOrderModelPayStatus];
    self.ckid = [aDecoder decodeObjectForKey:kBookingOrderModelCkid];
    self.lat = [aDecoder decodeObjectForKey:kBookingOrderModelLat];
    self.price = [aDecoder decodeDoubleForKey:kBookingOrderModelPrice];
    self.channelId = [aDecoder decodeObjectForKey:kBookingOrderModelChannelId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_time forKey:kBookingOrderModelTime];
    [aCoder encodeObject:_orderStatus forKey:kBookingOrderModelOrderStatus];
    [aCoder encodeObject:_arrdate forKey:kBookingOrderModelArrdate];
    [aCoder encodeObject:_accid forKey:kBookingOrderModelAccid];
    [aCoder encodeDouble:_deviceType forKey:kBookingOrderModelDeviceType];
    [aCoder encodeObject:_cname forKey:kBookingOrderModelCname];
    [aCoder encodeObject:_lng forKey:kBookingOrderModelLng];
    [aCoder encodeObject:_juli forKey:kBookingOrderModelJuli];
    [aCoder encodeObject:_yylx forKey:kBookingOrderModelYylx];
    [aCoder encodeObject:_dz forKey:kBookingOrderModelDz];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kBookingOrderModelId];
    [aCoder encodeObject:_hyid forKey:kBookingOrderModelHyid];
    [aCoder encodeObject:_plateNumber forKey:kBookingOrderModelPlateNumber];
    [aCoder encodeObject:_parkingNumber forKey:kBookingOrderModelParkingNumber];
    [aCoder encodeObject:_depdate forKey:kBookingOrderModelDepdate];
    [aCoder encodeObject:_zffs forKey:kBookingOrderModelZffs];
    [aCoder encodeObject:_tp forKey:kBookingOrderModelTp];
    [aCoder encodeObject:_payStatus forKey:kBookingOrderModelPayStatus];
    [aCoder encodeObject:_ckid forKey:kBookingOrderModelCkid];
    [aCoder encodeObject:_lat forKey:kBookingOrderModelLat];
    [aCoder encodeDouble:_price forKey:kBookingOrderModelPrice];
    [aCoder encodeObject:_channelId forKey:kBookingOrderModelChannelId];
}

- (id)copyWithZone:(NSZone *)zone
{
    BookingOrderModel *copy = [[BookingOrderModel alloc] init];
    
    if (copy) {

        copy.time = [self.time copyWithZone:zone];
        copy.orderStatus = [self.orderStatus copyWithZone:zone];
        copy.arrdate = [self.arrdate copyWithZone:zone];
        copy.accid = [self.accid copyWithZone:zone];
        copy.deviceType = self.deviceType;
        copy.cname = [self.cname copyWithZone:zone];
        copy.lng = [self.lng copyWithZone:zone];
        copy.juli = [self.juli copyWithZone:zone];
        copy.yylx = [self.yylx copyWithZone:zone];
        copy.dz = [self.dz copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.hyid = [self.hyid copyWithZone:zone];
        copy.plateNumber = [self.plateNumber copyWithZone:zone];
        copy.parkingNumber = [self.parkingNumber copyWithZone:zone];
        copy.depdate = [self.depdate copyWithZone:zone];
        copy.zffs = [self.zffs copyWithZone:zone];
        copy.tp = [self.tp copyWithZone:zone];
        copy.payStatus = [self.payStatus copyWithZone:zone];
        copy.ckid = [self.ckid copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.price = self.price;
        copy.channelId = [self.channelId copyWithZone:zone];
    }
    
    return copy;
}


@end
