//
//  LFGloabelConfigTools.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "LFGloabelConfigTools.h"
#import <Reachability/Reachability.h>
#import <sys/utsname.h>
#import "QLKDeviceIdentifier.h"
#import <UIKit/UIDevice.h>
#import <UIKit/UIUserNotificationSettings.h>
#import <UIKit/UIApplication.h>
static LFGloabelConfigTools *model;

@implementation LFGloabelConfigTools

+ (LFGloabelConfigTools *)shareGloabelTools{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[LFGloabelConfigTools alloc] init];
    });
    return model;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [super allocWithZone:zone];
    });
    return model;
}

- (id)copyWithZone:(NSZone *)zone{
    return [LFGloabelConfigTools shareGloabelTools];
}

#pragma mark ----- 单例方法 -----
#pragma mark -- 网络检测
- (BOOL)AppisConnectionAvalible{
    @try {
        BOOL isExistenceNetWork = YES;
        //此处公司域名HostName
        Reachability *reachability = [Reachability reachabilityWithHostname:@"api.chehang168.com"];
        switch ([reachability currentReachabilityStatus]) {
                case NotReachable:
                isExistenceNetWork = NO;
                break;
                case ReachableViaWiFi:
                isExistenceNetWork = YES;
                break;
                case ReachableViaWWAN:
                isExistenceNetWork = YES;
                break;
        }
        return isExistenceNetWork;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark --- 获取当前时间的时间戳字符串
- (NSString *)getTimestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f",interval];
}

#pragma mark --- 获取设备信息
- (NSDictionary *)getDeviceInfo{
    
    return nil;
}

#pragma mark --- 获取App 版本号
- (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark --- 获取设备名称
- (NSString *)getDeviceName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceModel;
}

#pragma mark --- 获取设备系统版本
- (NSString *)getDeviceVersion{
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - 获取设备唯一性的标识，为一串字符串
- (NSString *)getDeviceUUID{
    NSString *uuidStr = [QLKDeviceIdentifier deviceIdentifier];
    if (nil == uuidStr) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        uuidStr = (__bridge NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidRef);
        [QLKDeviceIdentifier writeToSSHKeyChain:uuidStr];
    }
    return uuidStr;
}

#pragma mark -- 检测用户是否关闭了通知
- (BOOL)isUserNotificationEnable{
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    }
    return isEnable;
}

#pragma mark --- 应用打开设置页
- (void)goToAppSystemNotificationSetting{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url options:@{} completionHandler:nil];
            } else {
                [application openURL:url];
            }
        }else{
            [application openURL:url];
        }
    }
}

@end
