//
//  view1.m
//  4.11
//
//  Created by SU on 16/7/26.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "view1.h"
#import <QuartzCore/CoreAnimation.h>


@implementation view1

- (void)drawRect:(CGRect)rect
{
    
}
-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 64, 375, 300);
        self.name = @"xiaoming";
    }
    return self;
    
}
- (NSString *)description
{
    
    return @"";
}

/**
 *  高斯模糊
 */
- (void)createGaussianBlur
{
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    [self addSubview:slider];
    [slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    slider.maximumValue = 1.f;
    slider.minimumValue = 0.f;
    slider.thumbTintColor = [UIColor redColor];
    slider.maximumTrackTintColor = [UIColor greenColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    

    
}

- (void)valueChange:(UISlider *)slider
{
    
    QLLog(@"fdsfs");
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"2"]];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:2 * slider.value] forKey:@"inputRadius"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef  cgref = [context createCGImage:result fromRect:[result extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgref];
    CGImageRelease(cgref);
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.userInteractionEnabled = YES;
    [imageview insertSubview:slider aboveSubview:self];
    
    [self addSubview:imageview];
}

- (void)initRectLayer
{
    CALayer *rectLayer = [[CALayer alloc] init];
    rectLayer.cornerRadius = 15;
    rectLayer.frame = CGRectMake(15, 200, 30, 30);
    rectLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:rectLayer];
    
    CAKeyframeAnimation *rectRunAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置关键帧位置，必须含起始与终止
    rectRunAnimation.values = @[[NSValue valueWithCGPoint:rectLayer.frame.origin],
                                [NSValue valueWithCGPoint:CGPointMake(320 - 15, rectLayer.frame.origin.y)],
                                [NSValue valueWithCGPoint:CGPointMake(320 -55, rectLayer.frame.origin.y + 100)],
                                [NSValue valueWithCGPoint:CGPointMake(15, rectLayer.frame.origin.y + 100)],
                                [NSValue valueWithCGPoint:rectLayer.frame.origin]];
    rectRunAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:0.6],
                                 [NSNumber numberWithFloat:0.7],
                                  [NSNumber numberWithFloat:0.8],
                                 [NSNumber numberWithFloat:1.0]];
    rectRunAnimation.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    rectRunAnimation.repeatCount = MAXFLOAT;
    rectRunAnimation.duration = 4.f;
//    rectRunAnimation.calculationMode = kCAAnimationLinear;
    [rectLayer addAnimation:rectRunAnimation forKey:@"rectRunAnimation"];
    
}


/***********************分割线*******************/

/**
 *  注释
 3）keyTimes属性
 
 该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(5-1)，即每条子路径的duration相等，都为duration的1\4。当然，我们也可以传个数组让物体快慢结合。例如，你可以传入{0.0, 0.1,0.6,0.7,1.0}，其中首尾必须分别是0和1，因此tAB=0.1-0, tCB=0.6-0.1, tDC=0.7-0.6, tED=1-0.7.....
 
 （4）timeFunctions属性
 
 用过UIKit层动画的同学应该对这个属性不陌生，这个属性用以指定时间函数，类似于运动的加速度，有以下几种类型。上例子的AB段就是用了淡入淡出效果。记住，这是一个数组，你有几个子路径就应该传入几个元素
 
 1 kCAMediaTimingFunctionLinear//线性
 2 kCAMediaTimingFunctionEaseIn//淡入
 3 kCAMediaTimingFunctionEaseOut//淡出
 4 kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
 5 kCAMediaTimingFunctionDefault//默认
 （5）calculationMode属性
 
 该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
 
 1 const kCAAnimationLinear//线性，默认
 2 const kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
 3 const kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
 4 const kCAAnimationCubic//平均，同上
 5 const kCAAnimationCubicPaced//平均，同上
 */

@end
