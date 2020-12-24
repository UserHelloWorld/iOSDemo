//
//  ViewController.m
//  朋友圈
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"
#import "NFModel.h"
#import "NFTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end
static NSString *identifier = @"cell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = NO;
    
//    [self.tableView registerClass:NFTableViewCell.class forCellReuseIdentifier:identifier];
    
    self.dataArray = [NSMutableArray array];
    NSArray *contList = @[@"收到了福克斯李开复打开理论上的开始卡死了凯迪拉克",@"看的撒狂蜂浪蝶使肌肤的教科书的金卡的开始的健康卡将就暗示的；绿卡的骄傲风的季节阿凡达卡就卡奋达科技阿娇；士大夫快捷键快递费刷卡机发大水会计法就看看剪短发科技大厦就卡的技卡打卡机可敬的发送卡垃圾啊东方斯卡拉房间爱上了的咖啡机",@"似懂非懂开放式拉快递费绿山咖啡",@"灯数可拉开了快递费是考虑到萨洛克克里斯科勒卡戴珊可浪费大反馈大数据时代风力发电空间说拉德芳斯发大水了健康卡立方时代峻峰分手的距离分手快乐打开方式达克赛德克拉克拉放大看了房卡洛斯双方都开发就烦死了肯德基开发商的刻录机方式大家",@"都是离开圣诞快乐圣诞快乐付款了",@"第三方莱克斯顿拉卡拉卡弗兰克斯克拉克分手快乐卡萨付款了"];
    for (int i = 0; i < 100; i++) {
        NFModel *m = [[NFModel alloc] init];
        NSInteger count = contList.count;
        m.content =contList[arc4random_uniform(contList.count)] ;
        NSLog(@"%@",m.content);
        m.userName = @"我试试";
        m.imageCount = arc4random_uniform(50);
        
        NFFrameModel *fM = [[NFFrameModel alloc] init];
        fM.model = m;
        [self.dataArray addObject:fM];
    }
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate
// 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s %d",__func__,__LINE__);

    NFFrameModel *m = self.dataArray[indexPath.row];
    return m.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
