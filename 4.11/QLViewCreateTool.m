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
    btn.layer.cornerRadius = defaultCornerRadius;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:defaultFontTextColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:defaultFontSize];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = defaultFontTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:defaultFontSize];
    label.backgroundColor = defaultColor;
    label.layer.cornerRadius = defaultCornerRadius;
    label.layer.masksToBounds = YES;
    return label;
}

@end
