//
//  BYTabBarButton.m
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYTabBarButton.h"

@implementation BYTabBarButton


- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        //图片靠下
        [self.imageView setContentMode:UIViewContentModeBottom];
        //标题水平居中
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        //标题字号
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
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
    CGFloat imageHeight = contentRect.size.height * 0.6;
    
    return CGRectMake(0, 0, imageWidth, imageHeight);
}

//重写方法，返回title的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHeight = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleWidth, titleHeight);
}


@end
