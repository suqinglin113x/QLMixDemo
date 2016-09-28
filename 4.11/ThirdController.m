//
//  ThirdController.m
//  4.11
//
//  Created by SU on 16/9/9.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ThirdController.h"

@implementation ThirdController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createUI];
    
}

- (void)createUI
{
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(10, 70, 150, 30);
    settingBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
    settingBtn.layer.cornerRadius = 4.f;
    [settingBtn setTitle:@"点我到系统设置" forState:UIControlStateNormal];
    settingBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [settingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(toSystemSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
}

- (void)toSystemSetting
{
    QLLog(@"跳转到设置");
    
    // ios 10 之前
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    
    
    // ios 10
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil]; //传空字典
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
    
}
@end
