//
//  QLViewCreateTool.m
//  4.11
//
//  Created by SU on 16/10/25.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLViewCreateTool.h"

@implementation QLViewCreateTool

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target sel:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = defaultColor;
    btn.layer.cornerRadius = 10.f;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
