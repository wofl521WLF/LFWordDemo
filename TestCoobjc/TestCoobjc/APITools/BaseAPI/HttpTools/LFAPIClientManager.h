//
//  LFAPIClientManager.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "CHBaseAPIManagerTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFAPIClientManager : CHBaseAPIManagerTools

/**
 *
 * 刷新的refreshBlock
 */
typedef void (^refreshBlock)(void);

/**
 *
 * alert的alertBlock
 */
typedef void (^alertBlock)(void);

/**
 *  base请求
 *
 *  @param params  请求参数
 *  @param show  是否显示系统加载loading
 *  @param text  加载文案
 *  @param success 请求成功后的回调
 *  @param failuer 请求失败后的回调
 *  @param refresh 刷新回调
 *  @param alert alert回调
 */
+ (void)basePostRequestWithParam:(id)params showSystemLoading:(BOOL)show
                 loadingText:(NSString *)text
                     success:(successResponse)success
                    failure:(failResponse)failuer
                     refresh:(refreshBlock)refresh
                       alert:(alertBlock)alert;

/**
 *  base请求
 *
 *  @param params  请求参数
 *  @param show  是否显示系统加载loading
 *  @param text  加载文案
 *  @param success 请求成功后的回调
 *  @param failuer 请求失败后的回调
 *  @param refresh 刷新回调
 *  @param alert alert回调
 */
+ (void)baseGetRequestWithParam:(id)params showSystemLoading:(BOOL)show
                     loadingText:(NSString *)text
                         success:(successResponse)success
                         failure:(failResponse)failuer
                         refresh:(refreshBlock)refresh
                           alert:(alertBlock)alert;

@end

NS_ASSUME_NONNULL_END
