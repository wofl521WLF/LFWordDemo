//
//  ViewController.m
//  TestCoobjc
//
//  Created by 吴林丰 on 2019/3/7.
//  Copyright © 2019 吴林丰. All rights reserved.
//

#import "ViewController.h"
#import <coobjc/coobjc.h>
#import <cokit/cokit.h>
#import <coobjc/coroutine_context.h>
#import "TestImageView.h"

@interface ViewController ()

@property (nonatomic,strong) TestImageView *imageView;
@property (nonatomic,strong) UIView *naviView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView = [[TestImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
////    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
////    self.imageView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.imageView];
    
    NSDictionary *dd = @{@"dd":@"33"};
    NSLog(@"%@",dd);
    NSMutableDictionary *mu = [NSMutableDictionary dictionaryWithDictionary:dd];
    [mu setValue:@"333333" forKey:@"dd"];
    NSLog(@"%@",dd);
    NSLog(@"%@",mu);
    dd = mu;
    NSLog(@"%@",dd);
    NSLog(@"%@",mu);
//    [self testCoobjcOne];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)testCoobjcOne{
    
    NSURL *url = [NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/2089290-a0158e970e203015.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/630/format/webp"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }else{
            //Parsing data in child threads and generating images
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                UIImage *image = [[UIImage alloc] initWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //Dispatch to the main thread to display the image
                    weakSelf.imageView.image = image;
                });
            });
        }
    }];
    [task resume];
}


- (void)testCoobjcTwo{
    co_launch(^{
        
    });
}




- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}















/**
 * 首先我们看第一种，coobjc介绍文章中提到ucontext在iOS中被废弃了，那如果不废弃，
 * 我们如何去使用ucontext呢？如下的一个Demo可以解释一下ucontext的用法：
 */
- (void)testDemo1{
    
    coroutine_ucontext_t context;
    coroutine_getcontext(&context);
    puts("Hello world");
    
    sleep(1);
    
    coroutine_setcontext(&context);
    
}




@end
