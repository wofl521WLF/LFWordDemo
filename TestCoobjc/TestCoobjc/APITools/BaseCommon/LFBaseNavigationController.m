//
//  LFBaseNavigationController.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/29.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "LFBaseNavigationController.h"

@interface LFBaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation LFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;//半透明
    self.interactivePopGestureRecognizer.delegate = self;//左滑手势
    self.delegate = self;
    self.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationBar.shadowImage = [UIImage imageNamed:@"底部阴影"];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:54 green:110 blue:255 alpha:1],NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if (@available(iOS 11.0,*)) {
        self.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
        [self.navigationBar setLargeTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:54 green:110 blue:255 alpha:1],NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:30], NSFontAttributeName, nil]];
    }else{
//        UIImage *image = [UIImage imageNamed:@"nav_bar_white"];// 设置图片
//        [self.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
    // Do any additional setup after loading the view.
}

#pragma mark --- pop & push  侧滑代理

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    NSArray *array = self.viewControllers;
    if (array.count == 1) {
        return NO;
    }else if([array.lastObject isKindOfClass:NSClassFromString(@"PubBuySucceed")]){
        return NO;
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
         // push 时候隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //侧滑
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    
    self.navigationBar.hidden = !self.navigationBar.hidden;//防止Navi Bar 出现重叠
    if (viewControllers.count > 1) {
        [[viewControllers firstObject] setHidesBottomBarWhenPushed:YES];
    }else{
        [[viewControllers firstObject] setHidesBottomBarWhenPushed:NO];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    };
    
    [super setViewControllers:viewControllers animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count <= 2) {
        [[self.viewControllers firstObject] setHidesBottomBarWhenPushed:NO];
    }
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count <= 2) {
        [[self.viewControllers firstObject] setHidesBottomBarWhenPushed:NO];
    }
    
    return [super popToViewController:viewController animated:animated];
}


- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    [[self.viewControllers firstObject] setHidesBottomBarWhenPushed:NO];
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark ---- UINavigationControllerDelegate ----

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    [self navigationLargeTitlesShow:viewController];
    BOOL isShowHomePage = [self barHiddenBoolWithVC:viewController];
    BOOL animateBool = YES;
    if ([viewController isKindOfClass:NSClassFromString(@"V3_indexinfo")]) {
        animateBool = YES;
    }
    [self setNavigationBarHidden:isShowHomePage animated:animateBool];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    return nil;
}

-(void)navigationLargeTitlesShow:(UIViewController*)viewController{
    
    if (@available(iOS 11.0, *)){
        if ([viewController isKindOfClass:NSClassFromString(@"V4_InfoIndex")] ||
            [viewController isKindOfClass:NSClassFromString(@"V4_BuyIndex")]) {
            
            viewController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
        }else{
            
            viewController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
        }
    }
}

- (BOOL)barHiddenBoolWithVC:(UIViewController*)viewController
{
//    NSString *vcName = NSStringFromClass([viewController class]);
//    if([NoneNavViewControllers containsObject:vcName]){
//        return YES;
//    }
//    if ([viewController isKindOfClass:NSClassFromString(@"SCCWebViewController")] && CH168_APPDELEGATE.isHideNav) {
//        return YES;
//    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)dealloc
{
    self.delegate = nil;
    self.interactivePopGestureRecognizer.delegate = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
