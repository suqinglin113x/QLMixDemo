//
//  SecondController.m
//  4.11
//
//  Created by SU on 16/9/9.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SecondController.h"
#import "ADViewController.h"
#import "QLSearchController.h"
#import "SEViewController1.h" //Collection
#import "SViewController2demo1.h" //
#import "SViewControllerDemo2.h"//瀑布流
#import "QLDownloadFileController.h"
#import "QLUploadFileController.h"
#import "QLMapLocationController.h"
#import "QLNormalScrollController.h"


#import "QLTextField.h"

@interface SecondController ()<UISearchBarDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SecondController

- (void)viewWillAppear:(BOOL)animated
{
    // view添加浮动动画
    [self setBtnAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick)];
    
    
    //启动页中的广告的点击通知监听，
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAdVC:) name:@"tapAction" object:nil];
    
    
    [self createUI];
    
    [self codeTests];
    
}


- (void)createUI
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(KScreenSize.width + 20, KScreenSize.height *1.2);
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.scrollView.directionalLockEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    
    UIButton *tableViewBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 10, 150, 30) title:@"点我到TableView" target:self sel:@selector(toTableView)];
    tableViewBtn.tag = 101;
    [self.scrollView addSubview:tableViewBtn];
    QLLog(@"%@",tableViewBtn.currentTitle); //输出按钮文字 two ways
    QLLog(@"%@",tableViewBtn.titleLabel.text);
    
   
    UIButton *collectionBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 50, 150, 30) title:@"点我到Collection" target:self sel:@selector(toCollection)];
    [self.scrollView addSubview:collectionBtn];
    
    
    UIButton *fallBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 90, 150, 30)title:@"点我到瀑布流" target:self sel:@selector(toFall)];
    [self.scrollView addSubview:fallBtn];
    
    
    UIButton *downloadBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 130, 150, 30) title:@"点我到下载" target:self sel:@selector(toDownloadFile)];
    [self.scrollView addSubview:downloadBtn];

    UIButton *uploadBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 170, 150, 30) title:@"点我到上传" target:self sel:@selector(toUploadFile)];
    [self.scrollView addSubview:uploadBtn];
    
    UIButton *mapBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 210, 150, 30) title:@"点我到地图定位" target:self sel:@selector(toMapLocation)];
    [self.scrollView addSubview:mapBtn];
    
    UIButton *scrollBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 250, 150, 30) title:@"点我到轮播图" target:self sel:@selector(toMaxScroll)];
    [self.scrollView addSubview:scrollBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 80, 70, 70)];
    imageView.image = [[UIImage imageNamed:@"emoji1.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    imageView.layer.cornerRadius = 70/2;
    imageView.tag = 100;
    imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [UIColor colorWithRed:0.99f green:0.89f blue:0.49f alpha:1.00f];
    [self.scrollView addSubview:imageView];
    
    

}
/**
 *  到搜索页面
 */
- (void)searchClick
{
    QLSearchController *searchVC = [[QLSearchController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
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
 * 到地图定位
 */
- (void)toMapLocation
{
    QLMapLocationController *mapLocationVC = [[QLMapLocationController alloc] init];
    mapLocationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapLocationVC animated:YES];
}

/**
 * 到轮播图
 */
- (void)toMaxScroll
{
    QLNormalScrollController *normalScrollVC = [[QLNormalScrollController alloc] init];
//    maxScrollVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:normalScrollVC animated:YES];
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


/**
 * 按钮添加动画
 */
- (void)setBtnAnimation
{
    
    if (currentSystemVersion <= 9.0) {
        UIImageView *view = (UIImageView *)[_scrollView viewWithTag:100];
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;
        pathAnimation.fillMode = kCAFillModeForwards;
        
        pathAnimation.repeatCount = MAXFLOAT;
        pathAnimation.autoreverses = YES; //
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnimation.duration = arc4random()% 5 + 5;
        
        //圆path
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(view.frame, view.frame.size.width / 2 - 10, view.frame.size.width / 2 - 10)];
        pathAnimation.path = path.CGPath;
        [view.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    }else{
    
#warning 不知道为啥真机ios8.3下按钮部分动画失效。待解决.......
    
        for(UIView *view in _scrollView.subviews)
        {
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.calculationMode = kCAAnimationPaced;
            pathAnimation.fillMode = kCAFillModeForwards;
            
            pathAnimation.repeatCount = MAXFLOAT;
            pathAnimation.autoreverses = YES; //
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            pathAnimation.duration = arc4random()% 5 + 5;
            
            //圆path
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(view.frame, view.frame.size.width / 2 - 10, view.frame.size.width / 2 - 10)];
            pathAnimation.path = path.CGPath;
            [view.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
            
            //缩放
            CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
            scaleX.values = @[@1.0,@1.1,@1.0];
            scaleX.keyTimes = @[@0.0,@0.5,@1.0];
            scaleX.repeatCount = MAXFLOAT;
            scaleX.autoreverses = YES; //
            scaleX.duration = arc4random()% 5 + 5;
            [view.layer addAnimation:scaleX forKey:@"transform..scale.x"];
            
            CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
            scaleY.values = @[@1.0, @1.1, @1.0];
            scaleY.keyTimes = @[@0.0, @0.5, @1.0];
            scaleY.repeatCount = MAXFLOAT;
            scaleY.autoreverses = YES;
            scaleY.duration = arc4random()% 5 + 5;
            [view.layer addAnimation:scaleY forKey:@"transform.scale.y"];
        }
    }
}



#pragma mark ----codeTests-----
- (void)codeTests
{
    NSString *testString = @"🌹哈哈haha🌹";
    for (int i = 0; i < testString.length;i++) {    //类比于swift的字符串打印字符
        unichar ch = [testString characterAtIndex:i];
        QLLog(@"%c", ch);
    }
    
    NSNumber *num1 = [NSNumber numberWithInteger:1];
    NSMutableArray  *array;
    [array addObject:num1];
    [num1 compare:num1];
    
}

@end
