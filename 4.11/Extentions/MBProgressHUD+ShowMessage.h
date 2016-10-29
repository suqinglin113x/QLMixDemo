//
//  MBProgressHUD+ShowMessage.h
//  Pods
//
//  Created by SU on 16/9/13.
//
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ShowMessage)

+ (void)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showMessage:(NSString *)message;

@end
