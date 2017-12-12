//
//  BYScoreSlider.m
//  SomeDemo
//
//  Created by xindy on 2017/7/14.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYScoreSlider.h"

#define kScoreSliderMarginLeft 20
#define kThumbImageWidth 10.5

@interface BYScoreSlider ()<UIGestureRecognizerDelegate>

//提示滑动估分
@property (nonatomic, strong) UILabel *hintLabel;
//用于显示当前值
@property (nonatomic, strong) UILabel *scoreLabel;
//滑动估分条
@property (nonatomic, strong) UISlider *scoreSlider;
//点击手势
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
//步长类型
@property (nonatomic, assign) ScoreSliderStepType stepType;

@end

@implementation BYScoreSlider

//实例化
- (instancetype _Nonnull)initWithFrame:(CGRect)frame
                          defaultTitle:(NSString *_Nonnull)title
                            titleColor:(UIColor *_Nonnull)titleColor
                        leftTrackImage:(UIImage *_Nonnull)leftImage
                       rightTrackImage:(UIImage *_Nonnull)rightImage
                            thumbImage:(UIImage *_Nonnull)thumbImage
                              maxValue:(CGFloat)maxlValue
                             miniValue:(CGFloat)minilValue
                          defaultValue:(CGFloat)defaultValue
                              stepType:(ScoreSliderStepType)stepType {
    
    if (self = [super initWithFrame:frame]) {
        
        //步长类型
        self.stepType = stepType;
        
        [self.scoreSlider setMinimumTrackImage:leftImage forState:UIControlStateNormal];
        [self.scoreSlider setMaximumTrackImage:rightImage forState:UIControlStateNormal];
        [self.scoreSlider setThumbImage: thumbImage forState:UIControlStateNormal];
        
        [self.scoreSlider setMaximumValue:maxlValue];
        [self.scoreSlider setMinimumValue:minilValue];
        [self.scoreSlider setValue:defaultValue];
        //添加滑动估分slider
        [self addSubview:self.scoreSlider];
        
        //添加显示分值的label
        [self addSubview:self.scoreLabel];
        [self.scoreLabel setTextColor:titleColor];
        
        //如果没有默认值，提示滑动估分
        if (defaultValue > 404) {
            
            //添加提示
            [self addSubview:self.hintLabel];
            [self.hintLabel setTextColor:titleColor];
            [self.hintLabel setText:title];
            //设为最小值
            [self.scoreSlider setValue:minilValue];
        }
        else {
            [self.scoreLabel setHidden:NO];
            //更新当前分值
            [self updateScoreLabel:defaultValue];
        }
    }
    
    return self;
}

//更新当前分值
- (void)updateScoreLabel:(CGFloat)value {
    
    [self.scoreLabel setText:[self valueToString:value]];
    [self.scoreLabel setCenter:CGPointMake([self currentCenterXForScoreLabel:value], 10)];
}


#pragma mark - 数据处理

//对要显示的值做处理，以0.5为最小单位，.0时舍去
- (NSString *)valueToString:(CGFloat)value {
    
    NSString *valueString = [NSString stringWithFormat:@"%.1f",value];
    
    //如果传入的值没有.5
    if (![valueString containsString:@".5"]) {
        
        valueString = [NSString stringWithFormat:@"%.f",value];
    }
    
    return valueString;
}

//根据当前值计算scoreLabel的CenterX值
- (CGFloat)currentCenterXForScoreLabel:(CGFloat)value {
    
    CGFloat centerX = 0.0;
    //正常的X轴偏移值
    CGFloat offsetX = value/_scoreSlider.maximumValue * (self.frame.size.width -  kScoreSliderMarginLeft * 2);
    
    CGFloat middleValue = _scoreSlider.maximumValue/2;
    //如果当前值为 0~中值
    if (value <= middleValue) {
        
        centerX = kScoreSliderMarginLeft + offsetX + (1 - value/middleValue) * kThumbImageWidth;
    }
    else {
        
        centerX = kScoreSliderMarginLeft + offsetX - (value/middleValue - 1) * kThumbImageWidth;
    }
    
    return centerX;
}

//获取所需的有效值
- (CGFloat)currentEffectiveValue:(CGFloat)value {
    
    //有效值（默认步长类型ScoreSliderStepTypeRounding）
    CGFloat effectiveValue = roundf(value);//小数点四舍五入
    
    //如果步长是0.5
    if (self.stepType == ScoreSliderStepTypePointFive) {
        
        //需要计算的最小分步值
        CGFloat miniStep = 0.25;
        int countMiniStep = (int)(value/miniStep);
        countMiniStep = (countMiniStep%2 == 1) ? ++countMiniStep : countMiniStep;
        
        effectiveValue = countMiniStep * miniStep;
    }
    
    return effectiveValue;
}


#pragma mark - 响应方法

//防止点击手势引起的抖动
- (void)sliderTouchDown:(UISlider *)sender {
    
    _tapGesture.enabled = NO;
}

//抬起手指时矫正
- (void)sliderTouchUp:(UISlider *)sender {
    
    _tapGesture.enabled = YES;
    
    //有效值
    CGFloat effectiveValue = [self currentEffectiveValue:_scoreSlider.value];
    
    [self.scoreSlider setValue:effectiveValue];
    //更新当前分值
    [self updateScoreLabel:effectiveValue];
    
    //通知代理接收当前有效值
    if ([self.delegate respondsToSelector:@selector(currentSliderValue:)]) {
        
        [self.delegate currentSliderValue:effectiveValue];
    }
}

//拖动滑块时值改变
- (void)sliderValueChanged:(UISlider *)slider {
    
    [self.hintLabel setHidden:YES];
    [self.scoreLabel setHidden:NO];
    
    //有效值
    CGFloat effectiveValue = [self currentEffectiveValue:slider.value];
    //更新当前分值
    [self.scoreLabel setText:[self valueToString:effectiveValue]];
    //平滑显示当前分值
    [self.scoreLabel setCenter:CGPointMake([self currentCenterXForScoreLabel:slider.value], 10)];
}


//单击手势响应方法
- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    
    [self.hintLabel setHidden:YES];
    [self.scoreLabel setHidden:NO];
    
    CGPoint touchPoint = [sender locationInView:_scoreSlider];
    CGFloat value = (_scoreSlider.maximumValue - _scoreSlider.minimumValue) * (touchPoint.x / _scoreSlider.frame.size.width );
    //计算得到小于最小值
    if (value < _scoreSlider.minimumValue) {
        
        value = _scoreSlider.minimumValue;
    }
    //计算得到超出最大值
    if (value > _scoreSlider.maximumValue) {
        
        value = _scoreSlider.maximumValue;
    }
    
    //有效值
    CGFloat effectiveValue = [self currentEffectiveValue:value];
    
    //更新当前分值
    [_scoreSlider setValue:effectiveValue animated:YES];
    [self updateScoreLabel:effectiveValue];
    
    //通知代理接收当前有效值
    if ([self.delegate respondsToSelector:@selector(currentSliderValue:)]) {
        
        [self.delegate currentSliderValue:effectiveValue];
    }
}



#pragma mark - 懒加载

//提示滑动估分
- (UILabel *)hintLabel {
    
    if (!_hintLabel) {
        
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScoreSliderMarginLeft, 0, 100, 20)];
        [_hintLabel setFont:[UIFont systemFontOfSize:14.0]];
        //        [_hintLabel setText:@"滑动估分"];
    }
    
    return _hintLabel;
}

//当前值
- (UILabel *)scoreLabel {
    
    if (!_scoreLabel) {
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        [_scoreLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
        //        [_scoreLabel setText:@"10.5"];
        [_scoreLabel setHidden:YES];
    }
    
    return _scoreLabel;
}

//滑动估分slider
- (UISlider *)scoreSlider {
    
    if (!_scoreSlider) {
        
        _scoreSlider = [[UISlider alloc] initWithFrame:CGRectMake(kScoreSliderMarginLeft, 20, self.frame.size.width - kScoreSliderMarginLeft * 2, self.frame.size.height - 20 - 20)];
        [_scoreSlider setContinuous:YES];
        
        //针对值变化添加响应方法
        [_scoreSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        //当滑块被按下时
        [_scoreSlider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        //当松开滑块时
        [_scoreSlider addTarget:self action:@selector(sliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加点击手势
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
        _tapGesture.delegate = self;
        [_scoreSlider addGestureRecognizer:_tapGesture];
        
    }
    
    return _scoreSlider;
}


@end
