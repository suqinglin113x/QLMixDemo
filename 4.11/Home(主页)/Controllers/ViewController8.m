//
//  ViewController8.m
//  4.11
//
//  Created by SU on 16/8/2.
//  Copyright © 2016年 SU. All rights reserved.
//
/**
 *  指纹
 *
 */

#import "ViewController8.h"
//导入库文件
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController8 ()
@property (nonatomic, strong)UISwitch *switchBtn;
@end

@implementation ViewController8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _switchBtn = [[UISwitch alloc] init];
    [_switchBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlStateSelected];
    _switchBtn.frame = CGRectMake(30, 50, 0, 0);
    [self.view addSubview:_switchBtn];
    
}

- (void)click:(UISwitch *)sender
{
    if (sender.on) {
        NSLog(@"打开状态");
        [self checkTouchId];
        
    }else{
        NSLog(@"关闭状态");
    }
    
}

- (void)checkTouchId
{
    LAContext *context = [[LAContext alloc] init];
    NSError *err = nil;
    context.localizedFallbackTitle = @"我是可修改的";//修改系统“输入密码”
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&err]) {
        
       [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请通过Home键验证指纹" reply:^(BOOL success, NSError * _Nullable error) {
           if (success) {
               NSLog(@"设置指纹成功");
               dispatch_async(dispatch_get_main_queue(), ^{
                   //关闭其他的密码（手势密码）
                   
               });
           }else{
               NSString *errorStr = error.localizedDescription;
               if ([errorStr isEqualToString:@""]) {
                   
                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"" otherButtonTitles:@"", nil];
                   alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
               }
               switch (error.code) {
                   case LAErrorUserFallback:
                   {
                       
                   }
                       break;
                       
                   default:
                       break;
               }
           }
       }];
        
    }
}

- (void)inputTouchId
{
    NSDictionary *query = @{
                            (__bridge id)kSecClass:(__bridge id)kSecClassInternetPassword,
                            (__bridge id)kSecAttrService:@"sampleService"
                            
                            };
}







- (void)transCFStringAndNSString
{
    CFStringRef cfStr = CFStringCreateWithCString(NULL, "test", kCFStringEncodingASCII);
    NSString *aNSString = (__bridge NSString *)cfStr;
    
    CFStringRef aCFString = (__bridge CFStringRef)aNSString;
    
}
@end
