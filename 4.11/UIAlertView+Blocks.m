//
//  UIAlertView+Blocks.m
//  4.11
//
//  Created by SU on 16/8/17.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "UIAlertView+Blocks.h"

static DismissBlock _dismissBlock;
static CancleBlock _cancleBlock;


@implementation UIAlertView (Blocks) 



+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                       otherButtonTitle:(NSString *)otherButtonTitle
{
    NSArray *buttons;
    if (otherButtonTitle) {
        buttons = @[otherButtonTitle];
    }
    else{
        buttons = [NSArray array];
    }
    UIAlertView *alert = [UIAlertView  showAlertViewWithTitle:title
                                                      message:message
                                            cancleButtonTitle:cancleButtonTitle otherButtonTitles:buttons
                                                     onCancle:nil
                                                    onDismiss:nil];
    return alert;
}

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                       otherButtonTitle:(NSString *)otherButtonTitle
                               onCancle:(CancleBlock)cancled
                              onDismiss:(DismissBlock)dismissed
{
    NSArray *buttons;
    if (otherButtonTitle) {
        buttons = @[otherButtonTitle];
    }
    else{
        buttons = [NSArray array];
    }
    UIAlertView *alert = [UIAlertView showAlertViewWithTitle:title
                                                     message:message
                                           cancleButtonTitle:cancleButtonTitle otherButtonTitles:buttons
                                                    onCancle:nil
                                                   onDismiss:nil];
    return alert;
}

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
{
    UIAlertView *alert = [UIAlertView showAlertViewWithTitle:title
                                                     message:message
                                           cancleButtonTitle:cancleButtonTitle
                                           otherButtonTitles:otherButtonTitles
                                                    onCancle:nil
                                                   onDismiss:nil];
    return  alert;
}

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
                               onCancle:(CancleBlock)cancled
                              onDismiss:(DismissBlock)dismissed
{
    if (cancled) {
        _cancleBlock = [cancled copy];
    }
    if (dismissed) {
        _dismissBlock = [dismissed copy];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancleButtonTitle otherButtonTitles:nil];
    
    for (NSString *buttonTitle in otherButtonTitles) {
        [alert addButtonWithTitle:buttonTitle];
    }
    [alert show];
    return alert;
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex]) {
        if (_cancleBlock) {
            _cancleBlock();
        }
    }
    else {
        if (_dismissBlock) {
            _dismissBlock((int)(buttonIndex )); // cancel button is button 0
        }
    }  
}
@end
