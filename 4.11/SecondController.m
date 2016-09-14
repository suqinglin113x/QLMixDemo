//
//  SecondController.m
//  4.11
//
//  Created by SU on 16/9/9.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SecondController.h"
#import "ADViewController.h"
#import "SEViewController1.h"

@implementation SecondController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //启动页中的广告的点击通知监听，
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAdVC:) name:@"tapAction" object:nil];
    
    [self createUI];
}


- (void)createUI
{
    UIButton *tableViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = [QLCommonMethod calculateStrRect:@"点我到TableView"];
    
    tableViewBtn.frame = CGRectMake(10, 70, 150, 30);
    tableViewBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
    tableViewBtn.layer.cornerRadius = 4.f;
    [tableViewBtn setTitle:@"点我到TableView" forState:UIControlStateNormal];
    tableViewBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [tableViewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tableViewBtn addTarget:self action:@selector(toTableView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableViewBtn];
}

/**
 *  到tableView页面
 */

- (void)toTableView
{
    SEViewController1 *seVc1 = [[SEViewController1 alloc] init];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:seVc1 animated:YES];
}

- (void)pushToAdVC:(NSNotification *)noti
{
    
    ADViewController *adVc = [[ADViewController alloc] init];
    adVc.urlString =noti.object;
    adVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adVc animated:YES];
}
@end
