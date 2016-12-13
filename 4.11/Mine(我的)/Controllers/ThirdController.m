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
#import "QLExplosionView.h" //点击按钮爆炸效果
#import "QLSnowView.h" //爱心粒子


@implementation ThirdController
{
    QLExplosionView *_explosionView;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // 粒子动画
    [self addSnowFlow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createUI];
    
}

- (void)createUI
{
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
 * 粒子动画
 */
- (void)addSnowFlow
{
    QLSnowView *snowView = [[QLSnowView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [self.view addSubview:snowView];
}


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


@end
