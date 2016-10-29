//
//  QLSlideSwitchView.m
//  4.11
//
//  Created by SU on 16/10/13.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLSlideSwitchView.h"

static const CGFloat kHeightOfTopScrollView = 30.f;
static const CGFloat kWidthOfButtonMargin = 0.0f;
static const CGFloat kFontSizeOfTabButton = 13.f;
static const NSUInteger kTagOfRightSideButton = 999;

@implementation QLSlideSwitchView

#pragma mark - 初始化参数
- (void)initValues
{
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    topImg.image = [UIImage imageNamed:@""];
    [self addSubview:topImg];
    
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 102; //默认定位到某个位置
    
    //创建主滚动视图
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.bounces = YES;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [NSMutableArray array];
    
    _isBuildUI = NO;
}

//从nib文件加载视图完成初始化
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

//代码控制视图的加载
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self initValues];
    }
    return self;
}

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
}

#pragma mark - 创建控件
//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0, _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
            _topScrollView.frame = CGRectMake(0, 0, self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0 + _rootScrollView.bounds.size.width * i, 0, _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake(self.bounds.size.width * (_userSelectedChannelID - 100), 0) animated:YES];
        
        //调整顶部滚动视图选中阿牛位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
        
    }
}

/*
 * 创建子视图
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i = 0; number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        QLLog(@"%@",NSStringFromCGSize(vc.view.frame.size));
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
    }
    
    [self createNameButtons];
    
    _isBuildUI = YES;
    
    [self setNeedsLayout];
    
    //选中某个按钮
    UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
    [self selectNameButton:button];
}

- (void)clearUI
{
    for (id vi in [_rootScrollView subviews]) {
        [vi removeFromSuperlayer];
    }
    for (id vi in [_topScrollView subviews]) {
        [vi removeFromSuperlayer];
    }
    
    _isBuildUI = NO;
    _userSelectedChannelID = 100;
    [_viewArray removeAllObjects];
}

- (void)createNameButtons
{
    //底部红线
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:[UIImage imageNamed:@"redLine.png"]];
    _shadowImageView.backgroundColor = [UIColor clearColor];
    [_topScrollView addSubview:_shadowImageView];
    
    //设置上面标签标题的间距位置
    NSInteger btnWidth = 0;
    btnWidth = KScreenSize.width / [_viewArray count];
    for (int i = 0; i <_viewArray.count; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮尺寸
        [button setFrame:CGRectMake(btnWidth *i, 0, btnWidth, kHeightOfTopScrollView)];
        button.tag = 100 +i;
        if (i == 0) {
            _shadowImageView.frame = CGRectMake(15, kHeightOfTopScrollView - 2, btnWidth, 2);
            button.selected = NO;
        }
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:kFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
    }
    _topScrollView.contentSize = CGSizeMake(btnWidth * _viewArray.count, kFontSizeOfTabButton);
}

/*选中*/
- (void)selectNameButton:(UIButton *)button
{
    //
    
    //如果更换按钮
    if (button.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮新的ID
        _userSelectedChannelID = button.tag;
    }
    
    //按钮选中状态
    if (!button.selected) {
        button.selected = YES;
        [UIView animateWithDuration:0.25 animations:^{
            //下面的红色线条
            [_shadowImageView setFrame:CGRectMake(button.frame.origin.x + _flAdjustSpace/2, kHeightOfTopScrollView - 2, button.bounds.size.width - _flAdjustSpace, _shadowImage.size.height)];
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页
                [_rootScrollView setContentOffset:CGPointMake(self.bounds.size.width * (button.tag - 100), 0) animated:YES];
            }
            _isRootScroll = NO;
            
            if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
            }
        }];
    }
}

#pragma mark - 顶部滚动视图逻辑
/*
 *调整顶部滚动视图的x
 */
- (void)adjustScrollViewContentX:(UIButton *)button
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (button.frame.origin.x - _topScrollView.contentOffset.x > self.bounds.size.width - - (kWidthOfButtonMargin + button.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字 (ps:计算可以通过画图理解)
        [_topScrollView setContentOffset:CGPointMake(button.frame.origin.x - (_topScrollView.bounds.size.width - (kWidthOfButtonMargin + button.bounds.size.width)), 0) animated:YES];
    }
    
    //如果 当前显示的第一个tab超出
    if (button.frame.origin.x - _topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        [_topScrollView setContentOffset:CGPointMake(button.frame.origin.x, 0) animated:YES];
    }
}

#pragma mark - 主视图逻辑方法

//开始滚动视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else{
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width + 100;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

- (void)scrollHandlePan:(UIPanGestureRecognizer *)panParam
{
    //当滑动左边界时，传递滑动事件给代理
    if (_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    }else if (_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width){
        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma  mark - 工具方法
/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *color = nil;
    unsigned int colorCode = 0;
    unsigned char redByte,greenByte,blueByte;
    if (nil != inColorString) {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        [scanner scanHexInt:&colorCode];//return YES ,success.else is false.
    }
    
    redByte = colorCode >> 16;
    greenByte = colorCode >> 8;
    blueByte = colorCode;
    
    color = [UIColor colorWithRed:redByte / 0xff green:greenByte / 0xff blue:blueByte / 0xff alpha:1.0];
    return color;
}

@end
