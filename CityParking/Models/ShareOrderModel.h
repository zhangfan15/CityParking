//
//  ShareOrderModel.h
//
//  Created by 帆 张 on 2017/10/16
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ShareOrderModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double acczt;
@property (nonatomic, strong) NSString *shareid;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *hyid;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *accid;
@property (nonatomic, strong) NSString *phonenum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
