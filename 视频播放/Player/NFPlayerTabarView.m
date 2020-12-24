//
//  NFPlayerTabarView.m
//  视频播放
//
//  Created by apple on 24/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NFPlayerTabarView.h"

@interface NFPlayerTabarView ()

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UILabel *totalTimeLabel; ///

@property (strong, nonatomic) UISlider *slider;

@property (strong, nonatomic) UIButton *playBtn;


@end

@implementation NFPlayerTabarView

- (instancetype)init
{
  return  [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor blackColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.text = @"00:00";
        [self addSubview:self.timeLabel];
        // 2
        self.totalTimeLabel = [[UILabel alloc] init];
        self.totalTimeLabel.font = [UIFont systemFontOfSize:12];
        self.totalTimeLabel.textColor = [UIColor blackColor];
        self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        self.totalTimeLabel.text = @"05:33";
        [self addSubview:self.totalTimeLabel];
        
        // 3
        self.slider = [[UISlider alloc] init];
        [self addSubview:self.slider];
        
        [self.slider setThumbImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        
        [self.slider addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];

		// 4
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.playBtn];
        [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
//    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    // 4
    self.playBtn.frame = CGRectMake(0, 0, 44, 30);
    
    CGFloat timeW = 60;
    CGFloat timeH = 20;
    CGFloat timeX = CGRectGetMaxX(self.playBtn.frame);
    // 1
    self.timeLabel.frame = CGRectMake(timeX, 5, timeW, timeH);
    
    // 2
    self.totalTimeLabel.frame = CGRectMake(W - timeW - 10, 5, timeW, timeH);
    
    // 3
    CGFloat sliderX = CGRectGetMaxX(self.timeLabel.frame) ;
    CGFloat sliderW = W - sliderX - self.totalTimeLabel.frame.size.width;
    self.slider.frame = CGRectMake(sliderX, 5, sliderW, 20);
    
   
}

- (void)setBtnImageState:(BOOL)selected {
    NSString *img = selected ? @"pause" : @"play";
    [self.playBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
}

- (void)playBtnClick {
    if (self.playClickBlock) {
        self.playClickBlock();
    }
}

- (void)sliderValueChange {
    if (self.SliderBlock) {
        self.SliderBlock(self.slider.value);
    }
}

@end
