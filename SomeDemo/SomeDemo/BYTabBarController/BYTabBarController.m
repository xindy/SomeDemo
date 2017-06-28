//
//  BYTabBarController.m
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYTabBarController.h"
#import "BYTabBar.h"
#import "BYNavigationController.h"
#import "ViewController.h"

@interface BYTabBarController ()<BYTabBarDelegate>

//自定义的TabBar
@property (nonatomic, strong) BYTabBar *byTabBar;


@end

@implementation BYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义TabBar
    [self customTabBar];
    
    //设置 TabBarController 的子控制器
    [self setupChildControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义TabBar
- (void)customTabBar {
    
    self.byTabBar = [[BYTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    [self.byTabBar setDelegate:self];
//    [self.byTabBar setBackgroundColor:[UIColor lightGrayColor]];
    
    //标题
    NSArray *titleArray = @[@"发现",@"关注",@"消息",@"我的"];
    //正常状态的图片
    NSArray *normalImageNameArray = @[@"tabBar_discover",@"tabBar_follow",@"tabBar_message",@"tabBar_mine",@"tabBar_middle"];
    //选中状态的图片
    NSArray *selectedImageNameArray = @[@"tabBar_discover_selected",@"tabBar_follow_selected",@"tabBar_message_selected",@"tabBar_mine_selected",@"tabBar_middle"];
    
    //设置tabBar的按钮
    [self.byTabBar setupWithTitleArray:titleArray normalImageNameArray:normalImageNameArray selectedImageNameArray:selectedImageNameArray selectedTabIndex:0 toCustomMiddleButton:YES];
    
    [self.tabBar addSubview:self.byTabBar];
}


//设置 TabBarController 的子控制器
- (void)setupChildControllers {
    
    ViewController *firstVC = [[ViewController alloc] init];
    BYNavigationController *firstNav = [[BYNavigationController alloc] initWithRootViewController:firstVC];
    
    UITableViewController *secondVC = [[UITableViewController alloc] init];
    BYNavigationController *secondNav = [[BYNavigationController alloc] initWithRootViewController:secondVC];
    
    ViewController *thirdVC = [[ViewController alloc] init];
    [thirdVC.view setBackgroundColor:[UIColor lightGrayColor]];
    BYNavigationController *thirdNav = [[BYNavigationController alloc] initWithRootViewController:thirdVC];
    
    UITableViewController *fourthVC = [[UITableViewController alloc] init];
    [fourthVC.view setBackgroundColor:[UIColor lightGrayColor]];
    BYNavigationController *fourthNav = [[BYNavigationController alloc] initWithRootViewController:fourthVC];
    
    [self setViewControllers:@[firstNav,secondNav,thirdNav,fourthNav]];
    //设置默认显示项
    self.selectedIndex = 0;
}


#pragma mark - 实现 BYTabBarDelegate 协议内方法

//切换当前显示项
- (void)switchToController:(NSInteger)index {
    
    self.selectedIndex = index;
}

//中间项的具体相应事项
- (void)middleTabAciton {
    
    NSLog(@"相应中间按钮");
//    UITableViewController *secondVC = [[UITableViewController alloc] init];
//    BYNavigationController *secondNav = [[BYNavigationController alloc] initWithRootViewController:secondVC];
//    
//    [self presentViewController:secondNav animated:YES completion:nil];
}




@end
