//
//  CHTextResponseSerializer.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/8.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHTextResponseSerializer : AFHTTPResponseSerializer

+ (instancetype) chResponseSerializer;

@end

NS_ASSUME_NONNULL_END
