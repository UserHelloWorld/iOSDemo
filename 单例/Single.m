//
//  Single.m
//  单例
//
//  Created by apple on 10/1/19.
//  Copyright © 2019 apple. All rights reserved.
//


/*
 new   基本等同于  alloc init

 区别在于 alloc 可以接 initWith***方法  而new只能init方法
 */

#import "Single.h"

@implementation Single

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    static Single *single = nil;
    dispatch_once(&onceToken, ^{
//        single = [[super alloc] init];
        single = [[super allocWithZone:NULL] init];
    });
    return single;
}
// 也可以重写alloc
//+ (instancetype)alloc {
//    return [Single shareInstance];
//}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [Single shareInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return [Single shareInstance];
}

-(id) mutableCopyWithZone:(struct _NSZone *)zone {
    return [Single shareInstance];
}

@end
