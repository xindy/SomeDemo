//
//  BYScalableHeaderView.m
//  SomeDemo
//
//  Created by 林必里 on 17/5/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYScalableHeaderView.h"

@interface BYScalableHeaderView ()

@property (nonatomic, strong) UIImageView *bgImageView;//背景图片视图（拉伸放大的图片）
@property (nonatomic, strong) UIView *headerContentView;//背景图片之上的内容视图

@end

@implementation BYScalableHeaderView

/**
 *  将当前视图指定给tableView作为HeaderView
 *
 *  @param tableView   被指定的tableView
 *  @param bgImage     头部视图的背景图片
 *  @param contentView 背景图片之上的内容视图
 */
- (void)headerForTableView:(UITableView *)tableView backgroundImage:(UIImage *)bgImage contentView:(UIView *)contentView {
        
    [tableView setTableHeaderView:self];
    
    //在tableView的HeaderView上覆盖一个背景图片视图
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
    [self.bgImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.bgImageView setClipsToBounds:YES];
    [self.bgImageView setImage:bgImage];
    [tableView addSubview:self.bgImageView];
    
    //在背景图片上覆盖一个内容视图
    self.headerContentView = contentView;
    [self.headerContentView setCenter:self.bgImageView.center];
    [tableView addSubview:self.headerContentView];
    
}

/**
 *  被指定的tableView发生滚动时响应
 *
 *  @param tableView  被指定的tableView
 *  @param scrollView 被指定的tableView所对应的scrollView
 */
- (void)tableView:(UITableView *)tableView didScroll:(UIScrollView*)scrollView {
    
    //如果向下拉伸
    if(scrollView.contentOffset.y < 0)
    {
        //即将进行缩放的frame
        CGRect scaleframe;
        
        //计算偏移
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        //缩放宽、高
        scaleframe.size.width  = tableView.frame.size.width + offsetY;
        scaleframe.size.height = self.frame.size.height + offsetY;
        //调整x、y轴的起点位置
        scaleframe.origin.y = - offsetY * 1;
        scaleframe.origin.x = - offsetY / 2;
        
        //重新设置图片的frame
        [self.bgImageView setFrame:scaleframe];
        
    }else{
        //恢复初始情况
        [self.bgImageView setFrame:self.frame];
    }
    
    //始终保持与图片的中心点一致
    [self.headerContentView setCenter:self.bgImageView.center];
}


@end
