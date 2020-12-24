//
//  ViewController.m
//  AppDemo
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"
#import "NFDownloadVideoManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [NFDownloadVideoManagerInstance startDownLoadVedio:@"https://media.w3.org/2010/05/sintel/trailer.mp4" progress:^(float progress) {
//        
//    } finish:^(NSString *locationURL) {
//        
//    }];
//    [[NFDownloadVideoManager shareInstance] startDownLoadVedio:@"https://www.bilibili.com/video/av14410295" progress:^(float progress) {
//        
//    } finish:^(NSString *locationURL) {
//        
//    }];
    
    [self postRequest];
}

// post请求
- (void)postRequest {
    
    NSURL *url = [NSURL URLWithString:@"http://beike.api.kocla.com/kocla-api/user/v1/wduseraccount/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 1 请求头
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    // 2 请求类型
    [request setHTTPMethod:@"POST"];
  
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"zyc123456" forKey:@"pwd"];
    [dict setValue:@"5" forKey:@"from"];
    [dict setValue:@"15013680855" forKey:@"phone"];
    [dict setValue:@"bbYuanDing" forKey:@"product"];
    [dict setValue:@"ios" forKey:@"terminus"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    // 3 请求体
    [request setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]);
        
    }];
    [dataTask resume];
}

@end
