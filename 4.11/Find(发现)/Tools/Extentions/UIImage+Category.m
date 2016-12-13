//
//  UIImage+Category.m
//  4.11
//
//  Created by SU on 16/7/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

+ (UIImage *)xh_imageNamed:(NSString *)name{
    
    double version = [UIDevice currentDevice].systemVersion.doubleValue;
    if (version > 7.0) {
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage  xh_imageNamed:name];
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    //描述矩形
    CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
    
    //开启上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //渲染上下文
    CGContextFillRect(context, rect);
    //从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    
    return image;
}

/**屏幕截图*/
+ (instancetype)captureWithView:(UIView *)view
{
    //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    //2、将控制器的view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //3、取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4、结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
