//
//  ViewController.m
//  LFWordView
//
//  Created by 吴林丰 on 2017/8/9.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import "ViewController.h"
#import "LFAddWordController.h"
#import "LFEditWordController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark --- 新增
- (IBAction)AddAction:(id)sender {
    
    LFAddWordController *AddVC = [[LFAddWordController alloc] init];
    [self.navigationController pushViewController:AddVC animated:YES];
}


#pragma mark --- 继续编辑
- (IBAction)continueEditAction:(id)sender {
    LFEditWordController *editVC = [[LFEditWordController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
