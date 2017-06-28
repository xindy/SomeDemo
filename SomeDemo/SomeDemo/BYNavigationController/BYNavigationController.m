//
//  BYNavigationController.m
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYNavigationController.h"

@interface BYNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;//UINavigationControllerDelegate
    
    self.interactivePopGestureRecognizer.delegate = self;//UIGestureRecognizerDelegate
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//重写 UINavigationController 的方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count >= 1) {
        
        //push时隐藏标签栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义返回按钮
        UIBarButtonItem *popToPreBtn = [self barButtonItemWithImage:@"" highlightedImage:nil target:self action:@selector(popToPreBtnAction)];
        viewController.navigationItem.leftBarButtonItem = popToPreBtn;
    }
    
    [super pushViewController:viewController animated:animated];
    
}


//自定义返回按钮（leftBarButtonItem）
- (UIBarButtonItem *)barButtonItemWithImage:(NSString *)imageName highlightedImage:(NSString *)highlightedImageName target:(id)target action:(SEL)action {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.bounds = CGRectMake(0, 0, 40, 40);
    backBtn.imageView.contentMode = UIViewContentModeLeft;
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    backBtn.adjustsImageWhenHighlighted = NO;
    
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}


//返回按钮的响应方法
- (void)popToPreBtnAction {
    //pop到上一级页面
    [self popViewControllerAnimated:YES];
    
    //测试popToRootViewController时的bug
    //    [self popToRootViewControllerAnimated:YES];
}


#pragma mark - 实现 UIGestureRecognizerDelegate 协议内方法

//自定义了导航栏的返回按钮时，实现此方法保证返回上一级页面的侧滑手势可用
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return self.childViewControllers.count > 1;
}


#pragma mark - 实现 UINavigationControllerDelegate 协议内方法

//该方法可以解决popRootViewController时，系统自带的tabBar被显示出来的bug
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //删除系统自带的tabBarButton
    for (UIView *tabBar in self.tabBarController.tabBar.subviews) {
        
        if ([tabBar isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBar removeFromSuperview];
        }
    }
}








@end
