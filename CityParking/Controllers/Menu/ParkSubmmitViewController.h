//
//  ParkSubmmitViewController.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "public.h"
#import "ParkDetailModel.h"
#import "MarkModel.h"

@interface ParkSubmmitViewController : UIViewController {
    ParkDetailModel * detailmodel;
    MarkModel       * markModel;
}

@property (nonatomic, strong) ParkDetailModel * detailmodel;
@property (nonatomic, strong) MarkModel       * markModel;

@end
