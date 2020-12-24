//
//  ViewController.m
//  HTML交互
//
//  Created by apple on 29/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

// 拦截js点击事件

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *string = request.URL.absoluteString;
    
    // 每次点击html事件，获取点击内容 处理事件
    NSRange range = [string rangeOfString:@"hhh://"];
    if (range.location != NSNotFound) {
        NSString *method = [string substringFromIndex:range.location + range.length ];
        SEL sel = NSSelectorFromString(method);
        
        [self performSelector:sel withObject:nil];
    }
    return YES;
    
}

- (void)getImage {
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pick animated:YES completion:nil];
}

@end
