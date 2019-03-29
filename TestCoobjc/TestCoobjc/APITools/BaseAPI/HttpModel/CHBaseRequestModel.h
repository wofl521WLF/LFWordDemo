//
//  CHBaseRequestModel.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHBaseRequestModel : NSObject

@property (nonatomic,copy) NSString *c;//Http 接口公用参数
@property (nonatomic,copy) NSString *m;//HTTP 接口公用参数
@property (nonatomic,copy) NSString *u;//HTTP接口公用参数
@property (nonatomic,strong) NSDictionary *deviceInfo;//HTTP接口公用参数

@end

NS_ASSUME_NONNULL_END
