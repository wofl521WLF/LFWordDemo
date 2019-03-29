//
//  CHHttpFile.h
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHHttpFile : NSObject

@property (nonatomic,copy) NSString *name;//文件名 例 headImage
@property (nonatomic,strong) NSData *data;//文件数据
@property (nonatomic,copy) NSString *mineType;// 文件类型
@property (nonatomic,copy) NSString *fileName;// 带后缀的文件名 例 headImage.jpg

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data
                    mineType:(NSString *)mineType
                    fileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
