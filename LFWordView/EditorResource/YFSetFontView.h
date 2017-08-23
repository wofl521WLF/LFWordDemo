//
//  YFSetFontView.h
//  chrenai_iOS
//
//  Created by 吴林丰 on 2017/7/23.
//  Copyright © 2017年 yousails. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LMTextStyle.h"
@interface YFSetFontView : UIView
//@property (nonatomic, strong) LMTextStyle *textStyle;
//@property (nonatomic, strong) void (^styleBlock)(LMTextStyle *style);
+ (id)getYSFontView;
//字体处理
- (void)updateUIWithHeight:(CGFloat)height;
@end
