//
//  BYShowMoreOptionsView.h
//  SomeDemo
//
//  Created by xindy on 2017/7/26.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//协议
@protocol BYShowMoreOptionsViewDelegate <NSObject>

@optional

//选中了某项
- (void)didSelectOptionAtIndex:(NSInteger)index;

@end

@interface BYShowMoreOptionsView : UIView

/**
 实例化方法

 @param frame frame
 @param bgImageName 背景图片
 @param mOptionsArray 选项数组（每一项包含一个字典：optionDict[@"imageName":,@"title":]）
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame bgImage:(NSString *)bgImageName optionsArray:(NSMutableArray *)mOptionsArray;

//代理
@property (nonatomic, weak, nullable) id <BYShowMoreOptionsViewDelegate> delegate;


/**
 刷新列表
 */
- (void)refreshOptions;



@end

NS_ASSUME_NONNULL_END
