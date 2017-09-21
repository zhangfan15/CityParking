//
//  MarkModel.h
//
//  Created by 帆 张 on 2017/9/19
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MarkModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cname;
@property (nonatomic, assign) double sycw;
@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, strong) NSString *ctype;
@property (nonatomic, strong) NSString *tp;
@property (nonatomic, strong) NSString *juli;
@property (nonatomic, assign) double sumCar;
@property (nonatomic, strong) NSString *charge;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *ckid;
@property (nonatomic, strong) NSString *dz;
@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *totalNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
