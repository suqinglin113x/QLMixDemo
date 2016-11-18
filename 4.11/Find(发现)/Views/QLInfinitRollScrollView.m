//
//  QLInfinitRollScrollView.m
//  4.11
//
//  Created by SU on 16/11/11.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLInfinitRollScrollView.h"



@interface QLInfinitRollScrollView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) BOOL isFirstLoadImage;
@property (nonatomic, assign) NSInteger defaltCount; //默认使用的imageview个数

@end


@implementation QLInfinitRollScrollView

#pragma mark ---初始化---
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        _defaltCount = 3;
        _defaltCount = self.imageViewCount ? _imageViewCount : _defaltCount;
        
        //添加图片控件
        for (int i = 0; i <self.defaltCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.layer.borderColor = [UIColor blackColor].CGColor;
            imageView.layer.borderWidth = 10;
            [scrollView addSubview:imageView];
        }
    
        //页码视图
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
    }
    
    return self;
}

//
- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    //设置页码
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
    
    //设置内容
    [self displayImage];
    
    //开始定时器
    [self startTimer];
}

#pragma mark ---图片处理
- (void)displayImage
{
    //设置图片，三张imageView显示无限涨图片 (思路：让中间张显示在眼前)
    for (int i = 0; i <self.defaltCount; i++) {
        
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger currentPage = self.pageControl.currentPage;
        /*滚到第一张，并且是程序刚启动第一次加载，currentPage才减一。
         加上这个判断条件是防止程序第一次加载时。此时第一张图片的i = 0,那么此时currentPage-- 导致越界，
         让前一张显示的是最后一张。
         */
        if (i == 0 && self.isFirstLoadImage) {
            
            currentPage--;
            
        }else if (i == 2){
            
            currentPage ++;
        }
        
        if (currentPage < 0) {//处理向前滚到第一张时，此时前一张显示最后一张
           
            currentPage = self.pageControl.numberOfPages - 1;
            
        }else if (currentPage >= self.pageControl.numberOfPages){
            //滚动到最后一张时，由于currentPage之前加一，导致currentPage大于总数，所以此时滚动到最后一张继续向后滚动就显示第一张
            currentPage = 0;
        }
        
        imageView.tag = currentPage;
        imageView.image = self.imageArray[currentPage];
        QLLog(@"%@", NSStringFromCGRect(self.frame));
    }
    
    self.isFirstLoadImage = YES;
    
    //让scrollView始终显示最中间的空间view
    if (self.rollDirectionType == QLInfinitRollScrollViewTypePortrait) {
        
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height)];
        
    }else{
        
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
        
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    if (self.rollDirectionType == QLInfinitRollScrollViewTypePortrait) {//竖向滚动
        self.scrollView.contentSize = CGSizeMake(0, self.defaltCount * self.bounds.size.height);
    }else{//横向滚动
        self.scrollView.contentSize = CGSizeMake(self.defaltCount *self.bounds.size.width, 0);
    }
    
    for (int i = 0; i <self.defaltCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (self.rollDirectionType == QLInfinitRollScrollViewTypePortrait) {
            imageView.frame = CGRectMake(0, i *self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }else{
            imageView.frame = CGRectMake(i *self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
    }
    
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = (self.scrollView.frame.size.width - pageW) * 0.5;
    CGFloat pageY = self.scrollView.frame.size.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);

    //图片添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
}

- (void)tapClick
{
    if (self.delegate  && [self.delegate respondsToSelector:@selector(infinitRollScrollView:tapImageWithInfo:)]) {
        [self.delegate infinitRollScrollView:self tapImageWithInfo:self.imageModelInfoArr[self.pageControl.currentPage]];
    }
}


#pragma mark --定时器处理
//开启定时器
- (void)startTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)autoScroll
{
    if (self.rollDirectionType == QLInfinitRollScrollViewTypePortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 *self.scrollView.frame.size.height) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(2 *self.scrollView.frame.size.width, 0) animated:YES];
    }
}

//关闭定时器
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark --UIScrollViewDelegate--
//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当两张图片同时显示在屏幕中，找出占屏幕比例超过一半的那张
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    
    for (int i = 0; i <self.defaltCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.rollDirectionType == QLInfinitRollScrollViewTypePortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        }else{
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

//开始拖拽，销毁定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

//手指停止，开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

//手指停止拖拽，显示下一张图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self displayImage];
}

//定时器滚动停止时，显示下一张图片
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self displayImage];
}

@end
