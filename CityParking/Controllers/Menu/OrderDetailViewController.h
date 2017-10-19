//
//  OrderDetailViewController.h
//  CityParking
//
//  Created by ZhangFan on 2017/10/16.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "public.h"
@class BookingOrderModel;
@interface OrderDetailViewController : UIViewController{
    BookingOrderModel * bookModel;
}

@property (nonatomic, strong) BookingOrderModel * bookModel;

@end
