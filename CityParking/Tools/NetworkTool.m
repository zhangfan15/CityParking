//
//  NetworkTool.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/19.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
static NetworkTool * tool = nil;

+(instancetype)shareNetworkTool {
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        tool = (NetworkTool *)@"NetworkTool";
        
        tool = [[NetworkTool alloc] init];
    });
    
    NSString * classString = @"NetworkTool";
    
    if ([classString isEqualToString:@"NetworkTool"] == NO) {
        NSParameterAssert(nil);
    }
    
    return tool;
}

-(instancetype)init {
    NSString * string = (NSString *)tool;
    
    if ([string isKindOfClass:[NSString class]] == YES && [string isEqualToString:@"NetworkTool"]) {
        self = [super init];
        
        if (self) {
            _sessionManager = [AFHTTPSessionManager manager];
        }
        return self;
    }else {
        return nil;
    }
}

/**
 *  检查网络连接情况
 */
-(void)checkNetworking
{
    NSOperationQueue *operationQueue = _sessionManager.operationQueue;
    
    [_sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                [UIAlertAction actionWithTitle:@"当前网络不可用，请检查你的网络设置" style:UIAlertActionStyleCancel handler:nil];
                break;
            }
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [_sessionManager.reachabilityManager startMonitoring];
}

#pragma mark - 获取所传参数
/**
 *  获取所传参数
 *
 *  @param number    Params.plist中的index
 *  @param parambody 如果有新添加参数的话使用新参数，否则使用默认
 *
 *  @return 返回参数
 */
- (NSDictionary *)GetParamValueWithNumber:(int)number AndParambody:(NSDictionary *)parambody {
    NSMutableDictionary * RealParams = [[NSMutableDictionary alloc] init];
    
//    NSString *path                   = [[NSBundle mainBundle] pathForResource:@"Params"ofType:@"plist"];
//    //获取数据
//    NSMutableDictionary* dict        = [[ NSMutableDictionary alloc]initWithContentsOfFile:path];
//    NSArray * param                  = [dict objectForKey:@"Param"];
//    
//    NSDictionary * parambodyTest     = [param objectAtIndex:number];
//    
//    [RealParams setValue:[parambodyTest valueForKey:@"method"] forKey:@"method"];
//    
//    [RealParams setValue:[parambodyTest valueForKey:@"service"] forKey:@"service"];
//    
//    NSString * dataStr               = [NSString stringWithFormat:@"%@@%@",[parambodyTest objectForKey:@"service"],[parambodyTest objectForKey:@"method"]];
//    
//    NSString * md5Sign               = [DES encryptUseDES:dataStr key:MD5Key];
//    
//    [RealParams setValue:md5Sign forKey:@"sign"];
//    
//    NSMutableDictionary * dic               = [parambodyTest objectForKey:@"params"];
//    
//    if ([parambody count] == 0){
//        
//        if ([NSJSONSerialization isValidJSONObject:dic]){
//            
//            [RealParams setValue:@"" forKey:@"params"];
//        }
//    }else{
//        
//        NSMutableDictionary * tempDic = [NSMutableDictionary dictionaryWithDictionary:parambody];
//        
//        if ([NSJSONSerialization isValidJSONObject:tempDic]){
//            
//            NSError *error;
//            
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempDic options:NSJSONWritingPrettyPrinted error:&error];
//            
//            NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//            
//            [RealParams setValue:json forKey:@"params"];
//        }
//    }
    
    return RealParams;
}

#pragma mark - 进行post接受网络请求
/**
 *  进行post接受网络请求
 *
 *  @param parameters 传入post所用参数
 *  @param success    返回成功获取的数据
 *  @param failure    返回失败日志
 */
- (void)GetDataWithParams:(NSDictionary *)parameters AndParamNumber:(int)number Success:(void (^)(NSDictionary *))success Failure:(void (^)(NSString *))failure {
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate showLoadingView];
    
//    NSDictionary *param = @{@"user_id":userId, @"sale_date":date, @"accessToken":@"e9c0e60318ebd07ec2fe", @"area_type":areaType};
    // 创建请求类
    _sessionManager.requestSerializer.timeoutInterval = 60.0;
    
    [_sessionManager GET:BaseURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [(AppDelegate *)[UIApplication sharedApplication].delegate hideLoadingView];
        NSString *  SuccessStatus = responseObject[@"message"];
        if (responseObject){
                        if ([SuccessStatus isEqualToString:@"success"]){
                            success(responseObject);
                        }else {
                            failure(responseObject[@"message"]);
                        }
                    }else {
                        NSLog(@"网络请求失败");
                    }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [(AppDelegate *)[UIApplication sharedApplication].delegate hideLoadingView];
        //        NSLog(@"网络请求失败");
    }];
}

-(void)GetDataWithURL:(NSString *)url AndParams:(NSDictionary *)params Success:(void (^)(NSDictionary *))success Failure:(void (^)(NSString *))failure {
    [(AppDelegate *)[UIApplication sharedApplication].delegate showLoadingView];
    
    //    NSDictionary *param = @{@"user_id":userId, @"sale_date":date, @"accessToken":@"e9c0e60318ebd07ec2fe", @"area_type":areaType};
    // 创建请求类
    _sessionManager.requestSerializer.timeoutInterval = 60.0;
    
    NSString * httpURL = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    
    [_sessionManager GET:httpURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [(AppDelegate *)[UIApplication sharedApplication].delegate hideLoadingView];
        NSString *  SuccessStatus = responseObject[@"message"];
        if (responseObject){
            if ([SuccessStatus isEqualToString:@"success"]){
                success(responseObject);
            }else {
                failure(responseObject[@"message"]);
            }
        }else {
            NSLog(@"网络请求失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [(AppDelegate *)[UIApplication sharedApplication].delegate hideLoadingView];
        //        NSLog(@"网络请求失败");
    }];
}

-(void)PostDataWithURL:(NSString *)url AndParams:(NSDictionary *)params IfShowHUD:(BOOL)isShowHUD Success:(void (^)(NSDictionary *))success Failure:(void (^)(NSString *))failure {
    if (isShowHUD) {
        [(AppDelegate *)[UIApplication sharedApplication].delegate showLoadingView];
    }
    // 创建请求类
    _sessionManager.requestSerializer.timeoutInterval = 60.0;
    
    NSString * httpURL = [NSString stringWithFormat:@"%@%@",BaseURLString,url];
    
    [_sessionManager POST:httpURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功
        [(AppDelegate *)[UIApplication sharedApplication].delegate hideLoadingView];
        NSString *  SuccessStatus = responseObject[@"message"];
        if (responseObject){
            if ([SuccessStatus isEqualToString:@"success"]){
                success(responseObject);
            }else {
                failure(responseObject[@"message"]);
            }
        }else {
            NSLog(@"网络请求失败");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [(AppDelegate *)[UIApplication sharedApplication].delegate hideLoadingView];
        //        NSLog(@"网络请求失败");
    }];
}

@end
