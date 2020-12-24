//
//  NFTableViewCell.h
//  朋友圈
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NFTableViewCell : UITableViewCell

@property (strong, nonatomic) NFFrameModel *model;

@end

NS_ASSUME_NONNULL_END
