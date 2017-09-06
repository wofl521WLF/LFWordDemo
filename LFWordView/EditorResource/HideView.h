//
//  HideView.h
//  CloudsOutpatient
//
//  Created by 吴林丰 on 16/3/24.
//  Copyright © 2016年 HC. All rights reserved.
//
//
//  所有需要加上黑色蒙版的View 可以加载在此View上用于公用
//
#import <UIKit/UIKit.h>


@interface HideView : UIView
/**
 *  创建公共使用的黑色弹框
 *
 *
 *  @return  返回
 */
@property (assign,nonatomic) BOOL isHide;//是否隐藏

#pragma mark --- 类获取当前view上的蒙版
+ (id) getHideViewFromWindow:(UIWindow *)window;
#pragma mark --- init获取当前view上的蒙版
- (id) initHideViewFromWindow:(UIWindow *)window;

@end
