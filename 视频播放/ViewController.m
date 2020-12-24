//
//  ViewController.m
//  视频播放
//
//  Created by apple on 24/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

#define UrlStr @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import "NFPlayer.h"
@interface ViewController ()

@property (strong, nonatomic) NFPlayer *player;

@property (weak, nonatomic) IBOutlet UIView *playerBackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[NFPlayer alloc] initWithFrame:CGRectZero url:[NSURL URLWithString:UrlStr]];
    [self.playerBackView addSubview:_player];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.player.frame = self.playerBackView.bounds;
}


@end
