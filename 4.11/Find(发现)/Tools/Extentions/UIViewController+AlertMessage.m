//
//  UIViewController+AlertMessage.m
//  4.11
//
//  Created by SU on 16/11/10.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "UIViewController+AlertMessage.h"

@implementation UIViewController (AlertMessage)
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handle{

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handle];
    
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
    
   
}
@end
