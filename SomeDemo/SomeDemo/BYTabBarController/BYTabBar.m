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
//中间的定制按钮
@property (nonatomic, strong) BYTabBarButton *middleBtn;

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
    
    //去除中间定制按钮后的数量
    NSInteger countBtn = toCustom ? [titleArray count] - 1 : [titleArray count];
    
    //初始化一般按钮
    for (int i = 0; i < countBtn; i++) {
        
        //按钮的Frame
        CGRect btnFrame;
        
        //如果定制了中间按钮
        if (toCustom) {
            
            if (i < countBtn/2) {
                
                btnFrame = CGRectMake(i * SCREEN_WIDTH/(countBtn + 1), 0, SCREEN_WIDTH/(countBtn + 1), 49);
            }
            else {
                
                btnFrame = CGRectMake((i+1) * SCREEN_WIDTH/(countBtn + 1), 0, SCREEN_WIDTH/(countBtn + 1), 49);
            }
            
        }else {
            
            btnFrame = CGRectMake(i * SCREEN_WIDTH/countBtn, 0, SCREEN_WIDTH/countBtn, 49);
        }
        
        BYTabBarButton *tabBarButton = [[BYTabBarButton alloc] initWithFrame:btnFrame butttonType:BYTabBarButtonTypeDefault titleLabelFontSize:11 titleLabelHeight:18];
        [tabBarButton setTag:i];
        
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
        
        CGFloat middleBtnWidth = SCREEN_WIDTH/(countBtn + 1);
        CGFloat middleBtnHeight = 82;
        CGFloat middleBtnX = countBtn/2 * SCREEN_WIDTH/(countBtn + 1);
        CGFloat middleBtnY = -1 * (middleBtnHeight - 49);
        
        self.middleBtn = [[BYTabBarButton alloc] initWithFrame:CGRectMake(middleBtnX, middleBtnY, middleBtnWidth, middleBtnHeight) butttonType:BYTabBarButtonTypeDefault titleLabelFontSize:12 titleLabelHeight:18];

        [self.middleBtn setTitle:[titleArray lastObject] forState:UIControlStateNormal];
        [self.middleBtn setImage:[UIImage imageNamed:[normalImageArray lastObject]] forState:UIControlStateNormal];
        [self.middleBtn setImage:[UIImage imageNamed:[normalImageArray lastObject]] forState:UIControlStateHighlighted];
        [self.middleBtn setImage:[UIImage imageNamed:[normalImageArray lastObject]] forState:UIControlStateSelected];
        [self.middleBtn addTarget:self action:@selector(middleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        self.middleBtn.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, self.middleBtn.center.y);
        
        [self addSubview:self.middleBtn];
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
        
        [self.byTabBarDelegate switchToController:touchedBtn.tag];
    }
}


//中间按钮的响应方法
- (void)middleBtnAction {
    
    //通知代理处理中间标签按钮的响应事件
    if ([self.delegate respondsToSelector:@selector(middleTabAciton)]) {
        
        [self.byTabBarDelegate middleTabAciton];
    }
}


#pragma mark - 重写UIView的方法

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.hidden == YES || self.alpha == 0) {
        return nil;
    }
    
    //如果定制了中间按钮 && 中间按钮向上偏移了
    if (_middleBtn && (_middleBtn.frame.size.height > 49)) {
        
        //判断一下点击的是不是中间按钮
        if ([self isPointInsideTabBar:point]) {
            //响应事件返回到中间按钮
            return _middleBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
    else {
        
        return [super hitTest:point withEvent:event];
    }
}

- (BOOL)isPointInsideTabBar:(CGPoint)point {
    
    CGFloat valueX = point.x - (self.bounds.size.width / 2);
    CGFloat valueY = fabs(point.y - fabs(self.bounds.size.height - _middleBtn.frame.size.height / 2));
    
    CGFloat distance = sqrt((valueX * valueX) + (valueY * valueY));
    
    if (distance < _middleBtn.frame.size.height / 2) {
        return YES;
    }else {
        return NO;
    }
    
    return YES;
}



@end
