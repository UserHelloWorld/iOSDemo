//
//  ViewController.m
//  通讯录
//
//  Created by apple on 3/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"
#import "NFContactSort.h"
#import "ContactModel.h"

@interface ViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = @[@"收到了",@"打开了",@"爱迪生",@"是多少",@"第三方",@"都是",@"特是",@"多少",@"梵蒂冈的",@"的地方地方",@"512232",@"dflk",@"klfdsaklsd",@"5143454",@"54355ds,.",@"",@"1",@"a",@"",@"  ",@"lk"];
    for (int i = 0; i < arr.count; i++) {
        ContactModel *m = [[ContactModel alloc] init];
        
        m.name = arr[i];
        
        [array addObject:m];
    }
    
    [NFContactSort sortGroupWithSourcesArray:array key:@"name" completion:^(BOOL isSucceed, NSArray * _Nonnull groupArray, NSArray<NSString *> * _Nonnull titleArray) {
        if (isSucceed) {
            self.dataArray = groupArray;
            self.titleArray = titleArray;
            [self.tableView reloadData];
        }
    }];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
    
}
#pragma mark - TableViewDelegate

// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArray count];
}
// 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}
// cell创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ContactModel *m = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = m.name;
    return cell;
}

// cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    l.text = self.titleArray[section+1];
    l.textColor = [UIColor blackColor];
    [headerView addSubview:l];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.titleArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (index > 0) {
        return index-1;
    }
    return index;
}



@end
