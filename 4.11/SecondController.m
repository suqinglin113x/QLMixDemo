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
#import "SViewController2demo1.h"
#import "SViewControllerDemo2.h"


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
    tableViewBtn.frame = CGRectMake(10, 70, 150, 30);
    tableViewBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
    tableViewBtn.layer.cornerRadius = 4.f;
    [tableViewBtn setTitle:@"点我到TableView" forState:UIControlStateNormal];
    tableViewBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [tableViewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tableViewBtn addTarget:self action:@selector(toTableView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableViewBtn];
    QLLog(@"%@",tableViewBtn.currentTitle); //输出按钮文字 two ways
    QLLog(@"%@",tableViewBtn.titleLabel.text);
    
    
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
    collectionBtn.layer.cornerRadius = 4.f;
    collectionBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    collectionBtn.frame = CGRectMake(10, 110, 150, 30);
    [collectionBtn setTitle:@"点我到Collection" forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(toCollection) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionBtn];
    
    UIButton *fallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fallBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
    fallBtn.layer.cornerRadius = 4.f;
    fallBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    fallBtn.frame = CGRectMake(10, 150, 150, 30);
    [fallBtn setTitle:@"点我到瀑布流" forState:UIControlStateNormal];
    [fallBtn addTarget:self action:@selector(toFall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fallBtn];
    
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
/**
 *  到collection页面
 */
- (void)toCollection
{
    SViewController2demo1 *demo1 = [[SViewController2demo1 alloc] init];
//    demo1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:demo1 animated:YES];
}

/**
 *  到瀑布流页面
 */
- (void)toFall
{
    SViewControllerDemo2 *demo2 = [[SViewControllerDemo2 alloc] init];
    demo2.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:demo2 animated:YES];
    
}
- (void)pushToAdVC:(NSNotification *)noti
{
    
    ADViewController *adVc = [[ADViewController alloc] init];
    adVc.urlString =noti.object;
    adVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adVc animated:YES];
}


@end
