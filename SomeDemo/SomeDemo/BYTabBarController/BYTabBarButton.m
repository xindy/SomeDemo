//
//  BYTabBarButton.m
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYTabBarButton.h"
#define Title_Height

@interface BYTabBarButton ()

@property (nonatomic, assign) BYTabBarButtonType tabBarButtonType;//按钮类型
@property (nonatomic, assign) CGFloat titleLabelFontSize;//按钮的标题文字大小
@property (nonatomic, assign) CGFloat titleLabelHeight;//按钮的标题高度

@end

@implementation BYTabBarButton

- (instancetype)initWithFrame:(CGRect)frame butttonType:(BYTabBarButtonType)type titleLabelFontSize:(CGFloat)fontSize titleLabelHeight:(CGFloat)height {
    
    if ([super initWithFrame:frame]) {
        
        //指定按钮类型
        self.tabBarButtonType = type;
        //指定标题字体大小
        self.titleLabelFontSize = fontSize;
        //指定标题高度
        self.titleLabelHeight = height;
        
        //图片靠下
        [self.imageView setContentMode:UIViewContentModeBottom];
        //标题水平居中
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        //标题字号
        [self.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        
        //正常状态时标题颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //高亮时标题颜色
        [self setTitleColor:[UIColor colorWithRed:0.12 green:0.73 blue:0.13 alpha:1.00] forState:UIControlStateHighlighted];
        //选中时标题颜色
        [self setTitleColor:[UIColor colorWithRed:0.12 green:0.73 blue:0.13 alpha:1.00] forState:UIControlStateSelected];
        
    }
    
    return self;
}


//重写方法，返回图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height - self.titleLabelHeight;
    
    return CGRectMake(0, 0, imageWidth, imageHeight);
}

//重写方法，返回title的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height - self.titleLabelHeight;
    CGFloat titleWidth = contentRect.size.width;
    
    return CGRectMake(0, titleY, titleWidth, self.titleLabelHeight);
}


@end
