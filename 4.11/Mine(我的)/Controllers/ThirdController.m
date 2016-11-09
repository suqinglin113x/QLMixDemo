//
//  ThirdController.m
//  4.11
//
//  Created by SU on 16/9/9.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ThirdController.h"
#import "QLScanViewController.h"



@implementation ThirdController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createUI];
    
}

- (void)createUI
{

    UIButton *settingBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 70, 150, 30) title:@"点我到系统设置" target:self sel:@selector(toSystemSetting)];
    [self.view addSubview:settingBtn];
    
    
    UIButton *scanBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 110, 150, 30) title:@"点我到扫描" target:self sel:@selector(toScan)];
    [self.view addSubview:scanBtn];
    
    
}

/**
 *  到设置页面
 */
- (void)toSystemSetting
{
    QLLog(@"跳转到设置");
    
    // ios 10 之前
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    
    
    // ios 10
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil]; //传空字典
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
    
}

/**
 *  到扫描页面
 */
- (void)toScan
{
    QLScanViewController *scanVC = [[QLScanViewController alloc] init];
    scanVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanVC animated:YES];
}


@end
