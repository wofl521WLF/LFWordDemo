//
//  CHBaseAPIManagerTools.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/8.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "CHBaseAPIManagerTools.h"
#import "CHTextResponseSerializer.h"
#import "LFGloabelConfigTools.h"
#import "CHBaseResponseModel.h"
#import <MJExtension/MJExtension.h>
@implementation CHBaseAPIManagerTools

+ (AFHTTPSessionManager *)shareAPIManagerTools{
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [CHTextResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/javascript", @"text/json",@"text/html",nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        manager.securityPolicy = [self getPolicy];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.0;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    });
    return manager;
}

+ (AFSecurityPolicy *)getPolicy{
    
    //先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"证书名字" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //AFSSLPinningModelCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidcertificates 是否允许无效证书（也就是自建证书），默认是NO
    //如果是需要验证自建证书，需要设置为YES
    //加入证书的域名与你请求的域名不一致，则需要把这一样设置为NO，如果设置为NO，即服务器使用功能其他可信任机构颁发的证书，也可以建立连接，这个非常危险，所以建议打开，
    // 设置为NO，主要用于这种情况，客户端请求的是子域名，而证书请求的是另外一个域名，因为ssl 证书的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    // 如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:cerData];
    return securityPolicy;
    //    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //    security.allowInvalidCertificates = YES;
    //    security.validatesDomainName = NO;
    //    return security;
}

#pragma mark --- post 方式上传
+ (NSURLSessionDataTask *)post:(NSString *)url host:(NSString *)host param:(id)params progress:(progressResponse)progress success:(successResponse)success failure:(failResponse)failure{
    if (![[LFGloabelConfigTools shareGloabelTools] AppisConnectionAvalible]) {
        NSError *disConnectError;
        if (failure) {
            failure(disConnectError,url);
        }
        return nil;
    }
    @try {
        NSMutableDictionary *finalParams = [[NSMutableDictionary alloc] initWithDictionary:params];
        if ([params isKindOfClass:[NSMutableDictionary class]]) {
            //此处做处理，如加密等操作。转换成Stirng ， 或者增加 token和 userId
        }
        [[self shareAPIManagerTools] POST:url parameters:finalParams progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id resultDic = [self responseConfigration:responseObject];
            CHBaseResponseModel *model = [CHBaseResponseModel mj_objectWithKeyValues:resultDic];
            [self dealResultWithJSONDic:model resultDic:resultDic success:success failure:failure andURLString:url];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error,url);
            }
        }];
    } @catch (NSException *exception) {
    } @finally {
    }
}

#pragma mark --- get 方式上传
+ (void)get:(NSString *)url host:(NSString *)host param:(id)params progress:(progressResponse)progress success:(successResponse)success failure:(failResponse)failure{
    if (![[LFGloabelConfigTools shareGloabelTools] AppisConnectionAvalible]) {
        NSError *disConnectError;
        if (failure) {
            failure(disConnectError,url);
        }
        return;
    }
    NSMutableDictionary *finalParam = [[NSMutableDictionary alloc] initWithDictionary:params];
    [[self shareAPIManagerTools] GET:url parameters:finalParam progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id resultDic = [self responseConfigration:responseObject];
        CHBaseResponseModel *model = [CHBaseResponseModel mj_objectWithKeyValues:resultDic];
        [self dealResultWithJSONDic:model resultDic:resultDic success:success failure:failure andURLString:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,url);
        }
    }];
}

#pragma mark --- 上传文件
+ (void)post:(NSString *)url host:(NSString *)host param:(id)params progress:(progressResponse)progress file:(CHHttpFile *)file success:(successResponse)success failure:(failResponse)failure{
    if (![[LFGloabelConfigTools shareGloabelTools] AppisConnectionAvalible]) {
        NSError *disConnectError;
        if (failure) {
            failure(disConnectError,url);
        }
        return ;
    }
    [[self shareAPIManagerTools] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:file.data name:file.name fileName:file.fileName mimeType:file.mineType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id resultDic = [self responseConfigration:responseObject];
        CHBaseResponseModel *model = [CHBaseResponseModel mj_objectWithKeyValues:resultDic];
       [self dealResultWithJSONDic:model resultDic:resultDic success:success failure:failure andURLString:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,url);
        }
    }];
}

#pragma mark --- 多文件上传
+ (void)post:(NSString *)url params:(id)params filesArray:(NSArray<__kindof CHHttpFile *> *)files progress:(progressResponse)progress success:(successResponse)success failure:(failResponse)failure{
    if (![[LFGloabelConfigTools shareGloabelTools] AppisConnectionAvalible]) {
        NSError *disConnectError;
        if (failure) {
            failure(disConnectError,url);
        }
        return ;
    }
    [[self shareAPIManagerTools] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (CHHttpFile *file in files) {
            [formData appendPartWithFileData:file.data name:file.name fileName:file.fileName mimeType:file.mineType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id resultDic = [self responseConfigration:responseObject];
        CHBaseResponseModel *model = [CHBaseResponseModel mj_objectWithKeyValues:resultDic];
        [self dealResultWithJSONDic:model resultDic:resultDic success:success failure:failure andURLString:url];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error,url);
        }
    }];
}


+ (instancetype) responseConfigration:(id)responseObject{
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id object;
    if (nil == data) {
        object = [[NSDictionary alloc] init];
        return object;
    }
    object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return object;
}


#pragma mark --- 根据后台更改处理返回的code值，进行业务跳转
+ (void)dealResultWithJSONDic:(CHBaseResponseModel *)resultModel
                    resultDic:(id)resultObject
                      success:(successResponse)success
                      failure:(failResponse)failure
                 andURLString:(NSString *)urlString{
    /**
     * 根据不同的code 值来做相应的处理
     * 1. 退出登录
     * 2. 强制更新
     * 3. H5升级等等,根据和后端定义的code 值来处理
     */
    if ([resultModel.s integerValue] == 1) {
        
    }
    if (success) {
        success(resultObject,urlString);
    }
}


@end
