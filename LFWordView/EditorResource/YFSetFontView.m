//
//  YFSetFontView.m
//  chrenai_iOS
//
//  Created by 吴林丰 on 2017/7/23.
//  Copyright © 2017年 yousails. All rights reserved.
//

#import "YFSetFontView.h"
#import "Masonry.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define SystemFont(s)   ([UIFont systemFontOfSize:s])
#define YFColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define YFColorRGB(r, g, b) YFColorRGBA((r), (g), (b), 255)

@interface YFSetFontView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UIButton *finishBtn;
@property (strong,nonatomic)   UIView *headView;
@property (strong, nonatomic)  UITableView *tableView;
@property (assign,nonatomic)   BOOL isFlag;
@property (assign,nonatomic)   CGFloat newHeight;
@end

@implementation YFSetFontView

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 45)];
        UILabel *ll = [UILabel new];
        ll.font = [UIFont systemFontOfSize:15];
        ll.text = @"字号大小";
        ll.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:ll];
        [ll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headView.mas_centerX);
            make.top.equalTo(_headView.mas_top).with.offset(11);
            make.size.mas_equalTo(CGSizeMake(80, 21));
        }];
        _headView.backgroundColor = [UIColor whiteColor];
        self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_headView addSubview:self.finishBtn];
        self.finishBtn.titleLabel.font = [UIFont systemFontOfSize:13];;
        [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headView.mas_right).with.offset(-14);
            make.centerY.equalTo(_headView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(40, 18));
        }];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.5)];
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, [[UIScreen mainScreen] bounds].size.width, 0.5)];
        lineView.backgroundColor =YFColorRGB(234, 234,234);
        lineView2.backgroundColor =YFColorRGB(234, 234,234);
        [_headView addSubview:lineView2];
        [_headView addSubview:lineView];

    }
    return _headView;
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 180) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setSeparatorColor: YFColorRGB(234, 234,234)];
    }
    return _tableView;
}



+ (id)getYSFontView{
    return [[YFSetFontView alloc] init];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"TableViewCell4";
    UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell4 == nil) {
        cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    switch (indexPath.row) {
        case 0:
            cell4.textLabel.text = @"超大号";
            cell4.textLabel.font = SystemFont(18);
            break;
        case 1:
            cell4.textLabel.text = @"大号";
            cell4.textLabel.font = SystemFont(16);
            break;
        case 2:
            cell4.textLabel.text = @"默认";
            cell4.textLabel.font = SystemFont(15);
            break;
        case 3:
            cell4.textLabel.text = @"小号";
            cell4.textLabel.font = SystemFont(13);
            break;
            
        default:
            break;
    }
    cell4.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell4;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fontSize = @"12px";
    switch (indexPath.row) {
        case 0:
            fontSize = @"36px";
            break;
        case 1:
            fontSize = @"24px";
            break;
        case 2:
            fontSize = @"16px";
            break;
        case 3:
            fontSize = @"12px";
            break;
        default:
            break;
    }
    if (self.styleBlock) {
        self.styleBlock(fontSize);
    }
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isFlag == YES) {
        return self.newHeight/4.0;
    }else{
        return 45.0;
    }
}


- (void)finishAction:(id)sender {
    if (self.styleBlock) {
        self.styleBlock(nil);
    }
}

-(void)viewDidLayoutSubviews

{
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)initWithUI{
    [self addSubview:self.headView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.finishBtn setTitleColor: YFColorRGB(38, 159, 243) forState:UIControlStateNormal];
    [self.finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView reloadData];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self initWithUI];
}

- (void)updateUIWithHeight:(CGFloat)height{
    CGRect frame = CGRectMake(0,0, ScreenWidth, height);
    self.frame = frame;
    if (height>225) {
        self.isFlag = YES;
        self.tableView.frame = CGRectMake(0, 45, ScreenWidth, height - 45);
        self.newHeight = height - 45;
    }else{
        self.isFlag = NO;
    }
    [self addSubview:self.tableView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
