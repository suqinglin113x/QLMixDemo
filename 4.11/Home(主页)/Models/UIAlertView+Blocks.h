//
//  UIAlertView+Blocks.h
//  4.11
//
//  Created by SU on 16/8/17.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancleBlock)();


@interface UIAlertView (Blocks)<UIAlertViewDelegate>


+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                       otherButtonTitle:(NSString *)otherButtonTitle;

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                       otherButtonTitle:(NSString *)otherButtonTitle
                               onCancle:(CancleBlock)cancled
                              onDismiss:(DismissBlock)dismissed;

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles;

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                      cancleButtonTitle:(NSString *)cancleButtonTitle
                      otherButtonTitles:(NSArray *)otherButtonTitles
                               onCancle:(CancleBlock)cancled
                              onDismiss:(DismissBlock)dismissed;


@end
