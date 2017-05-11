//
//  QLMacro.h
//  4.11
//
//  Created by 苏庆林 on 17/5/10.
//  Copyright © 2017年 SU. All rights reserved.
//

#ifndef QLMacro_h
#define QLMacro_h



/****           宏定义         ****/

#define KScreenSize [[UIScreen mainScreen] bounds].size
#define adoptValue(a) ((KScreenSize.width/375.0) * a)
#define defaultColor [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6]
#define defaultFontTextColor [UIColor greenColor]
#define currentSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

/****           常量区         ****/
static const CGFloat defaultCornerRadius = 10.f;
static const CGFloat defaultFontSize = 15.f;



#ifdef DEBUG

//参数：打印在哪个方法，哪一行
# define QLLog(fmt, ...)  NSLog((@"%s [Line %d] " fmt),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define  QL__Func__ NSLog(@"%s", __func__)
//ios 10 之后
//#define QLLog(...) printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else

#define QLLog(...)
#endif

#endif /* QLMacro_h */
