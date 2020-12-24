//
//  main.m
//  单例
//
//  Created by apple on 10/1/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Single *s1 = [Single shareInstance];
        Single *s2 = [Single new];
        Single *s3 = [[Single alloc] init];
        Single *s4 = s1;
        Single *s5 = [s1 copy];
        Single *s6 = [s1 mutableCopy];
        
        NSLog(@"%p %p %p %p %p %p",s1,s2,s3,s4,s5,s6);
    }
    return 0;
}
