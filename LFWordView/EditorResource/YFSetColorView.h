//
//  YFSetColorView.h
//  chrenai_iOS
//
//  Created by 吴林丰 on 2017/7/24.
//  Copyright © 2017年 yousails. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LMTextStyle.h"
@interface YFSetColorView : UIView
//@property (nonatomic, strong) LMTextStyle *textStyle;
//@property (nonatomic, strong) void (^styleBlock)(LMTextStyle *style);
+ (id)getColorView;
#pragma mark --- 颜色选择
- (void)updateUIWithHeight:(CGFloat)height;
@end
