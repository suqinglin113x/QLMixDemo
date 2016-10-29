//
//  BezierPathView.m
//  4.11
//
//  Created by SU on 16/9/7.
//  Copyright © 2016年 SU. All rights reserved.
// ******UIBezierPath 贝塞尔 使用

#import "BezierPathView.h"
#define kViewWidth self.frame.size.width
#define kViewHeight self.frame.size.height

@implementation BezierPathView


- (void)drawRect:(CGRect)rect
{
    switch (_type) {
        case kDefaultPath:
        {
            [self drawTrianglePath];
            break;
        }
        case kRectPath:
        {
            [self drawRectPath];
            break;
        }
        case kCirclePath:
        {
            [self drawCirclePath];
            break;
        }
        case kOvalPath:
        {
            [self drawOvalPath];
            break;
        }
        case kRoundedRectPath:
        {
            [self drawRoundedRectPath];
            break;
        }
        case kArcPath:
        {
            [self drawArcPath];
            break;
        }
        case kSecondBezierpath:
        {
            [self drawSecondBezierPath];
            break;
        }
        case kThirdBezierPath:
        {
            [self drawThirdBezierPath];
            break;
        }
        default:
            break;
    }
}

//画三角形
- (void)drawTrianglePath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width - 40, 20)];
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20)];
    
    //最后的闭合线是可以通过closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //[path addLineToPoint:CGPointMake(20, 20)];
    
    [path closePath];
    
    //设置线宽
    path.lineWidth = 1.5;
    //设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    //设置画笔颜色
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    //根据我们设置的各个点连线
    [path stroke];
}

//画矩形
- (void)drawRectPath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, self.frame.size.width- 40, self.frame.size.height- 40)];
    path.lineWidth = 1.5;
    path.lineJoinStyle = kCGLineJoinBevel;
    path.lineCapStyle = kCGLineCapRound;
    //设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    //设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    //根据我们设置的各个点连线
    [path stroke];
    
}

//画圆
- (void)drawCirclePath
{
    //传的是正方形，所以可以绘制出圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40)];
    //设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    //设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    //根据我们设置的点连线
    [path stroke];
    
}

//画椭圆
- (void)drawOvalPath
{
    //传的不是正方形，因此就可以绘制出椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, self.frame.size.width - 80, self.frame.size.height - 40)];
    //设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    //设置画笔颜色
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    //根据我们设置连接各点
    [path stroke];
}

//带圆角矩形
- (void)drawRoundedRectPath
{
    //传的不是正方形，因此就可以绘制出椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, kViewWidth - 40, kViewHeight - 40) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    //设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    //设置画笔颜色
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    //根据我们设置连接各点
    [path stroke];
}

//画弧
#define kDegreesToRadious(degrees) (pi*(degrees/180))
- (void)drawArcPath
{
    const CGFloat pi = 3.14159265359;
    
    CGPoint center = CGPointMake(kViewWidth/2, kViewHeight/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:0 endAngle:kDegreesToRadious(60) clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];
}

//二次贝塞尔曲线
- (void)drawSecondBezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    //首先设置一个起点
    [path moveToPoint:CGPointMake(20, kViewHeight - 100)];
    //添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(kViewWidth - 20, kViewHeight - 100) controlPoint:CGPointMake(kViewWidth / 2, 0)];
    path.lineWidth = 5.0;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];
}

//三次贝塞尔曲线
- (void)drawThirdBezierPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(20, 150)];
    //添加三次曲线
    [path addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(60, 70) controlPoint2:CGPointMake(260, 70)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    [path stroke];
}
@end

