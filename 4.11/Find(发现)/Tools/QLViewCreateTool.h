//
//  QLViewCreateTool.h
//  4.11
//
//  Created by SU on 16/10/25.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLViewCreateTool : NSObject

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target sel:(SEL)selector;

+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor;

@end
