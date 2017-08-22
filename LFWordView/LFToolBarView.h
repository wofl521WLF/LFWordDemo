//
//  LFToolBarView.h
//  LFWordView
//
//  Created by 吴林丰 on 2017/8/9.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFToolBarView;
//代理协议
@protocol LFToolBarViewDelegate <NSObject>
//点击按钮，告诉用户点击的区域位置
- (void)lf_control:(LFToolBarView *)view didSelectIndex:(NSInteger)index;

@end

@interface LFToolBarView : UIControl

@property (strong,nonatomic) NSMutableArray *itemViews;
@property (weak,nonatomic) id<LFToolBarViewDelegate> delegate;
@property (nonatomic, assign) BOOL changeSegmentManually;

@property (nonatomic, readonly) NSInteger numberOfSegments;
@property (nonatomic, readonly) NSInteger selectedSegmentIndex;

- (instancetype)initWithItems:(NSArray *)items AndSelectItems:(NSArray *)selectItems;
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex animated:(BOOL)animated;


@end
