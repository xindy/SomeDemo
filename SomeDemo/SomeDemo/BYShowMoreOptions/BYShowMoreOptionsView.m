//
//  BYShowMoreOptionsView.m
//  SomeDemo
//
//  Created by xindy on 2017/7/26.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYShowMoreOptionsView.h"
#import "BYShowMoreOptionsCell.h"

@interface BYShowMoreOptionsView ()<UITableViewDelegate,UITableViewDataSource>

//背景图片
@property (nonatomic, strong) NSString *bgImageName;
//存放选项数组（每一项包含一个字典：图片名称、标题）
@property (nonatomic, strong) NSMutableArray *mOptionsArray;

//背景图片视图
@property (nonatomic, strong) UIImageView *bgImgView;
//容器表格
@property (nonatomic, strong) UITableView *containerTabelView;

@end

@implementation BYShowMoreOptionsView

//实例化方法
- (instancetype)initWithFrame:(CGRect)frame bgImage:(NSString *)bgImageName optionsArray:(NSMutableArray *)mOptionsArray {
    
    if (self = [super initWithFrame:frame]) {
        
        self.bgImageName = bgImageName;
        self.mOptionsArray = mOptionsArray;
        
        [self addSubview:self.bgImgView];
        [self addSubview:self.containerTabelView];
    }
    
    return self;
}


//刷新
- (void)refreshOptions {
    
    [self.containerTabelView reloadData];
}


#pragma mark - 实现UITableViewDataSource协议内的方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.mOptionsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"BYShowMoreOptionsCell";
    BYShowMoreOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(!cell)
    {
        cell = [[BYShowMoreOptionsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //最后一格不显示分割线
    BOOL toShowSeparatorLine = (indexPath.row == [self.mOptionsArray count] - 1)? NO : YES;
    //刷新单元格
    [cell refreshWithOptionDict:self.mOptionsArray[indexPath.row] showSeparatorLine:toShowSeparatorLine];
    
    return cell;
}


#pragma mark - 实现UITableViewDelegate协议内的方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //通知代理选中了某项
    if ([self.delegate respondsToSelector:@selector(didSelectOptionAtIndex:)]) {
        
        [self.delegate didSelectOptionAtIndex:indexPath.row];
    }
}


#pragma mark - 懒加载

//背景图片视图
- (UIImageView *)bgImgView {
    
    if (_bgImgView == nil) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_bgImgView setUserInteractionEnabled:YES];//开启交互
        
        UIImage *bgImage = [UIImage imageNamed:self.bgImageName];
        bgImage =[bgImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:15.0];//拉伸
        [_bgImgView setImage:bgImage];
        
        //添加内容表格
        [_bgImgView addSubview:self.containerTabelView];
    }
    
    return _bgImgView;
}


/**
 *  容器表格
 *
 *  @return <#return value description#>
 */
- (UITableView *)containerTabelView {
    
    if (_containerTabelView == nil) {
        
        _containerTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 8, self.frame.size.width, self.frame.size.height - 8)];
        
        [_containerTabelView setBackgroundColor:[UIColor clearColor]];
        [_containerTabelView setBounces:NO];//关闭回弹效果
        [_containerTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];//不显示分割线
        [_containerTabelView setShowsVerticalScrollIndicator:NO];//不显示垂直滚动条
        [_containerTabelView setDelegate:self];
        [_containerTabelView setDataSource:self];
        
        //设置页眉
        [_containerTabelView setTableHeaderView:[UIView new]];
        //设置页脚
        [_containerTabelView setTableFooterView:[UIView new]];
        
    }
    
    return _containerTabelView;
}


@end
