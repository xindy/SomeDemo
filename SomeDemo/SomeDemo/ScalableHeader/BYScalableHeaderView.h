//
//  BYScalableHeaderView.h
//  SomeDemo
//
//  Created by 林必里 on 17/5/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYScalableHeaderView : UIView

/**
 *  将当前视图指定给tableView作为HeaderView
 *
 *  @param tableView   被指定的tableView
 *  @param bgImage     头部视图的背景图片
 *  @param contentView 背景图片之上的内容视图
 */
- (void)headerForTableView:(UITableView *)tableView backgroundImage:(UIImage *)bgImage contentView:(UIView *)contentView;

/**
 *  被指定的tableView发生滚动时响应
 *
 *  @param tableView  被指定的tableView
 *  @param scrollView 被指定的tableView所对应的scrollView
 */
- (void)tableView:(UITableView *)tableView didScroll:(UIScrollView*)scrollView;

@end
