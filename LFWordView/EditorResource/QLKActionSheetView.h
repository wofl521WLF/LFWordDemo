//
//  QLKActionSheetView.h
//  CloudsOutpatient
//
//  Created by 吴林丰 on 16/8/16.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLKActionSheetView : UIView

#pragma mark ---- 拍照 相册选择UI处理
@property (nonatomic,copy)  void (^actionSheetViewBlock)(NSInteger buttonIndex);

+ (id)getQlkActionSheetView;
- (void)updateUIWithHeight:(CGFloat)height;
@end
