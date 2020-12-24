//
//  NFContactSort.m
//  通讯录
//
//  Created by apple on 3/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NFContactSort.h"
#import "ContactModel.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface SortModel : NSObject

@property (copy, nonatomic) NSString *nameKey;

@property (strong, nonatomic) id obj; //!< 传进来的模型对象

@end

@implementation SortModel
- (NSString *)nameKey {
    return _nameKey ? _nameKey : @"";
}
@end

@implementation NFContactSort

+ (void)sortGroupWithSourcesArray:(NSArray *)sourcesArray key:(NSString *)key completion:(void (^)(BOOL, NSArray * _Nonnull, NSArray<NSString *> * _Nonnull))completion
{
    // 过滤
    if (sourcesArray.count < 1 || !sourcesArray || !key) {
        if (completion) {
            completion(NO,@[],@[]);
        }
        return;
    }
    
    BOOL containKey = NO; // 关键字检测
    
    NSObject *obj = sourcesArray.firstObject;
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(obj.class , &count);
    for (int i = 0; i < count; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:keyName]) {
            containKey = YES; // 存在key值
            break;
        }
    }
    // 不存在
    if (!containKey) {
        if (completion) {
            completion(NO,@[],@[]);
        }
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableArray *buildArray = [NSMutableArray array];
        [sourcesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SortModel *m = [[SortModel alloc] init];
            m.nameKey = [obj valueForKey:key];
            m.obj = obj;
            [buildArray addObject:m];
        }];
        
        // 1 排序
        NSArray *sortArray = [buildArray sortedArrayUsingComparator:^NSComparisonResult(SortModel *obj1, SortModel *obj2) {
            NSString *str1 = [obj1.nameKey pinyin];
            NSString *str2 = [obj2.nameKey pinyin];
            
            for (int i = 0; i < str1.length && i < str2.length; i++) {
                char A = [str1 characterAtIndex:i];
                char B = [str2 characterAtIndex:i];
                if ( A > B) {
                    return NSOrderedDescending; // 降序
                } else if (A < B ){
                    return NSOrderedAscending;//升序
                }
            }
            // 如果有为空字符则比较长度
            if (str1.length > str2.length) {
                return NSOrderedAscending; // 升序
            } else if (str1.length < str2.length) {
                return NSOrderedDescending;// 降序
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        // 2 分组
        NSMutableArray *sectionArray = [NSMutableArray array];
        NSMutableArray *rowArray = nil; // 用于保存26个字母开头数组
        NSMutableArray *otherArray = [NSMutableArray array]; // 不属于26个字母数组保存
        
        char lastChar = '0';
        for (SortModel *model in sortArray) {
             NSString *key = [model.nameKey stringByReplacingOccurrencesOfString:@" " withString:@""]; // 过滤掉所有空格
            if (key.length < 1) {
                [otherArray addObject:model.obj];
                continue;
            }
            char c = [[model.nameKey pinyin] characterAtIndex:0]; // 获取首字符
            if (!isalpha(c)) { // 不属于26个字母
                [otherArray addObject:model.obj];
            } else if (c != lastChar) {
                /* 最后一次记录的字符跟现在这个数据的字符不一样
                 先记字符，在添加到行组，如果之前已经有过上一次分好的row组择添加到section组里去
                 */
                lastChar = c;
                if (rowArray.count > 0) {
                    [sectionArray addObject:rowArray]; // 分好的一个组
                }
                rowArray = [NSMutableArray array];
                [rowArray addObject:model.obj];
            } else {
                [rowArray addObject:model.obj];
            }
        }
        
        //  添加最后一次分好的row组和26字母之外的组
        if (rowArray.count > 0) {
            [sectionArray addObject:rowArray];
        }
        if (otherArray.count > 0) {
            [sectionArray addObject:otherArray];
        }
        // 获取组头（26个字母）
        NSArray *titleArray = [self titleArray:sectionArray key:key];
        
        //  3 完成返回
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(YES,sectionArray,titleArray);
            }
        });
    });
}

// 获取组头首字母
+ (NSArray *)titleArray:(NSArray *)groupArray key:(NSString *)key{
    NSMutableArray *titleArray = [NSMutableArray array];
    [titleArray addObject:UITableViewIndexSearch];
    for (NSArray *array in groupArray) {
        id obj = array.firstObject;
        NSString *str = [[obj valueForKey:key] pinyin];
        if (str.length < 1) {
            [titleArray addObject:@"#"];
        } else {
            char c = [[[obj valueForKey:key] pinyin] characterAtIndex:0];
            if (!isalpha(c)) {
                c = '#';
            }
            [titleArray addObject:[NSString stringWithFormat:@"%c",toupper(c)]];
        }
    }
    return titleArray;
}

@end


@implementation NSString (Transform)

/** 汉字转拼音字母 */
- (NSString *)pinyin {
    NSMutableString *string = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)string, NULL, kCFStringTransformStripDiacritics, NO);
    return [[string stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

@end
