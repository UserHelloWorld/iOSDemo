//
//  ViewController.m
//  滴滴效果打车首页效果
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "TableViewCell.h"
#import "UITableView+Extension.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,   weak) MKMapView *mapView;
@property (nonatomic,   weak) UIView *navBarView;
@property (nonatomic,   weak) UITableView *tableView;
@property (nonatomic, assign) BOOL isBlack;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self subViewsInit];
    [self styleInit];
    
}
- (void)subViewsInit {
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    //    UIScrollView *mapView = [UIScrollView new];
    UIView *navBar = [UIView new];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:mapView];
    [self.view addSubview:navBar];
    [self.view addSubview:tableView];
    mapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    navBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    self.mapView = mapView;
    self.navBarView = navBar;
    self.tableView = tableView;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 150, 40)];
    //    label.text = @"这是地图View";
    [mapView addSubview:label];
}
- (void)styleInit {
    self.navBarView.backgroundColor = [UIColor redColor];
    self.mapView.backgroundColor = [UIColor yellowColor];
    //    self.mapView.contentSize = CGSizeMake(5000, 5000);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"CellId"];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        CGFloat offset = scrollView.contentOffset.y;
        if (offset>100 && !self.isBlack) {
            self.isBlack = YES;
            [UIView animateWithDuration:0.1 animations:^{
                self.tableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
                self.navBarView.frame = CGRectMake(0, -64, SCREEN_WIDTH, 64);
            }];
        }
        if (offset<100 && self.isBlack) {
            self.isBlack = NO;
            [UIView animateWithDuration:0.1 animations:^{
                self.tableView.backgroundColor = [UIColor clearColor];
                self.navBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
            }];
        }
    }
}


@end
