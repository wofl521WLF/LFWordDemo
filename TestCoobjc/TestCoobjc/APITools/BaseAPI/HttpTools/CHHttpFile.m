//
//  CHHttpFile.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/11.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "CHHttpFile.h"

@implementation CHHttpFile

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data
                    mineType:(NSString *)mineType
                    fileName:(NSString *)fileName{
    
    CHHttpFile *newFile = [[self alloc] init];
    newFile.name = name;
    newFile.data = data;
    newFile.mineType = mineType;
    newFile.fileName = fileName;
    return newFile;
    
}

@end
