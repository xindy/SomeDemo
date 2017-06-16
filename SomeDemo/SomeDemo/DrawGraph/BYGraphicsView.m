//
//  BYGraphicsView.m
//  DrawGraph
//
//  Created by xindy on 17/1/18.
//  Copyright © 2017年 huatu. All rights reserved.
//



#import "BYGraphicsView.h"

//枚举图形类别
typedef enum : NSUInteger {
    BYGraphicsViewTypeEllipse = 0,//椭圆
    BYGraphicsViewTypeLowerRightArc,//右下角带圆弧
    BYGraphicsViewTypeBottomArc,//底部圆弧
    BYGraphicsViewTypeTopTriangle,//顶部三角形
    BYGraphicsViewTypeBottomTriangle,//底部三角形
    BYGraphicsViewTypeLowerLeftRightArc,//左、右下角圆角
    BYGraphicsViewTypeTopEar,
    
} BYGraphicsViewType;


@implementation BYGraphicsView
{
    BYGraphicsViewType _currentGraphicsViewType;//当前要绘制的图形类别
    float _arcRadius;//圆弧的半径
    float _triangleWidth;//三角形的宽度
    float _triangleHeight;//三角形的高度
    float _triangleOffsetX;//三角形相对图形X轴的偏移量
    UIImage *_fillImage;//填充图片
    UIColor *_fillColor;//填充色
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    switch (_currentGraphicsViewType) {
            
        case BYGraphicsViewTypeEllipse:
            //绘制椭圆
            [self drawViewToEllipse];
            break;
            
        case BYGraphicsViewTypeLowerRightArc:
            //绘制右下角为圆角
            [self drawViewToLowerRightArc];
            break;
            
        case BYGraphicsViewTypeBottomArc:
            //绘制底边为圆弧
            [self drawViewToBottomArc];
            break;
            
        case BYGraphicsViewTypeTopTriangle:
            //绘制顶部三角形
            [self drawViewToTopTriangle];
            break;
            
        case BYGraphicsViewTypeBottomTriangle:
            //绘制底部三角形
            [self drawViewToBottomTriangle];
            break;
            
        case BYGraphicsViewTypeLowerLeftRightArc:
            [self drawViewToLowerLeftRightArc];
            break;
            
        case BYGraphicsViewTypeTopEar:
            [self drawViewTopEar];
            break;
            
        default:
            break;
    }
    
}


#pragma mark - 绘图区

//绘制椭圆
- (void)drawViewToEllipse {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
    // 绘制圆方法(其实所绘制的圆为所绘制用的Rect的矩形的内切圆，当宽度等于高度时，即为正圆)
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, currentSize.width, currentSize.height));
    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

//绘制右下角为圆角
- (void)drawViewToLowerRightArc {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
    //指定当前的起始点
    CGContextMoveToPoint(ctx, 0, 0);
    //指定点1，将从起点到点1形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width, 0);
    //指定点2，将从点1到点2形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width, currentSize.height - _arcRadius);
    
    //更改当前的起始点
    CGContextMoveToPoint(ctx, 0, 0);
    //指定点3，将从起点到点3形成一条线
    CGContextAddLineToPoint(ctx, 0, currentSize.height);
    //指定点4，将从点3到点4形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width - _arcRadius, currentSize.height);
    
    //绘制二次贝塞尔曲线，控制点为矩形的右下角点坐标，当前最后一次指定的点将要连接的目标点
    CGContextAddQuadCurveToPoint(ctx, currentSize.width, currentSize.height, currentSize.width, currentSize.height - _arcRadius);
    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

//绘制底边为圆弧
- (void)drawViewToBottomArc {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
    //指定当前的起始点
    CGContextMoveToPoint(ctx, 0, 0);
    //指定点1，将从起点到点1形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width, 0);
    //指定点2，将从点1到点2形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width, currentSize.height - _arcRadius);
    
    //更改当前的起始点
    CGContextMoveToPoint(ctx, 0, 0);
    //指定点3，将从起点到点3形成一条线
    CGContextAddLineToPoint(ctx, 0, currentSize.height - _arcRadius);
    
    //绘制二次贝塞尔曲线，控制点为矩形的底边中点坐标，当前最后一次指定的点将要连接的目标点
    CGContextAddQuadCurveToPoint(ctx, currentSize.width/2, currentSize.height, currentSize.width, currentSize.height - _arcRadius);
    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

//绘制顶部三角形
- (void)drawViewToTopTriangle {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
    //指定当前的起始点
    CGContextMoveToPoint(ctx, 0, _triangleHeight);
    //指定三角形的左边点
    CGContextAddLineToPoint(ctx, _triangleOffsetX, _triangleHeight);
    //指定三角形的尖点（高点）
    CGContextAddLineToPoint(ctx, _triangleOffsetX + _triangleWidth/2, 0);
    //指定三角形的右边点
    CGContextAddLineToPoint(ctx, _triangleOffsetX + _triangleWidth, _triangleHeight);
    
    CGContextAddLineToPoint(ctx, currentSize.width, _triangleHeight);
    
    CGContextAddLineToPoint(ctx, currentSize.width, currentSize.height);

    CGContextAddLineToPoint(ctx, 0, currentSize.height);
    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

//绘制底部三角形
- (void)drawViewToBottomTriangle {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
    //指定当前的起始点
    CGContextMoveToPoint(ctx, 0, 0);
    //指定点1，将从起点到点1形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width, 0);
    //指定点2，将从点1到点2形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width, currentSize.height - _triangleHeight);
    //指定三角形的右边点
    CGContextAddLineToPoint(ctx, _triangleOffsetX + _triangleWidth, currentSize.height - _triangleHeight);
    //指定三角形的尖点（高点）
    CGContextAddLineToPoint(ctx, _triangleOffsetX + _triangleWidth/2, currentSize.height);
    //指定三角形的左边点
    CGContextAddLineToPoint(ctx, _triangleOffsetX, currentSize.height - _triangleHeight);
    
    CGContextAddLineToPoint(ctx, 0, currentSize.height - _triangleHeight);
    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}



//绘制左、右下角为圆角
- (void)drawViewToLowerLeftRightArc {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
    //指定当前的起始点
    CGContextMoveToPoint(ctx, 0, 0);
    //指定点1，将从起点到点1形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width/2, 0);
    //指定点2，将从点1到点2形成一条线
    CGContextAddLineToPoint(ctx, currentSize.width/2, currentSize.height);
    
    CGContextAddLineToPoint(ctx, _arcRadius, currentSize.height);
    
    CGContextMoveToPoint(ctx, 0, 0);
    
    CGContextAddLineToPoint(ctx, 0, currentSize.height - _arcRadius);
    
    //绘制二次贝塞尔曲线，控制点为矩形的左下角点坐标，当前最后一次指定的点将要连接的目标点
    CGContextAddQuadCurveToPoint(ctx, 0, currentSize.height, _arcRadius, currentSize.height);
    
    
    CGContextMoveToPoint(ctx, currentSize.width, currentSize.height - _arcRadius);
    CGContextAddLineToPoint(ctx, currentSize.width, 0);
    CGContextAddLineToPoint(ctx, currentSize.width/2, 0);
    CGContextAddLineToPoint(ctx, currentSize.width/2, currentSize.height);
    CGContextAddLineToPoint(ctx, currentSize.width - _arcRadius, currentSize.height);
    //绘制二次贝塞尔曲线，控制点为矩形的右下角点坐标，当前最后一次指定的点将要连接的目标点
    CGContextAddQuadCurveToPoint(ctx, currentSize.width, currentSize.height, currentSize.width, currentSize.height - _arcRadius);
    

    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}


//绘制左、右下角为圆角，顶部带耳朵
- (void)drawViewTopEar {
    
    //当前视图的size
    CGSize currentSize = self.frame.size;
    
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        
        //设置填充颜色
        CGContextSetFillColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条颜色
        //        CGContextSetStrokeColorWithColor(ctx, _fillColor.CGColor);
        //        //设置线条宽度
        //        CGContextSetLineWidth(ctx, 1);
    }
    
//    //指定当前的起始点
//    CGContextMoveToPoint(ctx, 0, _arcRadius * 2);
//    CGContextAddLineToPoint(ctx, currentSize.width/2, _arcRadius * 2);
//    CGContextAddLineToPoint(ctx, currentSize.width/2, currentSize.height);
//    CGContextAddLineToPoint(ctx, _arcRadius, currentSize.height);
//    //绘制二次贝塞尔曲线，控制点为矩形的左下角点坐标，当前最后一次指定的点将要连接的目标点
//    CGContextAddQuadCurveToPoint(ctx, 0, currentSize.height, 0, currentSize.height - _arcRadius);
//    
//    //指定当前的起始点
//    CGContextMoveToPoint(ctx, currentSize.width, currentSize.height - _arcRadius);
//    CGContextAddLineToPoint(ctx, currentSize.width, _arcRadius * 2);
//    CGContextAddLineToPoint(ctx, currentSize.width/2, _arcRadius * 2);
//    CGContextAddLineToPoint(ctx, currentSize.width/2, currentSize.height);
//    CGContextAddLineToPoint(ctx, currentSize.width - _arcRadius, currentSize.height);
//    //绘制二次贝塞尔曲线，控制点为矩形的右下角点坐标，当前最后一次指定的点将要连接的目标点
//    CGContextAddQuadCurveToPoint(ctx, currentSize.width, currentSize.height, currentSize.width, currentSize.height - _arcRadius);
    
    
    //指定当前的起始点
    CGContextMoveToPoint(ctx, 0, _arcRadius * 2);
    CGContextAddLineToPoint(ctx, 0, currentSize.height - _arcRadius);
//    CGContextAddArc(ctx, 0, currentSize.height, _arcRadius, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#int clockwise#>)
    CGContextAddArcToPoint(ctx, 0, currentSize.height, _arcRadius, currentSize.height, _arcRadius);
    
    CGContextAddLineToPoint(ctx, currentSize.width - _arcRadius, currentSize.height);
    CGContextAddArcToPoint(ctx, currentSize.width, currentSize.height, currentSize.width, currentSize.height - _arcRadius, _arcRadius);
    
    CGContextAddLineToPoint(ctx, currentSize.width, _arcRadius * 2);
    CGContextAddLineToPoint(ctx, 0, _arcRadius * 2);
    NSLog(@"hei   do   me");
    
    
    CGContextMoveToPoint(ctx, currentSize.width/2 - _arcRadius * 3, _arcRadius * 2);
    CGContextAddLineToPoint(ctx, currentSize.width/2 - _arcRadius, _arcRadius * 2);
    CGContextAddQuadCurveToPoint(ctx, currentSize.width/2 - _arcRadius * 2, 0, currentSize.width/2 - _arcRadius * 3, _arcRadius * 2);
    
    CGContextMoveToPoint(ctx, currentSize.width/2 + _arcRadius, _arcRadius * 2);
    CGContextAddLineToPoint(ctx, currentSize.width/2 + _arcRadius * 3, _arcRadius * 2);
    CGContextAddQuadCurveToPoint(ctx, currentSize.width/2 + _arcRadius * 2, 0, currentSize.width/2 + _arcRadius, _arcRadius * 2);
    
    
    //形成闭合路径
    CGContextClosePath(ctx);
    
    //如果没有指定背景图片
    if (_fillImage == nil) {
        //绘制图形（路径）
        CGContextDrawPath(ctx, kCGPathFill);
        
    }else{
        //注意：裁切范围（也就是指定剪切的方法一定要在绘制范围之前进行调用）
        CGContextClip(ctx);
        [_fillImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}




#pragma mark - 设置方法区

/**
 绘制当前视图为椭圆
 
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawEllipseWithFillImage:(UIImage *)fillImage
                     orFillColor:(UIColor *)fillColor {
    
    _currentGraphicsViewType = BYGraphicsViewTypeEllipse;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}

/**
 绘制右下角圆弧
 
 @param arcRadius 圆弧的半径
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawLowerRightArcWithRadius:(float)arcRadius
                          fillImage:(UIImage *)fillImage
                        orFillColor:(UIColor *)fillColor {
   
    _currentGraphicsViewType = BYGraphicsViewTypeLowerRightArc;
    _arcRadius = arcRadius;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}

/**
 绘制底部圆弧
 
 @param arcRadius 圆弧半径
 @param fillImage 指定的填充图片
 @param fillColor 指定的填充色
 */
- (void)drawBottomArcWithRadius:(float)arcRadius
                      fillImage:(UIImage *)fillImage
                    orFillColor:(UIColor *)fillColor {
    
    _currentGraphicsViewType = BYGraphicsViewTypeBottomArc;
    _arcRadius = arcRadius;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}

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
                             orFillColor:(UIColor *)fillColor {
    
    _currentGraphicsViewType = BYGraphicsViewTypeTopTriangle;
    _triangleWidth = width;
    _triangleHeight = height;
    _triangleOffsetX = offsetX;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}

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
                                orFillColor:(UIColor *)fillColor {
    
    _currentGraphicsViewType = BYGraphicsViewTypeBottomTriangle;
    _triangleWidth = width;
    _triangleHeight = height;
    _triangleOffsetX = offsetX;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}


- (void)drawLowerLeftRightArcWithRadius:(float)arcRadius
                          fillImage:(UIImage *)fillImage
                        orFillColor:(UIColor *)fillColor {
    
    _currentGraphicsViewType = BYGraphicsViewTypeLowerLeftRightArc;
    _arcRadius = arcRadius;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}


- (void)drawLowerLeftRightArcTopEarWithRadius:(float)arcRadius
                              fillImage:(UIImage *)fillImage
                            orFillColor:(UIColor *)fillColor {
    
    _currentGraphicsViewType = BYGraphicsViewTypeTopEar;
    _arcRadius = arcRadius;
    _fillImage = fillImage;
    _fillColor = fillColor;
    
    //重绘视图
    [self setNeedsDisplay];
}


@end
