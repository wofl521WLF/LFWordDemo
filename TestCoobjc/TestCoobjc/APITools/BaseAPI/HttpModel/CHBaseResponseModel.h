//
//  CHBaseResponseModel.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHBaseResponseModel : NSObject

/**
 * HTTP接口返回Code
 **/
@property (nonatomic, copy) NSString *s;
/**
 * HTTP接口返回信息
 **/
@property (nonatomic, copy) NSString *c;

@end

NS_ASSUME_NONNULL_END
