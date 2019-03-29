//
//  CHBaseRequestModel.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "CHBaseRequestModel.h"
#import "LFGloabelConfigTools.h"
@implementation CHBaseRequestModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.u = @"";// 用户登录成功后的信息,具体看个别应用和后台的交互
        self.deviceInfo = [[LFGloabelConfigTools shareGloabelTools] getDeviceInfo];
    }
    return self;
}
@end
