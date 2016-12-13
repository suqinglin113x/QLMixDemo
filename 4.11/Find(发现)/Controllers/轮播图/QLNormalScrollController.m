//
//  QLNormalScrollController.m
//  4.11
//
//  Created by SU on 16/11/11.
//  Copyright © 2016年 SU. All rights reserved.
//

#define KScrollView_W self.scrollView.frame.size.width

#import "QLNormalScrollController.h"
#import "QLMaxScrollController.h"


@interface QLNormalScrollController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

//图片数
static NSInteger imageCount = 5;


@implementation QLNormalScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    //普通滚动
    [self normalRoll];
    
    //无限轮播
    UIButton *button = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, KScreenSize.height - 100, 150, 30) title:@"到无限轮播" target:self sel:@selector(toInfiniteRoll)];
    [self.view addSubview:button];
    
}


#pragma mark --- 无限滚动--
- (void)toInfiniteRoll
{
    QLMaxScrollController *infiniteScrollVC = [[QLMaxScrollController alloc] init];
    [self.navigationController pushViewController:infiniteScrollVC animated:YES];
    
}

#pragma mark --- 基本轮播--
- (void)normalRoll
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, KScreenSize.width, 200)];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(imageCount * KScrollView_W, 200);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    
    for (int i = 0; i < imageCount; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"food%d", i + 1];
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *KScrollView_W, 0, KScrollView_W, 200)];
        imageView.layer.borderWidth = 10;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
    
    //页码
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.pageIndicatorTintColor = [UIColor greenColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.center = CGPointMake(KScrollView_W / 2, CGRectGetMaxY(_scrollView.frame) - 10);
    self.pageControl.numberOfPages = imageCount;
    [self.view addSubview:self.pageControl];
    
    //定时器
    [self startTimer];
}

// 开始NSTimer
- (void)startTimer {

    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];

    // 修改timer在RunLoop中的模式，以便在主线程之外可以分配时间来处理定时器
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 停止NSTimer
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

// 翻滚到下一页
- (void)nextPage:(NSTimer *)timer {

    // 计算下一页的页码
    NSInteger nextPage = self.pageControl.currentPage + 1;

    // 当页码超过了最后一页时，返回到第一页
    if (nextPage == imageCount){
        nextPage = 0;
    }

    // 滚动到下一页
    [self.scrollView setContentOffset:CGPointMake(nextPage * KScrollView_W, 0) animated:YES];
}

#pragma mark --UIScrollViewDelegate--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //
    int currentPage = (scrollView.contentOffset.x + KScrollView_W * 0.5) / scrollView.frame.size.width;
    self.pageControl.currentPage = currentPage;

}

// 用户开始拖拽scrollView时，停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

// 用户拖拽结束时，重新开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

@end
