//
//  MenuCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView        *cellImage;
@property (weak, nonatomic) IBOutlet UILabel            *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellSubTitle;


@end
