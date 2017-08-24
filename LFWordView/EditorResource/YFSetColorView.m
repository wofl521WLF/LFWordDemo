//
//  YFSetColorView.m
//  chrenai_iOS
//
//  Created by 吴林丰 on 2017/7/24.
//  Copyright © 2017年 yousails. All rights reserved.
//

#import "YFSetColorView.h"
#import "Masonry.h"
#import "UIColor+YYAdd.h"
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define SystemFont(s)   ([UIFont systemFontOfSize:s])
#define YFColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define YFColorRGB(r, g, b) YFColorRGBA((r), (g), (b), 255)

@interface YFSetColorView ()<UICollectionViewDataSource,
UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UICollectionView *phonecollectionView;
    CGFloat ItemLength;
    CGFloat Itemwidth;
    CGFloat lineSpace;
    CGFloat interSpace;
    CGFloat topSpace;
}
@property (strong, nonatomic)  NSMutableArray *arr;
@property (strong, nonatomic)  UIButton *finishBtn;
@property (strong,nonatomic)   UIView *headView;
@property (assign,nonatomic)   BOOL isFlag;
@property (assign,nonatomic)   CGFloat newHeight;
@end
@implementation YFSetColorView

- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        UILabel *ll = [UILabel new];
        ll.font = SystemFont(15);
        ll.text = @"文字颜色";
        ll.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:ll];
        [ll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headView.mas_centerX);
            make.top.equalTo(_headView.mas_top).with.offset(11);
            make.size.mas_equalTo(CGSizeMake(80, 21));
        }];
        
        self.finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_headView addSubview:self.finishBtn];
        self.finishBtn.titleLabel.font = SystemFont(13);
        [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headView.mas_right).with.offset(-14);
            make.centerY.equalTo(_headView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(40, 18));
        }];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, ScreenWidth, 0.5)];
        lineView.backgroundColor =YFColorRGB(234, 234,234);
        lineView2.backgroundColor =YFColorRGB(234, 234,234);
        [_headView addSubview:lineView];
        [_headView addSubview:lineView2];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

- (NSMutableArray *)arr{
    if (_arr == nil) {
        _arr = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _arr;
}

+ (id)getColorView{
    return [[YFSetColorView alloc] init];
}

- (void)initWithUI{
    CGFloat width = ScreenWidth;
    Itemwidth = 47.3*(width/375.0);
    ItemLength = 34*(width/375.0);
    interSpace = width*(20.0/375.0);
    lineSpace = width*(15.0/375.0);
    topSpace = width*(15.0/375.0);
    [self addSubview:self.headView];
    [self.finishBtn setTitleColor: YFColorRGB(38, 159, 243) forState:UIControlStateNormal];
    [self.finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initData{
    NSArray *aa = @[@"#AE40C5",@"#E9112B ",@"#4A90E2",@"#50E3C2",@"#9AD221",@"#F5A623",@"#8B572A",@"#417505",@"#0B67C3",@"#0ABA3F",@"#F98B8B",@"#10BAE0",@"#4A4A4A",@"#000000",@"#9B9B9B",@"#EE4075",@"#00FFFF",@"#36648B",@"#0000FF",@"#00FF00",@"#FF00FF",@"#FFFF00",@"#FF83FA",@"#C0FF3E",@"#87CEFF"];
    [self.arr addObjectsFromArray:aa];
}

#pragma mark ----- 初始化CollectionView  并注册CollectView的Header 和 Footer----
- (void)initCollectionView{
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing  = interSpace;
    layout.minimumLineSpacing  = lineSpace;
    layout.sectionInset        = UIEdgeInsetsMake(topSpace,lineSpace,lineSpace,topSpace);
    layout.itemSize = CGSizeMake(Itemwidth,ItemLength);
    layout.scrollDirection     = UICollectionViewScrollDirectionVertical;
    phonecollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0,45,ScreenWidth,self.newHeight) collectionViewLayout:layout];
    phonecollectionView.collectionViewLayout = layout;
    phonecollectionView.backgroundColor = [UIColor whiteColor];
    phonecollectionView.alwaysBounceVertical = YES;
    [phonecollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colorCell"];
    phonecollectionView.dataSource = self;
    phonecollectionView.delegate = self;
    phonecollectionView.scrollEnabled = NO;
    [self addSubview:phonecollectionView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}
#pragma mark ---- 自定义Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:self.arr[indexPath.row]];
    cell.layer.cornerRadius = 5;
    cell.clipsToBounds = YES;
    return cell;
}
#pragma mark ---- 设置Item  大小
- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Itemwidth,ItemLength);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.styleBlock) {
        self.styleBlock(self.arr[indexPath.row]);
    }
}

- (void)finishAction:(id)sender {
    if (self.styleBlock) {
        self.styleBlock(nil);
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self initData];
    [self initWithUI];
    [self initCollectionView];
}


- (void)updateUIWithHeight:(CGFloat)height{
    CGRect frame = CGRectMake(0,0, ScreenWidth, height);
    self.frame = frame;
    if (height>225) {
        self.isFlag = YES;
         phonecollectionView.frame = CGRectMake(0, 45, ScreenWidth, height - 45);
        self.newHeight = height - 45;
    }else{
        self.isFlag = NO;
        self.newHeight = 180;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
