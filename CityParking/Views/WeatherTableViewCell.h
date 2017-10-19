//
//  WeatherTableViewCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/17.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *weatherDate;
@property (weak, nonatomic) IBOutlet UILabel *todayWeather;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowWeather;
@property (weak, nonatomic) IBOutlet UILabel *weatherAddress;

@end
