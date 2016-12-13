//
//  QLMaxScrollController.m
//  4.11
//
//  Created by SU on 16/11/11.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLMaxScrollController.h"
#import "QLInfinitRollScrollView.h"


@interface QLMaxScrollController () <QLInfinitRollScrollViewDelegate>

@end


@implementation QLMaxScrollController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    QLInfinitRollScrollView *scrollView = [[QLInfinitRollScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenSize.width, 200)];
    [self.view addSubview:scrollView];
    scrollView.imageArray = @[[UIImage imageNamed:@"food1"],
                              [UIImage imageNamed:@"food2"],
                              [UIImage imageNamed:@"food3"],
                              [UIImage imageNamed:@"food4"],
                              [UIImage imageNamed:@"food5"]];
    //使用的控件数
//    scrollView.imageViewCount = 3;
    //滚动方向
    scrollView.rollDirectionType = QLInfinitRollScrollViewTypePortrait;
    
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    
}


@end
