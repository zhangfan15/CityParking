//
//  BookingOrderModel.h
//
//  Created by 帆 张 on 2017/10/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BookingOrderModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *arrdate;
@property (nonatomic, strong) NSString *accid;
@property (nonatomic, assign) double deviceType;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *juli;
@property (nonatomic, strong) NSString *yylx;
@property (nonatomic, strong) NSString *dz;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *hyid;
@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, strong) NSString *parkingNumber;
@property (nonatomic, strong) NSString *depdate;
@property (nonatomic, strong) NSString *zffs;
@property (nonatomic, strong) NSString *tp;
@property (nonatomic, strong) NSString *payStatus;
@property (nonatomic, strong) NSString *ckid;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, assign) double price;
@property (nonatomic, strong) NSString *channelId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
