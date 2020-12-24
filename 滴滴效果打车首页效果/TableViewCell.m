//
//  TableViewCell.m
//  滴滴效果打车首页效果
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@property (weak, nonatomic) UIView *bgView;

@end


@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        self.bgView = view;
        view.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(15, 0, self.bounds.size.width - 30, 40);
}

@end
