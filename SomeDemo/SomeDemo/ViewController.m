//
//  ViewController.m
//  SomeDemo
//
//  Created by xindy on 17/4/23.
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
    [self.testPanImageView setClipsToBounds:YES];
    [self.testPanImageView setImage:[UIImage imageNamed:@"longmao"]];
    [self.view addSubview:self.testPanImageView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.testPanImageView addGestureRecognizer:panGesture];
    NSLog(@"解决了一次代码冲突");
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

#pragma mark 拖动图片
-(void)panView:(UIPanGestureRecognizer *)gesture{
    
    //获取当前手势操作的视图对象
    UIView *currentPanView = gesture.view;
    //将当前被操作的视图对象移到其父视图的最上层
    [currentPanView.superview bringSubviewToFront:currentPanView];
    
    CGFloat startX = gesture.view.frame.origin.x;//视图对象的起始X点坐标
    CGFloat startY = gesture.view.frame.origin.y;//视图对象的起始Y点坐标
    
    CGFloat width = currentPanView.frame.size.width;//视图对象的宽度
    CGFloat height = currentPanView.frame.size.height;//视图对象的高度
    
    CGPoint translation = [gesture translationInView:currentPanView.superview];//当前需要平移的点位
    CGFloat currentX = startX + translation.x;//最新的X点坐标（未超出左、右边界时取该值）
    CGFloat currentY = startY + translation.y;//最新的Y点坐标（未超出上、下边界时取该值）
    
    //如果X超过了左边界
    if (currentX < 0) {
        
        currentX = 0.0;
    }
    //如果X超过了右边界
    else if (currentX > (DEVICE_WIDTH - width)) {
        
        currentX = DEVICE_WIDTH - width;
    }
    
    //如果Y超过了上边界
    if (currentY < 0) {
        
        currentY = 0.0;
    }
    //如果Y超过了下边界
    else if (currentY > (DEVICE_HEIGHT - height)) {
        
        currentY = DEVICE_HEIGHT - height;
    }
    
    [currentPanView setFrame:CGRectMake(currentX, currentY, width, height)];
    [gesture setTranslation:CGPointZero inView:currentPanView.superview];
    
//    CGPoint center = currentPanView.center;//视图对象的起始中心点
//    gesture.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
//    [gesture setTranslation:CGPointZero inView:self.view];
    
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
