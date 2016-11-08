//
//  UIImage+Category.h
//  4.11
//
//  Created by SU on 16/7/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+ (UIImage *)xh_imageNamed:(NSString *)name;


// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
