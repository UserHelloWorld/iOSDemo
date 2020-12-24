//
//  NFImageView.m
//  朋友圈
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NFImageView.h"
#import "SDPhotoBrowser.h"
@interface NFImageView ()

@property (strong, nonatomic) NSMutableArray *imageViewArray;


@end


@implementation NFImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageViewArray = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [_imageViewArray addObject:imgView];
            [self addSubview:imgView];
            imgView.tag = i + 10;
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imgView addGestureRecognizer:tap];
        }
    }
    return self;
}

- (void)setModel:(NFModel *)model {
    _model = model;
    [self layoutSubviews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIImageView *img in self.imageViewArray) {
        img.image = nil;
    }
    
    for (int i = 0; i < self.model.imageCount; i++) {
        UIImageView *imgView = self.imageViewArray[i];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        CGFloat W = 80;
        CGFloat H = 80;
        // 间隙 =（ 整个宽度 - 3个控件的宽度 ）/ 4
        CGFloat MarginW = 5;
        CGFloat MarginH = 5;
        int col = i % 3; // 列数
        int row = i / 3; // 行数
        CGFloat x =  10+col * (W + MarginW);
        CGFloat y =  10+row * (H + MarginH);
        imgView.frame = CGRectMake(x, y, W, H);
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"moment_pic_%d",(i % 9)]];
    }
}
- (void)tap:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = tapView.tag -10;
    photoBrowser.imageCount = self.model.imageCount;
    photoBrowser.sourceImagesContainerView = self;
    [photoBrowser show];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
   
    UIImageView *imageView =  self.imageViewArray[index];
    return imageView.image;
}
@end
