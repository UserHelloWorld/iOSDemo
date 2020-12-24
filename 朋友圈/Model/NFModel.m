//
//  NFModel.m
//  朋友圈
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#define LeftMargin 16

#import "NFModel.h"

@implementation NFModel



@end

@implementation NFFrameModel

- (void)setModel:(NFModel *)model
{
    _model = model;
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
//    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    // 1 头像
    CGFloat iconX = LeftMargin;
    CGFloat iconY = LeftMargin;
    self.headFrame = CGRectMake(iconX, iconY, 30, 30);
    
    // 2 标题
    CGFloat nameX = CGRectGetMaxX(self.headFrame) + 10;
    CGFloat nameY = iconY;
    self.nameFrame = CGRectMake(nameX, nameY, 200 , 15);
    
    // 3 内容
    CGFloat contextX = nameX;
    CGFloat contextY = CGRectGetMaxY(self.nameFrame);
    CGFloat contextW = W - LeftMargin*2 - self.headFrame.size.width;
    CGFloat contentH = [self textHeightText:self.model.content font: [UIFont boldSystemFontOfSize:ContentFontSize] floatWidth:W-16*2-10-30];
    self.contentFrame = CGRectMake(contextX, contextY, contextW, contentH);
    
    // 4 图片
    int row = (int)self.model.imageCount % 3 > 0 ? (int)self.model.imageCount / 3 + 1: self.model.imageCount / 3;
    
    CGFloat imgListX = CGRectGetMaxX(self.headFrame);
    CGFloat imgListY = CGRectGetMaxY(self.contentFrame);
    CGFloat imgListW = self.contentFrame.size.width;
   
    CGFloat imgListH = 0;
    if (row == 1) {
        imgListH = 95;
    } else if (row > 1){
        imgListH = 90 * row;
    }
    
    self.imgListFrame = CGRectMake(imgListX, imgListY, imgListW, imgListH);
    // 5 cell 高度
    self.cellHeight = CGRectGetMaxY(self.imgListFrame);

}

- (CGFloat)textHeightText:(NSString *)str font:(UIFont *)font floatWidth:(CGFloat)width {
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return ceil(size.height);
}


@end
