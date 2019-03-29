//
//  CHBaseAPIManagerTools.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/8.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "CHHttpFile.h"
NS_ASSUME_NONNULL_BEGIN

@interface CHBaseAPIManagerTools : NSObject

/**
 *
 *  宏定义网络请求成功的block
 *
 *  @param responseObject 请求成功返回的数据
 *  @param path 请求地址
 */
typedef void (^successResponse)(id responseObject,NSString *path);
/**
 *
 * 宏定义请求失败的block
 *
 * @param error 报错信息
 * @param path 请求地址
 */
typedef void (^failResponse)(NSError *error, NSString *path);

/**
 *
 * 宏定义请求进度的block
 *
 * @param progress 进度
 */
typedef void (^progressResponse)(NSProgress *progress);


+ (AFHTTPSessionManager *)shareAPIManagerTools;

/**
 * post url 请求
 * @param params  普通的请求参数
 * @param success 请求成功后的回调
 * @param failure 请求失败后的回调
 */

+ (NSURLSessionDataTask *)post:(NSString *)url host:(NSString *)host param:(id)params
                      progress:(progressResponse) progress
                       success:(successResponse)success
                       failure:(failResponse)failure;



/**
 * get url 请求
 * @param params  普通的请求参数
 * @param success 请求成功后的回调
 * @param failure 请求失败后的回调
 */
+ (void)get:(NSString *)url host:(NSString *)host param:(id)params
                      progress:(progressResponse) progress
                       success:(successResponse)success
                       failure:(failResponse)failure;


/**
 * 文件上传
 * url 请求
 * @param params  普通的请求参数
 * @param progress 进度
 * @param file   文件file
 * @param success 请求成功后的回调
 * @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url host:(NSString *)host param:(id)params
                        progress:(progressResponse) progress
                           file:(CHHttpFile *)file
                        success:(successResponse)success
                        failure:(failResponse)failure;

/**
 * 多文件上传
 * url 请求
 * @param progress 进度
 * @param files   文件data
 * @param params  普通的请求参数
 * @param success 请求成功后的回调
 * @param failure 请求失败后的回调
 */
+ (void)post:(NSString *)url
      params:(id)params
  filesArray:(NSArray <__kindof CHHttpFile *> *)files
    progress:(progressResponse)progress
     success:(successResponse)success
     failure:(failResponse)failure;

@end

NS_ASSUME_NONNULL_END
