//
//  LFAPIClientManager.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "LFAPIClientManager.h"
#import "CHBaseRequestModel.h"
#import <MJExtension/MJExtension.h>
@implementation LFAPIClientManager

#pragma mark --- base 请求
+ (void)basePostRequestWithParam:(id)params showSystemLoading:(BOOL)show loadingText:(NSString *)text success:(successResponse)success failure:(failResponse)failuer refresh:(refreshBlock)refresh alert:(alertBlock)alert{
    if (show) {
       //显示请求菊花
    }else if(nil != text){
        //如果文字不为空，说明显示提示语
    }
#pragma mark -- 参数容错处理
    NSMutableDictionary *finalParam = [NSMutableDictionary dictionary];
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSDictionary *paramsDic = (NSDictionary *)params;
        finalParam = paramsDic.mutableCopy;
    }else if([params isKindOfClass:[CHBaseRequestModel class]]){
        CHBaseRequestModel *requestModel = (CHBaseRequestModel *)params;
        finalParam = requestModel.mj_keyValues.mutableCopy;
    }
    //二次确认用户信息
    if (![finalParam.allKeys containsObject:@"U"]) {
        
    }
    // 二次确认设备信息
    if (![finalParam.allKeys containsObject:@"deviceInfo"]) {
        
    }
    //此处对Url 做处理，比如域名，或者 是否是HTTPS
    NSString *urlString = [NSString stringWithFormat:@""];
    [self post:urlString host:@"" param:params progress:^(NSProgress * _Nonnull progress) {
    } success:^(id  _Nonnull responseObject, NSString * _Nonnull path) {
        //此处先隐藏菊花或者是Toast 提示
        //判断返回的结果responseObject
        if (responseObject) {
            //成功请求返回数据
            if (success) {
                success(responseObject,urlString);
            }
        }else{
            NSError *failError;
            if (failuer) {
                failuer(failError,urlString);
            }
        }
    } failure:^(NSError * _Nonnull error, NSString * _Nonnull path) {
        if (failuer) {
            failuer(error,urlString);
        }
    }];
}

#pragma mark --- get 请求
+ (void)baseGetRequestWithParam:(id)params showSystemLoading:(BOOL)show
                    loadingText:(NSString *)text
                        success:(successResponse)success
                        failure:(failResponse)failuer
                        refresh:(refreshBlock)refresh
                          alert:(alertBlock)alert{
    
    if (show) {
        //显示请求菊花
    }else if(nil != text){
        //如果文字不为空，说明显示提示语
    }
#pragma mark -- 参数容错处理
    NSMutableDictionary *finalParam = [NSMutableDictionary dictionary];
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSDictionary *paramsDic = (NSDictionary *)params;
        finalParam = paramsDic.mutableCopy;
    }else if([params isKindOfClass:[CHBaseRequestModel class]]){
        CHBaseRequestModel *requestModel = (CHBaseRequestModel *)params;
        finalParam = requestModel.mj_keyValues.mutableCopy;
    }
    //二次确认用户信息
    if (![finalParam.allKeys containsObject:@"U"]) {
        
    }
    // 二次确认设备信息
    if (![finalParam.allKeys containsObject:@"deviceInfo"]) {
        
    }
    //此处对Url 做处理，比如域名，或者 是否是HTTPS
    NSString *urlString = [NSString stringWithFormat:@""];
    [self get:urlString host:@"" param:finalParam progress:^(NSProgress * _Nonnull progress) {
    } success:^(id  _Nonnull responseObject, NSString * _Nonnull path) {
        //此处先隐藏菊花或者是Toast 提示
        //判断返回的结果responseObject
        if (responseObject) {
            //成功请求返回数据
            if (success) {
                success(responseObject,urlString);
            }
        }else{
            NSError *failError;
            if (failuer) {
                failuer(failError,urlString);
            }
        }
    } failure:^(NSError * _Nonnull error, NSString * _Nonnull path) {
        if (failuer) {
            failuer(error,urlString);
        }
    }];
    
}


@end
