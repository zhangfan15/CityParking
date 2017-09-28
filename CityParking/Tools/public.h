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
#import "LoginViewController.h"

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
#import "RKDropdownAlert.h"
#import "TYAlertController.h"

#import "MarkModel.h"
#import "UserInfo.h"

#define BaseURLString @"http://cis.3swest.com/"

#define IS_FIRST_LAUNCH   @"IS_FIRST_LAUNCH"  //记录是否第一次启动程序
#define USER_INFORMATION   @"USER_INFORMATION"
#define MainStoryboard    [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define IS_LOGINSUCCESS   @"IS_LOGINSUCCESS"
#define USER_INFOR_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo"]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CollectionHeight SCREEN_WIDTH/2+10
#define Y1               50
#define Y3               SCREEN_HEIGHT - CollectionHeight - 20

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0green:(((s &0xFF00) >>8))/255.0blue:((s &0xFF))/255.0alpha:1.0]

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#endif /* public_h */
