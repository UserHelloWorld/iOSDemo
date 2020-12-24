//
//  NFLocation.h
//  AppDemo
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN


@protocol NFLocationDelegate <NSObject>

@optional

- (void)locationResult:(CLLocation *)location;

@end

typedef void(^LocationBlock)(CLLocation *location);


@interface NFLocation : NSObject

@property (copy, nonatomic) LocationBlock locationResult;


@property (weak, nonatomic) id <NFLocationDelegate> delegate;

- (void)startLocation; //!< 开始定位

- (void)stopLocation;  //!< 停止定位

@end

NS_ASSUME_NONNULL_END
