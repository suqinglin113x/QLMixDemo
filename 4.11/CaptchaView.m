//
//  CaptchaView.m
//  4.11
//
//  Created by SU on 16/8/19.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "CaptchaView.h"

#define kRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define kLineCount 6
#define kLineWidth 1.0
#define kCharCount 6
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation CaptchaView
@synthesize changeArray, changeString;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = kRandomColor;
        self.layer.masksToBounds = YES;
        
        [self changeCaptcha];
    }
    return self;
}

#pragma mark --- 更换验证码
- (void)changeCaptcha
{
    //
    self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:kCharCount];
    self.changeString = [[NSMutableString alloc] initWithCapacity:kCharCount];
    
    //随机从数组中选取需要个数的字符，然后拼接成一个字符串
    for (int i = 0 ; i < kCharCount; i ++) {
        NSInteger index = arc4random() % (self.changeArray.count - 1);
        getStr = [self.changeArray objectAtIndex:index];
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
    }
}

#pragma mark  点击view时调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self changeCaptcha];
    //setNeedsDisplay 调用drawRect方法来实现view的绘制
    [self setNeedsDisplay];
}

#pragma mark 绘制界面
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = kRandomColor;
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
}



@end
