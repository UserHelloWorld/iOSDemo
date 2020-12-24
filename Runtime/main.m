//
//  main.m
//  Runtime
//
//  Created by apple on 26/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        // Ivar 成员变量
        
        unsigned int count;
        Ivar *ivars = class_copyIvarList(Person.self, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            const char *type = ivar_getTypeEncoding(ivar);
            NSLog(@"%s %s",name,type);
            
        }
       
        Person *p = [[Person alloc] init];

        count = 0;
      Method *sd =  class_copyMethodList(Person.self, &count);
        
   
        for (int i = 0; i< count; i++) {
            
            NSLog(@"%d",i);
            Method s = sd[i];

        }
        
        [p performSelector:@selector(run)];
        
        objc_msgSend(p,@selector(run)); // 对象方法调用
        
        objc_msgSend(Person.self, @selector(run)); // 类方法调用
        objc_msgSend(p, @selector(abc:),10,10);
        
    }
    return 0;
}
