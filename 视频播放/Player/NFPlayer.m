//
//  NFPlayer.m
//  视频播放
//
//  Created by apple on 24/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NFPlayer.h"
#import "NFPlayerTabarView.h"
#import <AVKit/AVKit.h>

@interface NFPlayer ()

@property (strong, nonatomic) AVPlayer *player; ///< 播放器

@property (strong, nonatomic) AVPlayerLayer *playerLayer; ///< 播放显示视图

@property (strong, nonatomic) AVPlayerItem *playerItem;


@property (assign, nonatomic) BOOL isPlaying;

@property (strong, nonatomic) NFPlayerTabarView *tabbarView;

@property (assign, nonatomic) CGFloat allTime;


@end

@implementation NFPlayer

- (instancetype)initWithFrame:(CGRect)frame url:(nonnull NSURL *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self assetWithURL:url];
        
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        
        
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        
//        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];
        NSLog(@"%lld",self.playerItem.duration.value);
//        long time = self.playerItem.duration.value / self.playerItem.duration.timescale;
//        CGFloat second = self.playerItem.duration.value / self.playerItem.duration.timescale;

        NSLog(@"%ld",time);
        
        /* AVLayerVideoGravityResizeAspectFill 调整视频显示样式 当前为视图多大显示多大 但有可能显示不全
         AVLayerVideoGravityResizeAspect可以完全显示 (默认模式)
         AVLayerVideoGravityResize 视图多大显示多大完全显示视频，但是视频质量可能会压缩，看着怪异 */
        self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill; // 默认模式
        [self.layer addSublayer:self.playerLayer];
        
        self.tabbarView = [[NFPlayerTabarView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        self.tabbarView.playClickBlock = ^{
            [weakSelf play];
            [weakSelf.tabbarView setBtnImageState:weakSelf.isPlaying];
        };
        
        self.tabbarView.SliderBlock = ^(CGFloat value) {
            
             CMTime startTime = CMTimeMakeWithSeconds(value, self.playerItem.currentTime.timescale);
            
            NSLog(@"%f",startTime.value);
            CMTime pointTime = CMTimeMake(self.allTime * value * weakSelf.playerItem.currentTime.timescale, weakSelf.playerItem.currentTime.timescale);
//            NSLog(@"%f",value);
            [weakSelf.playerItem seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
                
            }];
        };
        
        [self addSubview:self.tabbarView];
        
        [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

-(void)assetWithURL:(NSURL *)url{
    NSDictionary *options = @{ AVURLAssetPreferPreciseDurationAndTimingKey : @YES };
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:url options:options];
    NSArray *keys = @[@"duration"];
    
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSError *error = nil;
        AVKeyValueStatus tracksStatus = [asset statusOfValueForKey:@"duration" error:&error];
        switch (tracksStatus) {
            case AVKeyValueStatusLoaded:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!CMTIME_IS_INDEFINITE(asset.duration)) {
                        CGFloat second = asset.duration.value / asset.duration.timescale;
                        NSLog(@"%f",second);
                        self.allTime = second;
                    }
                });
            }
                break;
            case AVKeyValueStatusFailed:
            {
                //NSLog(@"AVKeyValueStatusFailed失败,请检查网络,或查看plist中是否添加App Transport Security Settings");
            }
                break;
            case AVKeyValueStatusCancelled:
            {
                NSLog(@"AVKeyValueStatusCancelled取消");
            }
                break;
            case AVKeyValueStatusUnknown:
            {
                NSLog(@"AVKeyValueStatusUnknown未知");
            }
                break;
            case AVKeyValueStatusLoading:
            {
                NSLog(@"AVKeyValueStatusLoading正在加载");
            }
                break;
        }
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = self.bounds.size.height;
    self.playerLayer.frame = CGRectMake(0, 0, W, H - 30);
    self.tabbarView.frame = CGRectMake(0, H - 30, W, 30);
    
}

- (void)play {
    
    if (self.isPlaying == NO) {
        [self.player play];
    } else {
        [self.player pause];
    }
    self.isPlaying = !self.isPlaying;
}

//TODO: KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //缓存值
        CGFloat time  = timeInterval / totalDuration;
       NSLog(@"%f",time);
    }
    
}


@end
