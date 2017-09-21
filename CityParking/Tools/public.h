//
//  public.h
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#ifndef public_h
#define public_h

#import "MainViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "NetworkTool.h"

#import "MenuCell.h"
#import "MarkCollectionViewCell.h"
#import "mapEditCell.h"
#import "MapParkCell.h"
#import "mapSearchCell.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKSearchComponent.h>
#import <AFNetworking/AFHTTPSessionManager.h>

#import "MarkModel.h"

#define BaseURLString @"http://cis.3swest.com/mobile/ratecod/queryAllParking"

#define IS_FIRST_LAUNCH   @"IS_FIRST_LAUNCH"  //记录是否第一次启动程序

#define MainStoryboard    [UIStoryboard storyboardWithName:@"Main" bundle:nil]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#endif /* public_h */
