//
//  MapEditCell.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/12.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MapEditCell.h"
#import "public.h"

@implementation MapEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews {
//    CGRect rect = self.frame;
//    rect.origin.x = 10;
//    rect.size.width -= 20;
//    self.frame = rect;
//    CGRect rect1 = self.contentView.frame;
//    rect1.size.width -= 20;
//    self.contentView.frame = rect1;
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
//    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
