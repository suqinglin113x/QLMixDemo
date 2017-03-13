//
//  QLSnowController.m
//  4.11
//
//  Created by SU on 16/12/19.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLSnowController.h"
#import "QLSnowView.h" //下雪文件

@interface QLSnowController ()

@property (nonatomic, weak) QLSnowView *snowView;

@end

@implementation QLSnowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 下雪粒子动画
    [self addSnowFlow];
}

/**
 *  粒子动画
 */
- (void)addSnowFlow
{
    QLSnowView *snowView = [[QLSnowView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [self.view addSubview:snowView];
    self.snowView = snowView;
}


//  移除
- (void)dealloc
{
    self.snowView = nil;
    [self.snowView removeFromSuperview];
    QLLog(@"****");
}


@end
