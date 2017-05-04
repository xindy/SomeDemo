//
//  BYGraphicsView.h
//  DrawGraph
//
//  Created by 华图－林必里 on 17/1/18.
//  Copyright © 2017年 huatu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYGraphicsView : UIView


/**
 绘制当前视图为椭圆

 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawEllipseWithFillImage:(UIImage *)fillImage
                     orFillColor:(UIColor *)fillColor;

/**
 绘制右下角圆弧

 @param arcRadius 圆弧的半径
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawLowerRightArcWithRadius:(float)arcRadius
                          fillImage:(UIImage *)fillImage
                        orFillColor:(UIColor *)fillColor;

/**
 绘制底部圆弧

 @param arcRadius 圆弧半径
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawBottomArcWithRadius:(float)arcRadius
                      fillImage:(UIImage *)fillImage
                    orFillColor:(UIColor *)fillColor;

/**
 绘制顶部三角形

 @param width 三角形的宽度
 @param height 三角形的高度
 @param offsetX 三角形相对图形X轴的偏移量
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawTopTriangleWithTriangleWidth:(float)width
                          triangleHeight:(float)height
                         triangleOffsetX:(float)offsetX
                               fillImage:(UIImage *)fillImage
                             orFillColor:(UIColor *)fillColor;

/**
 绘制底部三角形

 @param width 三角形的宽度
 @param height 三角形的高度
 @param offsetX 三角形相对图形X轴的偏移量
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawBottomTriangleWithTriangleWidth:(float)width
                             triangleHeight:(float)height
                            triangleOffsetX:(float)offsetX
                                  fillImage:(UIImage *)fillImage
                                orFillColor:(UIColor *)fillColor;


- (void)drawLowerLeftRightArcWithRadius:(float)arcRadius
                              fillImage:(UIImage *)fillImage
                            orFillColor:(UIColor *)fillColor;


- (void)drawLowerLeftRightArcTopEarWithRadius:(float)arcRadius
                                    fillImage:(UIImage *)fillImage
                                  orFillColor:(UIColor *)fillColor;


@end
