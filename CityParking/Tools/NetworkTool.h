//
//  NetworkTool.h
//  CityParking
//
//  Created by ZhangFan on 2017/9/19.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "public.h"

@class AFHTTPSessionManager;

@interface NetworkTool : NSObject


@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

/**
 *  新建单例对象
 *
 *  @return 返回单例对象
 */
+(instancetype)shareNetworkTool;

#pragma mark - 意见反馈
/**
 *  检查网络连接情况
 */
-(void)checkNetworking;

#pragma mark - 获取所传参数
/**
 *  获取所传参数
 *
 *  @param number    Params.plist中的index
 *  @param parambody 如果有新添加参数的话使用新参数，否则使用默认
 *
 *  @return 返回参数
 */
- (NSDictionary *)GetParamValueWithNumber:(int)number AndParambody:(NSDictionary *)parambody;

#pragma mark - 进行post接受网络请求
/**
 *  进行post接受网络请求
 *
 *  @param parameters 传入post所用参数
 *  @param success    返回成功获取的数据
 *  @param failure    返回失败日志
 */
- (void)GetDataWithParams:(NSDictionary *)parameters AndParamNumber:(int)number Success:(void(^)(NSDictionary * responseObject))success Failure:(void(^)(NSString *errorInfo))failure;

@end
