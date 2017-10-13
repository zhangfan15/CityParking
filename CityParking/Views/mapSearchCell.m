//
//  MapSearchCell.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/29.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MapSearchCell.h"
#import "public.h"

@implementation MapSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    UIImage* searchBarBg = [self GetImageWithColor:[UIColor whiteColor] andHeight:44.0f];
    UIView *firstSubView = _searchBar.subviews.firstObject;
    UIView *backgroundImageView = [firstSubView.subviews firstObject];
    [backgroundImageView removeFromSuperview];
    UIView *searchBarTextField = [[_searchBar.subviews.firstObject subviews] firstObject];
    searchBarTextField.backgroundColor = [UIColor whiteColor];
    searchBarTextField.layer.cornerRadius = 5;
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapSearch"]];
    [searchBarTextField setValue:searchImage forKeyPath:@"leftView"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
