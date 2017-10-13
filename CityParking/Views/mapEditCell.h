//
//  MapEditCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/12.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapEditCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;

@end
