//
//  ViewController.m
//  选择冒泡排序
//
//  Created by apple on 19/11/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];

//    [self insert];
    NSDate *date = [NSDate date];

    NSArray *arr = @[@"3",@"2",@"5",@"4",@"6",@"1",@"7",@"9",@"8"];
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 100000; i++) {
        NSInteger index = i % arr.count;
        [array addObject:arr[index]];
    }

    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 intValue] > [obj2 intValue];
    }];
    NSLog(@"选择排序 = %f",[[NSDate date] timeIntervalSinceDate:date]);
    self.dataArray = array;
}


// 选择排序
- (void)selectionSort
{
    NSArray *arr = @[@"3",@"2",@"5",@"4",@"6",@"1",@"7",@"9",@"8"];
    NSMutableArray *array = [NSMutableArray array];
   
    for (int i = 0; i < 100000; i++) {
        NSInteger index = i % arr.count;
        [array addObject:arr[index]];
    }
    NSDate *date = [NSDate date];
    for (int i = 0; i < array.count - 1; i++) {
        int min = i; // 假设第一i个元素最小
        for (int j = i + 1; j < array.count; j ++) {
            if ([array[min] intValue] > [array[j] intValue]) {
                min = j; // 把最小的元素index记录下来
            }
        }
        if (min != i) { // 查看一下查找的最小元素和我们假设的最小元素是否一样，不一样交换
            NSString *temp = array[min];
           	array[min] = array[i];
            array[i] = temp;
        }
    }
   NSLog(@"选择排序 = %f",[[NSDate date] timeIntervalSinceDate:date]);
    
}

// 冒泡排序
- (void)bubbleSort
{
    NSArray *arr = @[@"3",@"2",@"5",@"4",@"6",@"1",@"7",@"9",@"8"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 100000; i++) {
        NSInteger index = i % arr.count;
        [array addObject:arr[index]];
    }
    int flag;
    NSDate *date = [NSDate date];
    for (int i = 1; i < array.count -1; i++) {
        flag = 0;
        for (int j = 0; j < array.count - 1 -i; j++) {
            if ([array[j] intValue] > [array[j+1] intValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = 1; // 有操作
            }
        }
        // 并没有做过任何操作，已经是排好序的
        if (flag == 0) {
            break;
        }
    }
    NSLog(@"冒泡排序 = %f",[[NSDate date] timeIntervalSinceDate:date]);
}

// 插入排序
- (void)insert {
    
    NSArray *arr = @[@"3",@"2",@"5",@"4",@"6",@"1",@"7",@"9",@"8"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 100000; i++) {
        NSInteger index = i % arr.count;
        [array addObject:arr[index]];
    }
//    int flag = 0;
    NSDate *date = [NSDate date];
    for (int i = 1; i < array.count; i++) {
        NSInteger j = i;
        // 判断 第j个数据与前一个数据大小 
        while (j > 0 && [array[j] integerValue] < [array[j-1] intValue]) {
            [array exchangeObjectAtIndex:j withObjectAtIndex:j-1];
//            flag ++;
//            NSLog(@"%d",flag);
            j--;
        }
    }
    NSLog(@"插入排序 = %f",[[NSDate date] timeIntervalSinceDate:date]);

    self.dataArray = array;
}

#pragma mark - TableViewDelegate

// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
// cell创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSNumber *n = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",n];
    return cell;
}

// cell点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
