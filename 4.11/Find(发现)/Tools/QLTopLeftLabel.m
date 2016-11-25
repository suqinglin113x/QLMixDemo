//
//  QLTopLeftLabel.m
//  4.11
//
//  Created by SU on 16/11/18.
//  Copyright © 2016年 SU. All rights reserved.
//

/**
    重写下面方法，在调用super之前重绘rect
    文字显示在左上角
 */

#import "QLTopLeftLabel.h"

@implementation QLTopLeftLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.origin.y = bounds.origin.y + 5;
    textRect.origin.x = bounds.origin.x + 5;
    return textRect;
}
- (void)drawTextInRect:(CGRect)rect
{
    CGRect actRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actRect];
}

@end
