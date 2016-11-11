//
//  UIViewController+AlertMessage.h
//  4.11
//
//  Created by SU on 16/11/10.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertMessage)
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void(^)(UIAlertAction *action))handle;
@end
