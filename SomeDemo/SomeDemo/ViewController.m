//
//  ViewController.m
//  SomeDemo
//
//  Created by 林必里 on 17/4/23.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "ViewController.h"
#import "BYScalableHeaderView.h"

#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *scalableHeaderTableView;
@property (nonatomic, strong) BYScalableHeaderView *scalableHeaderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 视图区

- (void)addSubViews {
    
    [self.view addSubview:self.scalableHeaderTableView];
    
    NSLog(@"测试冲突解决");
}


- (void)panImage:(UIGestureRecognizer *)gesture {
    
    NSLog(@"来啊  冲突一下");
}



#pragma mark - 实现UITableViewDataSource协议内的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"CellReuseIdentifier";
    
    NSLog(@"wo %@",reuseIdentifier);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",indexPath.row]];
    reuseIdentifier = @"sga";
    NSLog(@"shi %@",reuseIdentifier);
    
    return cell;
}


#pragma mark - 实现UITableViewDelegate协议内的方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0;
}

#pragma mark - 实现UIScrollViewDelegate协议内的方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.scalableHeaderView tableView:self.scalableHeaderTableView didScroll:scrollView];
}


#pragma mark - 懒加载

- (UITableView *)scalableHeaderTableView {
    
    
    if (!_scalableHeaderTableView) {
        
        _scalableHeaderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        
        _scalableHeaderTableView.dataSource = self;
        _scalableHeaderTableView.delegate = self;
        
        self.scalableHeaderView = [[BYScalableHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        [contentView setBackgroundColor:[UIColor redColor]];
        [self.scalableHeaderView headerForTableView:_scalableHeaderTableView backgroundImage:[UIImage imageNamed:@"longmao"] contentView:contentView];
    }
    
    return _scalableHeaderTableView;
}




@end
