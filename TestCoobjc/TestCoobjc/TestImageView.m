//
//  TestImageView.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/27.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "TestImageView.h"

@implementation TestImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 20, 20)];
        [self addSubview:_logoImageView];
        self.backgroundColor = [UIColor redColor];
        _logoImageView.backgroundColor = [UIColor blueColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
