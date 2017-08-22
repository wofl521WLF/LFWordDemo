//
//  LFToolBarView.m
//  LFWordView
//
//  Created by 吴林丰 on 2017/8/9.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import "LFToolBarView.h"

@implementation LFToolBarView

- (instancetype)initWithItems:(NSArray *)items AndSelectItems:(NSArray *)selectItems{
    if (self = [super init]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        _itemViews = [[NSMutableArray alloc] initWithCapacity:1];
        for (int i = 0; i<items.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:items[i] forState:UIControlStateNormal];
            [btn setImage:items[i] forState:UIControlStateHighlighted];
            [btn setImage:selectItems[i] forState:UIControlStateSelected];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [_itemViews addObject:btn];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat itemWidth = CGRectGetWidth(rect) / self.numberOfSegments;
    CGFloat itemHeight = CGRectGetHeight(rect) - 4.f;
    rect.size = CGSizeMake(itemWidth, itemHeight);
    rect.origin.y = 1.f;
    for (UIView *itemView in _itemViews) {
        itemView.frame = CGRectInset(rect, itemWidth / 4, itemHeight / 4);
        rect.origin.x += itemWidth;
    }
//    rect.size.width = itemWidth - 20.f;
//    rect.size.height = 2.f;
//    rect.origin.y = CGRectGetHeight(self.bounds) - 3.f;
//    UIView *selectedItemView = _itemViews[self.selectedSegmentIndex];
//    rect.origin.x = selectedItemView.center.x - CGRectGetWidth(rect) / 2;
//    _slideBlockView.frame = rect;
}

- (void)btnAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(lf_control:didSelectIndex:)]) {
        [self.delegate lf_control:self didSelectIndex:btn.tag];
    }
    if (!self.changeSegmentManually) {
        [self setSelectedSegmentIndex:btn.tag animated:YES];
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    CGFloat itemWidth = CGRectGetWidth(self.bounds) / self.numberOfSegments;
    NSInteger index = point.x / itemWidth;
    
    if ([self.delegate respondsToSelector:@selector(lf_control:didSelectIndex:)]) {
        [self.delegate lf_control:self didSelectIndex:index];
    }
    if (!self.changeSegmentManually) {
        [self setSelectedSegmentIndex:index animated:YES];
    }
}

- (NSInteger)numberOfSegments {
    return _itemViews.count;
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex animated:(BOOL)animated {
    _selectedSegmentIndex = selectedSegmentIndex;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutSubviews];
        }];
    }
    else {
        [self layoutSubviews];
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0.5f)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), 0.5f)];
    [path moveToPoint:CGPointMake(0, CGRectGetMaxY(rect) - 0.5f)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) - 0.5f)];
    path.lineWidth = 1.f;
    [[UIColor colorWithWhite:0.9 alpha:1.f] setStroke];
    [path stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
