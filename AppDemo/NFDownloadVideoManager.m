//
//  NFDownloadVideoManager.m
//  MicroStopForOrganization
//
//  Created by apple on 22/08/18.
//  Copyright © 2018年 Charse. All rights reserved.
//

#import "NFDownloadVideoManager.h"

@interface NFDownloadVideoManager ()<NSURLSessionDelegate>

@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;

@property (copy, nonatomic) ProgressBlock progressBlock;

@property (copy, nonatomic) FinishBlock finishBlock;

@end

@implementation NFDownloadVideoManager

+ (NFDownloadVideoManager *)shareInstance {
    return [[NFDownloadVideoManager alloc] init];
}

/** 下载视频 */
- (void)startDownLoadVedio:(NSString *)url progress:(ProgressBlock)progress finish:(FinishBlock)finish{
    self.progressBlock = progress;
    self.finishBlock = finish;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    if (url) {
        self.downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:url]];
        [self.downloadTask resume];
    } else {
        
    }
}

#pragma mark NSSessionUrlDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //下载进度
    float progress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    self.progressBlock(progress);
    NSLog(@"%f",progress);
    dispatch_async(dispatch_get_main_queue(), ^{
        //进行UI操作  设置进度条
        
    });
}
//下载完成 保存到本地相册
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //1.拿到cache文件夹的路径
    NSString *cache=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //2,拿到cache文件夹和文件名
    NSString *file=[cache stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)[0];
    path = [path stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    NSLog(@"%@",path);
    self.finishBlock(path);
}

@end
