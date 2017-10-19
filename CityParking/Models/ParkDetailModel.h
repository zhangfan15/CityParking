//
//  ParkDetailModel.h
//
//  Created by 帆 张 on 2017/10/18
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ParkDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double   floor;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *ckid;
@property (nonatomic, strong) NSString *plateNumber;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *ptype;
@property (nonatomic, strong) NSString *accid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
