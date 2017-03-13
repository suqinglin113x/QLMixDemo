//
//  ThirdController.m
//  4.11
//
//  Created by SU on 16/9/9.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ThirdController.h"
#import "QLScanViewController.h"
#import "QLWebJSController.h"
#import "QLSnowController.h"
#import "PopoverView.h" // 菜单
#import "QLExplosionView.h" //点击按钮爆炸效果


@implementation ThirdController
{
    QLExplosionView *_explosionView;
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    // 右侧加好➕
    UIButton *btn = [QLViewCreateTool createButtonWithFrame:CGRectMake(0, 0, 30, 30) title:nil target:self sel:@selector(rightBtnClick:)];
    [btn setBackgroundImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self createUI];
    
}

- (void)createUI
{
    //  赞👍按钮
    UIButton  *goodBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(KScreenSize.width - 50, 100, 30, 30) title:nil target:self sel:@selector(goodBtnClick:)];
    goodBtn.backgroundColor = [UIColor clearColor];
    [goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    [self.view addSubview:goodBtn];
    

    UIButton *settingBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 70, 150, 30) title:@"点我到系统设置" target:self sel:@selector(toSystemSetting)];
    [self.view addSubview:settingBtn];
    QLExplosionView *explosionView = [[QLExplosionView alloc]initWithFrame:settingBtn.bounds];
    [settingBtn insertSubview:explosionView atIndex:0];
    _explosionView = explosionView;
    
    UIButton *scanBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 110, 150, 30) title:@"点我到扫描" target:self sel:@selector(toScan)];
    [self.view addSubview:scanBtn];
    
    UIButton *JSBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 150, 150, 30) title:@"点我到JS" target:self sel:@selector(toJSweb)];
    [self.view addSubview:JSBtn];
    
    UIButton *snowBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 200, 150, 30) title:@"点我到下雪" target:self sel:@selector(toSnow)];
    [self.view addSubview:snowBtn];
    
    
}

/**
 *  到下雪页面
 */
- (void)toSnow
{
    QLSnowController *snowVC = [[QLSnowController alloc] init];
    snowVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:snowVC animated:YES];
}

/**
 *  到JS页面
 */
- (void)toJSweb
{
    QLWebJSController *webJSVC = [[QLWebJSController alloc] init];
    webJSVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webJSVC animated:YES];
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
 *  点赞 action
 */
- (void)goodBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.isSelected) {
        
        //法一：抖动效果
        CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
        shakeAnimation.duration = 0.2;
        shakeAnimation.values = @[@0, @(-0.2), @0.2, @0];
        shakeAnimation.repeatCount = 2;
        [btn.layer addAnimation:shakeAnimation forKey:nil];
        
        [btn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateSelected];
        QLExplosionView *exploV = [[QLExplosionView alloc] initWithFrame:btn.bounds];
        [btn addSubview:exploV];
        [exploV animate];
        
        UILabel *amountLab = [QLViewCreateTool createLabelWithFrame:CGRectMake(10, -15, 20, 20) title:@"+1" bgColor:[UIColor redColor] textColor:[UIColor blackColor]];
        amountLab.alpha = 0;
        [btn addSubview:amountLab];
        [UIView animateWithDuration:1.0 animations:^{
            amountLab.alpha = 1;
            amountLab.layer.affineTransform = CGAffineTransformMakeTranslation(0, -10);
        } completion:^(BOOL finished) {
            
            amountLab.alpha = 0;
            [amountLab  removeFromSuperview];
        }];
        
    }else {
        [btn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}

/**
 *  弹出菜单
 */
- (void)rightBtnClick:(UIButton *)btn
{
    PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_newmessage"] title:@"发起群聊" handler:^(PopoverAction *action) {
    }];
    PopoverAction *action2 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_friend"] title:@"添加朋友" handler:^(PopoverAction *action) {
    }];
    PopoverAction *action3 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_scan"] title:@"扫一扫" handler:^(PopoverAction *action) {
    }];
    PopoverAction *action4 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_money"] title:@"收付款" handler:^(PopoverAction *action) {
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    // 在没有系统控件的情况下调用可以使用显示在指定的点坐标的方法弹出菜单控件.
    [popoverView showToView:btn withActions:@[action1, action2, action3, action4]];
}
@end
