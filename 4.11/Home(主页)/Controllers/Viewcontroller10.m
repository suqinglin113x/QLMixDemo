//
//  Viewcontroller10.m
//  4.11
//
//  Created by SU on 16/8/8.
//  Copyright © 2016年 SU. All rights reserved.
//


/**
 *      发短信 
 */

#import "Viewcontroller10.h"
#import <MessageUI/MessageUI.h>

/**
 *  发短信原生库: MessageUI.framework
 */


@interface Viewcontroller10() <MFMessageComposeViewControllerDelegate>

@end

@implementation Viewcontroller10 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showSMS];
    
}

- (void)showSMS
{
    Class messageClass = NSClassFromString(@"MFMessageComposeViewController");
    if (messageClass == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"ios版本过低，ios4.0以上才支持程序内发送短信"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"关闭", nil];
        [alert show];
        return;
    }
    if ([messageClass canSendText])
    {
        [self displaySMSView];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


- (void)displaySMSView
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    //设置委托
    picker.messageComposeDelegate = self;
    //设置信息内容
    picker.body = @"您好，您的话费余额不足";
    //收件人
    picker.recipients = [NSArray arrayWithObjects:@"13693655135",@"15725801075", nil];
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

//代理
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
            break;
        case MessageComposeResultSent:
            NSLog(@"发送成功");
            break;
            
        default:
            break;
    }
    
}



@end
