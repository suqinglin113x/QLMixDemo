//
//  SecondController.m
//  4.11
//
//  Created by SU on 16/9/9.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SecondController.h"
#import "ADViewController.h"
#import "SEViewController1.h" //Collection
#import "SViewController2demo1.h" //
#import "SViewControllerDemo2.h"//瀑布流
#import "QLDownloadFileController.h"
#import "QLUploadFileController.h"


#import "QLTextField.h"

@interface SecondController ()<UISearchBarDelegate>

@end

@implementation SecondController

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //修改占位符位置 待fix
    searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 0);
}
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
    
    UIButton *tableViewBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 70, 150, 30) title:@"点我到TableView" target:self sel:@selector(toTableView)];
    [self.view addSubview:tableViewBtn];
    QLLog(@"%@",tableViewBtn.currentTitle); //输出按钮文字 two ways
    QLLog(@"%@",tableViewBtn.titleLabel.text);
    
   
    UIButton *collectionBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 110, 150, 30) title:@"点我到Collection" target:self sel:@selector(toCollection)];
    [self.view addSubview:collectionBtn];
    
    
    UIButton *fallBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 150, 150, 30)title:@"点我到瀑布流" target:self sel:@selector(toFall)];
    [self.view addSubview:fallBtn];
    
    
    UIButton *downloadBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 190, 150, 30) title:@"点我到下载" target:self sel:@selector(toDownloadFile)];
    [self.view addSubview:downloadBtn];

    UIButton *uploadBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 230, 150, 30) title:@"点我到上传" target:self sel:@selector(toUploadFile)];
    [self.view addSubview:uploadBtn];
    
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

/**
 * 到文件下载
 */
- (void)toDownloadFile
{
    QLDownloadFileController *downloadVC = [[QLDownloadFileController alloc] init];
    [downloadVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:downloadVC animated:YES];
}

/**
 * 到文件上传
 */
- (void)toUploadFile
{
    QLUploadFileController *uploadVC = [[QLUploadFileController alloc] init];
    uploadVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uploadVC animated:YES];
}


/**
 * 到广告页面
 */
- (void)pushToAdVC:(NSNotification *)noti
{
    
    ADViewController *adVc = [[ADViewController alloc] init];
    adVc.urlString =noti.object;
    adVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adVc animated:YES];
}


@end
