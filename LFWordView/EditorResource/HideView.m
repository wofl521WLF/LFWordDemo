//
//  HideView.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 16/3/24.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "HideView.h"

@implementation HideView
/**
 *  创建一个公用的黑色蒙版
 *
 *  @param window 需要显示的Window
 *
 *  @return 返回Window
 */
+ (id) getHideViewFromWindow:(UIWindow *)window{
    
    return  [[self alloc] initHideViewFromWindow:window];
}

- (id) initHideViewFromWindow:(UIWindow *)window{
    self = [super init];
    if (self) {
        self = [[HideView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
        [window addSubview:self];
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    /**
     给自身添加手势
     
     - parameter hideAction: 隐藏自身
     
     - returns: nil
     */
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction:)];
//    tap.cancelsTouchesInView = NO;
//    [self addGestureRecognizer:tap];
//    self.hidden = YES;
}

/**
 *  点击HideView隐藏
 */

-(void)hideAction:(UITapGestureRecognizer *)tap{
    if (self.isHide) {
        self.hidden = NO;
    }else{
         self.hidden = YES;
    }
}

@end
