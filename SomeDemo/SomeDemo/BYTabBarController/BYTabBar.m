//
//  BYTabBar.m
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYTabBar.h"
#import "BYTabBarButton.h"

@interface BYTabBar ()

//当前被选中的按钮
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation BYTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}


/**
 设置TabBar各项的标题、图片
 
 @param titleArray 标题数组
 @param normalImageArray 正常状态下的按钮图片（自定义中间按钮时，中间按钮的图片放最后）
 @param selectedImageArray 选中状态下的按钮图片（自定义中间按钮时，中间按钮的图片放最后）
 @param selectedIndex 默认选中项
 @param toCustom 是否需要自定义中间按钮（YES/NO）
 */
- (void)setupWithTitleArray:(NSArray *)titleArray normalImageNameArray:(NSArray *)normalImageArray selectedImageNameArray:(NSArray *)selectedImageArray selectedTabIndex:(int)selectedIndex toCustomMiddleButton:(BOOL)toCustom {
    
    NSInteger countBtn = [titleArray count];
    
    for (int i = 0; i < countBtn; i++) {
        
        BYTabBarButton *tabBarButton = [[BYTabBarButton alloc] init];
        [tabBarButton setTag:i];
        
        //如果定制了中间按钮
        if (toCustom) {
            
            if (i < countBtn/2) {
                
                [tabBarButton setFrame:CGRectMake(i * SCREEN_WIDTH/(countBtn + 1), 0, SCREEN_WIDTH/(countBtn + 1), 49)];
            }
            else if (i >= countBtn/2) {
                
                [tabBarButton setFrame:CGRectMake((i+1) * SCREEN_WIDTH/(countBtn + 1), 0, SCREEN_WIDTH/(countBtn + 1), 49)];
            }
            
        }else {
            
            [tabBarButton setFrame:CGRectMake(i * SCREEN_WIDTH/countBtn, 0, SCREEN_WIDTH/countBtn, 49)];
        }
        
        [tabBarButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [tabBarButton setImage:[UIImage imageNamed:normalImageArray[i]] forState:UIControlStateNormal];
        [tabBarButton setImage:[UIImage imageNamed:selectedImageArray[i]] forState:UIControlStateHighlighted];
        [tabBarButton setImage:[UIImage imageNamed:selectedImageArray[i]] forState:UIControlStateSelected];
        [tabBarButton addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //如果是默认选中项
        if (i == selectedIndex) {
            
            [tabBarButton setSelected:YES];
            self.selectedBtn = tabBarButton;
        }
        
        [self addSubview:tabBarButton];
    }
    
    //定制中间按钮
    if (toCustom) {
        
        UIButton *middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //此处y值可以设置负值，使按钮偏移出去
        [middleBtn setFrame:CGRectMake(countBtn/2 * SCREEN_WIDTH/(countBtn + 1), 0, SCREEN_WIDTH/(countBtn + 1), 49)];
        [middleBtn setImage:[UIImage imageNamed:[normalImageArray lastObject]] forState:UIControlStateNormal];
        [middleBtn setImage:[UIImage imageNamed:[normalImageArray lastObject]] forState:UIControlStateHighlighted];
        [middleBtn setImage:[UIImage imageNamed:[normalImageArray lastObject]] forState:UIControlStateSelected];
        [middleBtn addTarget:self action:@selector(middleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:middleBtn];
    }
    
}

//标签按钮的响应方法
- (void)tabBarButtonAction:(UIButton *)touchedBtn {
    
    //切换当前选中项
    [self.selectedBtn setSelected:NO];
    touchedBtn.selected = YES;
    self.selectedBtn = touchedBtn;
    
    //通知代理切换显示控制器
    if ([self.delegate respondsToSelector:@selector(switchToController:)]) {
        
        [self.delegate switchToController:touchedBtn.tag];
    }
}


//中间按钮的响应方法
- (void)middleBtnAction {
    
    //通知代理处理中间标签按钮的响应事件
    if ([self.delegate respondsToSelector:@selector(middleTabAciton)]) {
        
        [self.delegate middleTabAciton];
    }
}




@end
