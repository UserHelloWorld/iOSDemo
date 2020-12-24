//
//  NFPlayerTabarView.h
//  视频播放
//
//  Created by apple on 24/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NFPlayerTabarView : UIView


@property (copy, nonatomic) dispatch_block_t playClickBlock;

@property (copy, nonatomic) void (^SliderBlock) (CGFloat value);


- (void)setBtnImageState:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
