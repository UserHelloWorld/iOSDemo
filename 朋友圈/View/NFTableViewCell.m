//
//  NFTableViewCell.m
//  朋友圈
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NFTableViewCell.h"
#import "NFImageView.h"
#define LeftMargin 16

@interface NFTableViewCell ()

@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) NFImageView *imgView;


@end

@implementation NFTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1 头像
        self.headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headImageView];

        // 2 名字
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];

        // 3 内容
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:ContentFontSize];
        [self.contentView addSubview:self.contentLabel];
        
        // 4 图片
        self.imgView = [[NFImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        
    }
    return self;
}


- (void)setModel:(NFFrameModel *)model {
    _model = model;
    [self setData:model.model]; // 设置数据
    [self setSubViewFrame]; // 计算位置
    NSLog(@"%s %d",__func__,__LINE__);

}

- (void)setSubViewFrame
{
	// 1 头像
    self.headImageView.frame = self.model.headFrame;
  
    // 2 标题
    
    self.nameLabel.frame = self.model.nameFrame;
    
    // 3 内容
  
    self.contentLabel.frame = self.model.contentFrame;
    
    // 4 图片
    
    self.imgView.frame = self.model.imgListFrame;
    
}


- (void)setData:(NFModel *)model {
    self.headImageView.image = [UIImage imageNamed:@"headImg"];
    self.nameLabel.text = model.userName;
    self.contentLabel.text = model.content;
    self.imgView.model = model;
}

- (CGFloat)textHeightText:(NSString *)str font:(UIFont *)font floatWidth:(CGFloat)width {
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return ceil(size.height);
}


@end

