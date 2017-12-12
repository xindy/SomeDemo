//
//  BYTabBar.h
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BYTabBarDelegate <NSObject>

@optional

//切换当前显示项
- (void)switchToController:(NSInteger)index;

//中间项的具体相应事项
- (void)middleTabAciton;

@end

@interface BYTabBar : UITabBar

//代理
@property (nonatomic, weak) id <BYTabBarDelegate> byTabBarDelegate;

/**
 设置TabBar各项的标题、图片
 
 @param titleArray 标题数组
 @param normalImageArray 正常状态下的按钮图片（自定义中间按钮时，中间按钮的图片放最后）
 @param selectedImageArray 选中状态下的按钮图片（自定义中间按钮时，中间按钮的图片放最后）
 @param selectedIndex 默认选中项
 @param toCustom 是否需要自定义中间按钮（YES/NO）
 */
- (void)setupWithTitleArray:(NSArray *)titleArray normalImageNameArray:(NSArray *)normalImageArray selectedImageNameArray:(NSArray *)selectedImageArray selectedTabIndex:(int)selectedIndex toCustomMiddleButton:(BOOL)toCustom;

@end
