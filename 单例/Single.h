//
//  Single.h
//  单例
//
//  Created by apple on 10/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Single : NSObject<NSCopying,NSMutableCopying>

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
