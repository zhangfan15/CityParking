//
//  MarkCell.h
//  CityParking
//
//  Created by ZhangFan on 2017/9/29.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const MarkCellIdentifier = @"MarkCellIdentifier";
@interface MarkCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *verticalLine;
@property (weak, nonatomic) IBOutlet UILabel *horizontalLine;

@end
