//
//  NFContactSort.h
//  通讯录
//
//  Created by apple on 3/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NFContactSort : NSObject

/**
 按26个字母排序分组
 
 @param sourcesArray 数据源
 @param key 排序关键字
 @param completion 完成
 */
+ (void)sortGroupWithSourcesArray:(NSArray *)sourcesArray key:(NSString *)key completion:(void (^)(BOOL isSucceed,NSArray *groupArray,NSArray <NSString *> *titleArray))completion;

@end

NS_ASSUME_NONNULL_END


@interface NSString (Transform)

- (NSString *)pinyin; //!< 汉字转拼音字母 

@end
