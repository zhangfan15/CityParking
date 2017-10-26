//
//  CouponCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/26.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *couponBack;
@property (weak, nonatomic) IBOutlet UILabel *couponMoney;
@property (weak, nonatomic) IBOutlet UILabel *couponState;
@property (weak, nonatomic) IBOutlet UILabel *couponName;
@property (weak, nonatomic) IBOutlet UILabel *couponGetTime;
@property (weak, nonatomic) IBOutlet UILabel *couponUntilTime;

@end
