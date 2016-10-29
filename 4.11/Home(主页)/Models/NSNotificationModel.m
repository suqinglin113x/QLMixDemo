//
//  NSNotification.m
//  4.11
//
//  Created by SU on 16/9/6.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "NSNotificationModel.h"

@implementation NSNotificationModel

- (void)addNotification
{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleKeyboardWillShow:(NSNotification *)notification
{
    NSLog(@"键盘即将出现");
    NSValue *value = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardH = keyboardRect.size.height;
    NSLog(@"键盘高度：%f",keyboardH);
    /*transform the view's frame
     ...
     
     */
}
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    
    NSLog(@"键盘即将隐藏");
    /*transform the view to identity.
    ...
     
    */
}
@end
