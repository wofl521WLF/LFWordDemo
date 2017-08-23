//
//  LFAddWordController.m
//  LFWordView
//
//  Created by 吴林丰 on 2017/8/9.
//  Copyright © 2017年 吴林丰. All rights reserved.
//

#import "LFAddWordController.h"

@interface LFAddWordController ()

@end

@implementation LFAddWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增";
    NSString *customCSS = @"";
    [self setCSS:customCSS];
    self.alwaysShowToolbar = YES;
    self.receiveEditorDidChangeEvents = NO;
    [self setPlaceholder:@"请输入内容"];
    // Do any additional setup after loading the view.
}

- (void)editorDidChangeWithText:(NSString *)text andHTML:(NSString *)html {
    
    NSLog(@"Text Has Changed: %@", text);
    
    NSLog(@"HTML Has Changed: %@", html);
    
}

- (void)hashtagRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Hashtag has been recognized: %@", word);
    
}

- (void)mentionRecognizedWithWord:(NSString *)word {
    
    NSLog(@"Mention has been recognized: %@", word);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
