//
//  ParkingLotViewController.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/19.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "public.h"

@class MyParkingModel;
@interface ParkingLotViewController : UIViewController{
    MyParkingModel * lotModel;
}

@property (nonatomic, strong) MyParkingModel * lotModel;

@end
