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

/**
 进行get接受网络请求

 @param url 传入get所需要的URL地址
 @param params 传入get所用参数
 @param success 返回成功获取的数据
 @param failure 返回失败日志
 */
- (void)GetDataWithURL:(NSString *)url AndParams:(NSDictionary *)params Success:(void(^)(NSDictionary * responseObject))success Failure:(void(^)(NSString *errorInfo))failure;

/**
 进行post接受网络请求
 
 @param url 传入post所需要的URL地址
 @param params 传入post所用参数
 @param success 返回成功获取的数据
 @param failure 返回失败日志
 */
- (void)PostDataWithURL:(NSString *)url AndParams:(NSDictionary *)params IfJSONType:(BOOL)isJSON Success:(void(^)(NSDictionary * responseObject))success Failure:(void(^)(NSString *errorInfo))failure;

@end
