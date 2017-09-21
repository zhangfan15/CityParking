//
//  AppDelegate.h
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "public.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MBProgressHUD *hud;     //指示器


#pragma mark - hud
/**
 *  显示指示器
 */
- (void)showLoadingView;

/**
 *  隐藏指示器
 */
- (void)hideLoadingView;

@end

