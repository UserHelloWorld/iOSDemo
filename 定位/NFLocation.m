//
//  NFLocation.m
//  AppDemo
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NFLocation.h"

@interface NFLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locManager;

@end

@implementation NFLocation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locManager = [[CLLocationManager alloc] init];
        self.locManager.delegate=self; //设置代理
        //设置定位精度
//        self.locManager.desiredAccuracy=kCLLocationAccuracyBest;
    }
    return self;
}

// 开始定位
- (void)startLocation
{
    [self.locManager startUpdatingLocation];
}

// 停止定位
- (void)stopLocation
{
    [self.locManager stopUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{ // 定位管理设置代理 立刻会走该方法,如果你在后台修改了定位模式（如，改为了"永不"，"使用期间","始终"）回到前台都会调用
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
        {
            // 系统优先使用的是 requestWhenInUseAuthorization
            if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [manager requestWhenInUseAuthorization];
            }
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [manager requestAlwaysAuthorization];
            }
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"请开启定位功能！");
            //读取本地数据
            NSString * isPositioning = [[NSUserDefaults standardUserDefaults] valueForKey:@"isPositioning"];
            if (isPositioning == nil)//提示
            {
//                UIAlertView * positioningAlertivew = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"为了更好的体验,请到设置->隐私->定位服务中开启!【xxxAPP】定位服务,已便获取附近信息!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"永不提示",@"残忍拒绝",nil];
//                [positioningAlertivew show];
            }
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"定位无法使用！");
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"一直使用定位！");
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"使用期间使用定位!");
        }
            break;
        default:
            break;
    }
}


// 开启了 startUpdatingLocation 就会走这个方法
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"%s",__func__);
    
    /* 设置的定位是best 所以整个方法都会多次调用，调用方法最后一次为理论的最精确，每一次取数组最后的值也为理论的最精确值 */
    CLLocation *loc = locations.lastObject;
    /* 大概意思是 定位到的时间和回调方法在这一刻有一个时间差 这个差值可以自己定义用来过滤掉一些认为延时太长的数据  */
    NSTimeInterval time = [loc.timestamp timeIntervalSinceNow];
    
    // 过滤一些不太满意的数据
    
    if(fabs(time) > 10) return; // 过滤掉10秒之外的(我们只对10秒之内的定位感兴趣)
    
    // 水平精度小于0是无效的定位 必须要大于0 (正数越小越精确)
    if (loc.horizontalAccuracy < 0 )  return;
    
    if (self.locationResult) {
        self.locationResult(loc);
    }
    
    // verticalAccuracy 这个参数代表的是海拔 暂时不做处理
    
    // 停止定位，否则会一直定位下去（系统会根据偏移的距离来适当的回调，并不是该回调方法一直走，也有可能会走，需要不断地去测试）
    //    [self stopLocation]; // 已经定位到了我们要的位置
    
    
    
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0)//确认跳转设置
//    {
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }
//    else if (buttonIndex == 1)//永不提示
//    {
//        //存入本地
//        NSString * isPositioning = @"永不提示";
//        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    }
//    else//残忍拒绝
//    {
//        //取消不做提示
//    }
//}


@end
