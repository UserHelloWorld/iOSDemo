//
//  Person.h
//  Runtime
//
//  Created by apple on 26/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sex;
@property (assign, nonatomic) NSInteger age;


- (void)abc:(int)a;

@end

NS_ASSUME_NONNULL_END
