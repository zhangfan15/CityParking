//
//  MyParkingCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/17.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyParkingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *parkingName;
@property (weak, nonatomic) IBOutlet UILabel *parkingNum;
@property (weak, nonatomic) IBOutlet UILabel *parkingState;

@end
