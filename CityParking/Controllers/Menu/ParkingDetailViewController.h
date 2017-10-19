//
//  ParkingDetailViewController.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/16.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "public.h"

@class MarkModel;
@interface ParkingDetailViewController : UIViewController{
    MarkModel * markModel;
}

@property (nonatomic, strong) MarkModel * markModel;

@end
