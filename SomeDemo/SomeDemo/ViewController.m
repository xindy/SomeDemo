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
@property (nonatomic, strong) UIImageView *testPanImageView;

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
    
    self.testPanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 200)];
    [self.testPanImageView setUserInteractionEnabled:YES];
    [self.testPanImageView setContentMode:UIViewContentModeScaleAspectFill];
//    [self.testPanImageView setClipsToBounds:YES];
    [self.testPanImageView setImage:[UIImage imageNamed:@"longmao"]];
    [self.view addSubview:self.testPanImageView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImage:)];
    [self.testPanImageView addGestureRecognizer:panGesture];
}



#pragma mark - 实现UITableViewDataSource协议内的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"CellReuseIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
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

#pragma mark 拖动图片
-(void)panImage:(UIPanGestureRecognizer *)gesture{
    
    
    [gesture.view.superview bringSubviewToFront:gesture.view];
    CGPoint center = gesture.view.center;
//    CGFloat cornerRadius = gesture.view.frame.size.width / 2;
    CGPoint translation = [gesture translationInView:self.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    gesture.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:self.view];
    
    if (gesture.state==UIGestureRecognizerStateChanged) {
        
        //        CGPoint translation=[gesture translationInView:APPDELEGATE.window];//利用拖动手势的translationInView:方法取得在相对指定视图（控制器根视图）的移动
        //        ScrollinglV.transform=CGAffineTransformMakeTranslation(translation.x, translation.y);
        
        
    }else if(gesture.state==UIGestureRecognizerStateEnded){
        
        
        //        [UIView animateWithDuration:0.5 animations:^{
        //            ScrollinglV.transform=CGAffineTransformIdentity;
        //        }];
    }
    
}



@end
