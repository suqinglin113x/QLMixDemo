//
//  MBProgressHUD+ShowMessage.m
//  Pods
//
//  Created by SU on 16/9/13.
//
//

#import "MBProgressHUD+ShowMessage.h"

@implementation MBProgressHUD (ShowMessage)
+ (void)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    //快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //设置大小
    hud.minSize = CGSizeMake(150, 60);
    
    //设置lable
    hud.label.text = message;
    hud.label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.f];
    
    //设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    //隐藏时从父控件移除
    hud.removeFromSuperViewOnHide = YES;
    
    //移除方式
    hud.animationType = MBProgressHUDAnimationZoomIn;
    
    //一秒后消失
    [hud hideAnimated:YES afterDelay:1.3f];
    
}
@end
