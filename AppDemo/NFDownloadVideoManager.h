//
//  NFDownloadVideoManager.h
//  MicroStopForOrganization
//
//  Created by apple on 22/08/18.
//  Copyright © 2018年 Charse. All rights reserved.
//

#define NFDownloadVideoManagerInstance [NFDownloadVideoManager shareInstance]
#import <Foundation/Foundation.h>

typedef void(^ProgressBlock)(float progress);
typedef void(^FinishBlock)(NSString *locationURL);

/**
 	下载工具
 */
@interface NFDownloadVideoManager : NSObject
+ (NFDownloadVideoManager *)shareInstance;
- (void)startDownLoadVedio:(NSString *)url progress:(ProgressBlock)progress finish:(FinishBlock)finish;

@end
