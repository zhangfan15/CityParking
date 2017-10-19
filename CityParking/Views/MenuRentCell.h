//
//  MenuRentCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/13.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuRentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;

@end
