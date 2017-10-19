//
//  ZuCheOrderModel.h
//
//  Created by 帆 张 on 2017/10/14
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZuCheOrderModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *qcckid;
@property (nonatomic, strong) NSString *hcckid;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *hyid;
@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) double state;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
