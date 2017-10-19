//
//  MyParkingModel.h
//
//  Created by 帆 张 on 2017/10/17
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MyParkingModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double state;
@property (nonatomic, strong) NSString *parkingNumber;
@property (nonatomic, strong) NSString *parkinglockid;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *ckid;
@property (nonatomic, strong) NSString *villagename;
@property (nonatomic, strong) NSString *hyid;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *ceilphone;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *accid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
