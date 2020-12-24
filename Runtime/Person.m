//
//  Person.m
//  Runtime
//
//  Created by apple on 26/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

+ (void)load {
    Method otherMethod =  class_getInstanceMethod(self, @selector(fly));
    Method originMethod = class_getInstanceMethod(self, @selector(run));
    method_exchangeImplementations(otherMethod, originMethod);
}

- (void)fly {
    NSLog(@"fly");
}

- (void)abc:(int)a {
    NSLog(@"%d",a);
}
+ (void)run {
    NSLog(@"run类方法");
    
}
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"%@",NSStringFromSelector(sel));
    return [super resolveClassMethod:sel];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%@",NSStringFromSelector(sel));

    class_addMethod(self.class, sel, (IMP)aaa, "abc");
    
    return [super resolveClassMethod:sel];
}

void aaa (void){
    NSLog(@"没有方法");
}
//- (void)run {
//    NSLog(@"run对象方法");
//}

@end
