//
//  QLTextField.m
//  4.11
//
//  Created by SU on 16/10/19.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLTextField.h"

@implementation QLTextField


//重写此方法实现placeholder的偏移
- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *placeholderColor = [UIColor redColor];//设置颜色
    [placeholderColor setFill];
    
    CGRect placeholderRect = CGRectMake(rect.origin.x+30, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize);//设置距离
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}


@end
