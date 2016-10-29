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
@end
