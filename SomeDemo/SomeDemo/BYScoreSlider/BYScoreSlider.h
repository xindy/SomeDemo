//
//  BYScoreSlider.h
//  SomeDemo
//
//  Created by xindy on 2017/7/14.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ScoreSliderStepTypePointFive,//精确到0.5
    ScoreSliderStepTypeRounding,//精确到1
} ScoreSliderStepType;

//协议
@protocol BYScoreSliderDelegate <NSObject>

@optional

//传递值给代理
- (void)currentSliderValue:(CGFloat)value;

@end

@interface BYScoreSlider : UIView

/**
 实例化
 
 @param frame frame
 @param title 默认的提示标题
 @param titleColor 提示标题的颜色
 @param leftImage 滑动条的左半边图片
 @param rightImage 滑动条的右半边图片
 @param thumbImage 滑块图片
 @param maxlValue 滑动条的最大值
 @param minilValue 滑动条的最小值
 @param defaultValue 默认值
 @param stepType 步长类型
 @return 当前实例
 */
- (instancetype _Nonnull)initWithFrame:(CGRect)frame
                          defaultTitle:(NSString *_Nonnull)title
                            titleColor:(UIColor *_Nonnull)titleColor
                        leftTrackImage:(UIImage *_Nonnull)leftImage
                       rightTrackImage:(UIImage *_Nonnull)rightImage
                            thumbImage:(UIImage *_Nonnull)thumbImage
                              maxValue:(CGFloat)maxlValue
                             miniValue:(CGFloat)minilValue
                          defaultValue:(CGFloat)defaultValue
                              stepType:(ScoreSliderStepType)stepType;

//代理
@property(nullable,nonatomic,weak) id <BYScoreSliderDelegate> delegate;


@end
