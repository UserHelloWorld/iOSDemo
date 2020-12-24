//
//  NFModel.h
//  朋友圈
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#define ContentFontSize 15  // 内容字体大小

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NFModel : NSObject

@property (assign, nonatomic) CGFloat rowHeight;

@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *content;

@property (assign, nonatomic) CGFloat imageCount;

@end


@interface NFFrameModel : NSObject

@property (assign, nonatomic) CGRect headFrame;

@property (assign, nonatomic) CGRect nameFrame;

@property (assign, nonatomic) CGRect contentFrame;

@property (assign, nonatomic) CGRect imgListFrame;

@property (assign, nonatomic) CGFloat cellHeight;

@property (strong, nonatomic) NFModel *model;


@end
