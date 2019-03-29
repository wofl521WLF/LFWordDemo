//
//  CHTextResponseSerializer.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/8.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "CHTextResponseSerializer.h"

@implementation CHTextResponseSerializer

+ (instancetype)serializer{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

#pragma mark --- 重写 AFURLResponse 方法
- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        return  nil;
    }
    id responseObject = nil;
    NSError *serializationError = nil;
    if (!responseObject) {
        responseObject = [[NSString alloc] initWithBytes:[data bytes] length:data.length encoding:NSUTF8StringEncoding];
    }
    
    if (error) {
        *error = serializationError;
    }
    
    return responseObject;
    
}



@end
