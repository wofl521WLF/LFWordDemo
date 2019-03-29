//
//  LFGloabelConfigTools.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFGloabelConfigTools : NSObject<NSCopying>

+ (LFGloabelConfigTools *)shareGloabelTools;

/**
 * 网络检测
 */
- (BOOL)AppisConnectionAvalible;

/**
 * 时间获取
 */
- (NSString *)getTimestamp;

/**
 * 设备信息获取
 */
- (NSDictionary *)getDeviceInfo;

/*
 * 判断是否允许接收通知
 */
- (BOOL)isUserNotificationEnable;

/**
 * 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
 */
- (void)goToAppSystemNotificationSetting;

@end

NS_ASSUME_NONNULL_END
