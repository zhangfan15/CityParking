//
//  BusLineCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/13.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusLineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startLocation;
@property (weak, nonatomic) IBOutlet UILabel *endLocation;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *busTime;

@end
