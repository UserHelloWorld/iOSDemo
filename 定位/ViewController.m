//
//  ViewController.m
//  定位
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"
#import "NFLocation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NFLocation *location = [[NFLocation alloc] init];
    [location startLocation];
    location.locationResult = ^(CLLocation * _Nonnull location) {
        NSLog(@"%@",location);
    };
}


@end
