//
//  MapParkDataCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/13.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapParkDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView    *parkImage;
@property (weak, nonatomic) IBOutlet UILabel        *parkDistance;
@property (weak, nonatomic) IBOutlet UILabel        *parkName;
@property (weak, nonatomic) IBOutlet UILabel        *parkAdress;
@property (weak, nonatomic) IBOutlet UILabel        *parkTime;
@property (weak, nonatomic) IBOutlet UILabel        *parkNumber;
@property (weak, nonatomic) IBOutlet UILabel        *parkPrice;
@end
