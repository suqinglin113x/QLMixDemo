//
//  核心绘图.m
//  4.11
//
//  Created by SU on 16/5/10.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "核心绘图.h"

@implementation ____

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext(); //拿到当前被准备的画板
    
    CGContextBeginPath(ref); //概念 路径Path ，告诉画板 环境， 要开始画了
    
    CGContextMoveToPoint(ref, 0, 0); //两点确定一条直线
    
    CGContextStrokePath(ref); //告诉画板，对我移动的路径用画笔画一下
    
    
    CGGradientRef myGradient;
    CGColorSpaceRef myColorSpace;
    size_t locationCount = 3;
    CGFloat location[] = {0.0,0.1,1.0};
    CGFloat colorlist[] = {
        1.0,0.0,0.5,1.0, //red,green,blue,alpha
        1.0,0.0,1.0,1.0,
        0.3,0.5,1.0,1.0
    };
    myGradient = CGGradientCreateWithColorComponents(myColorSpace, colorlist, location, locationCount); //核心函数，要搞清渐变一些量化的东西
    myColorSpace  = CGColorSpaceCreateDeviceRGB();
    
    CGPoint startPoint , endPoint;
    startPoint.x = 0;
    startPoint.y = 0;
    endPoint.x = CGRectGetMaxX(self.bounds);
    endPoint.y = CGRectGetMaxY(self.bounds);
    CGContextDrawLinearGradient(ref, myGradient, startPoint, endPoint, 0); //这是绘图的，你可以通过裁剪来完成特定形状的过滤
    CGColorSpaceRelease(myColorSpace);
    CGGradientRelease(myGradient);
}
@end
