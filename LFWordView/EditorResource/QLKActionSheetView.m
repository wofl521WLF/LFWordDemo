//
//  QLKActionSheetView.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 16/8/16.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "QLKActionSheetView.h"
#import "UIColor+YYAdd.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface QLKActionSheetView ()

@property (weak, nonatomic) IBOutlet UIButton *takeBtn;//拍照按钮

@property (weak, nonatomic) IBOutlet UIButton *libraryBtn;//相册按钮


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;//取消按钮

@property (weak, nonatomic) IBOutlet UIView *mainView;//上部View


@property (weak, nonatomic) IBOutlet UIView *cancelView;//取消view


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeightConstaint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *line2HeightConstaint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainWidthConstaint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *canCelWIthConstaint;


@property (weak, nonatomic) IBOutlet UIView *line2View;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation QLKActionSheetView


+ (id)getQlkActionSheetView{
    NSArray *array = [[UINib nibWithNibName:@"QLKActionSheetView" bundle:nil] instantiateWithOwner:self options:nil];
    
    QLKActionSheetView *view;
    
    view = [array objectAtIndex:0];
    
    view.frame = CGRectMake(0, ScreenHeight - 178,ScreenWidth, 178);
    
    return view;
}


- (void)awakeFromNib{
       [super awakeFromNib];
     [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.mainView.backgroundColor = [UIColor clearColor];
    self.cancelView.backgroundColor = [UIColor clearColor];

   
    self.mainWidthConstaint.constant = ScreenWidth;
    self.canCelWIthConstaint.constant = ScreenWidth;
    
    
    NSString *title = @"手机";
    [self.libraryBtn setTitle:[NSString stringWithFormat:@"从%@相册选择",title] forState:UIControlStateNormal];
    self.lineHeightConstaint.constant = 0.5;
    self.line2HeightConstaint.constant = 0.5;
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    self.line2View.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [self.cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

#pragma mark ---- 拍照
- (IBAction)takePhotoAction:(id)sender {
    if (self.actionSheetViewBlock) {
        self.actionSheetViewBlock(self.takeBtn.tag-999);
    }
}

#pragma mark ---- 相册
- (IBAction)libraryAction:(id)sender {
    if (self.actionSheetViewBlock) {
        self.actionSheetViewBlock(self.libraryBtn.tag-999);
    }
}

#pragma mark ---- 取消
- (IBAction)cancleAction:(id)sender {
    if (self.actionSheetViewBlock) {
        self.actionSheetViewBlock(self.cancelBtn.tag-999);
    }
}

- (void)updateUIWithHeight:(CGFloat)height{
    CGRect frame = CGRectMake(0,0, ScreenWidth, height);
    self.frame = frame;
}
@end
