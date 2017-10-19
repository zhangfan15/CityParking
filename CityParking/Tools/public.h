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
#import "SecondViewController.h"
#import "MapViewController.h"
#import "RentOrderListViewController.h"
#import "OrderCenterViewController.h"
#import "OrderDetailViewController.h"
#import "MyInformationViewController.h"
#import "FindCarViewController.h"
#import "ParkingDetailViewController.h"
#import "MyParkingViewController.h"
#import "MenuViewController.h"
#import "AddParkingViewController.h"
#import "ParkingLotViewController.h"
#import "ParkSubmmitViewController.h"
#import "DetailInfoViewController.h"

#import "MenuCell.h"
#import "MarkCollectionViewCell.h"
#import "MapEditCell.h"
#import "MapParkCell.h"
#import "MapSearchCell.h"
#import "MarkCell.h"
#import "MapAddCell.h"
#import "BusLineCell.h"
#import "SectionTitleCell.h"
#import "MapParkDataCell.h"
#import "MenuRentCell.h"
#import "ShareOrderCell.h"
#import "BookingOrderCell.h"
#import "OrderDetailCell.h"
#import "ParkingCell.h"
#import "MyParkingCell.h"
#import "WeatherTableViewCell.h"

#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "AppDelegate.h"
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapKit/BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapKit/BaiduMapAPI_Search/BMKSearchComponent.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <RKDropdownAlert/RKDropdownAlert.h>
#import <TYAlertController/TYAlertController.h>
#import <MapKit/MapKit.h>
#import <MJRefresh/MJRefresh.h>
#import "AddressPickerView.h"

#import "MarkModel.h"
#import "UserInfo.h"
#import "ZuCheOrderModel.h"
#import "BookingOrderModel.h"
#import "ShareOrderModel.h"
#import "MyParkingModel.h"
#import "ParkDetailModel.h"

#define BaseURLString @"http://cis.3swest.com/"

//#define BaseURLString @"http://192.168.0.71:8080/"

#define IS_FIRST_LAUNCH   @"IS_FIRST_LAUNCH"  //记录是否第一次启动程序
#define GetMapDataSuccessed   @"GetMapDataFromServerSuccessed"
#define USER_INFORMATION   @"USER_INFORMATION"
#define USER_LOCATION   @"USER_LOCATION"
#define MainStoryboard    [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define IS_LOGINSUCCESS   @"IS_LOGINSUCCESS"
#define USER_INFOR_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo"]
#define UserInformation   [NSKeyedUnarchiver unarchiveObjectWithFile:USER_INFOR_PATH]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define CollectionHeight ((SCREEN_WIDTH-20)/5)*2
#define FRAME_W(view) view.frame.size.width
#define FRAME_H(view) view.frame.size.height
#define Y1               50
#define Y2               self.view.frame.size.height - 250
#define Y3               SCREEN_HEIGHT - CollectionHeight - 20

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0green:(((s &0xFF00) >>8))/255.0blue:((s &0xFF))/255.0alpha:1.0]

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#endif /* public_h */
