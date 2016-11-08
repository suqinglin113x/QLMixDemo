//
//  SplashScreenView.m
//  
//
//  Created by SU on 16/9/9.
//
//

#import "SplashScreenView.h"


@interface SplashScreenView ()

@property(nonatomic, strong)UIImageView *adImageView;
@property(nonatomic, strong)UIButton *countButton;
@property(nonatomic, strong)NSTimer *countTimer;
@property(nonatomic, assign)NSInteger count;

@end

@implementation SplashScreenView
- (void)test{
    
}
- (NSTimer *)countTimer
{
    if (_countTimer == nil) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.广告图片
        _adImageView = [[UIImageView alloc] initWithFrame:frame];
        _adImageView.userInteractionEnabled = YES;
        _adImageView.backgroundColor = [UIColor redColor];
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToADVC)];
        [_adImageView addGestureRecognizer:gesture];
        [self addSubview:_adImageView];
        
        //跳过按钮
        _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _countButton.frame = CGRectMake(KScreenSize.width - 84, 30, 60, 30);
        [_countButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _countButton.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
        _countButton.layer.cornerRadius = 4;
        [self addSubview:_countButton];
        
    }
    return self;
}

- (void)pushToADVC
{
    //点击广告时，广告图消失，同时向首页发送通知，并把广告对应的地址链接传给首页
    [self dismiss];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tapAction" object:_imgLinkUrl userInfo:nil];
}

//移除广告
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
   
    [UIView animateKeyframesWithDuration:2.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        self.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)countDown

{
    _count --;
    [_countButton setTitle:[NSString stringWithFormat:@"跳过%ld",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self dismiss];
    }
}
- (void)setImgFilePath:(NSString *)imgFilePath
{
    _imgFilePath = imgFilePath;
    _adImageView.image = [UIImage imageWithContentsOfFile:_imgFilePath];
}

- (void)setImgDeadLine:(NSString *)imgDeadLine
{
    _imgDeadLine = imgDeadLine;
}

- (void)showSplashScreenWithTimer:(NSInteger)ADShowTime
{
    _ADShowTime = ADShowTime;
    [_countButton setTitle:[NSString stringWithFormat:@"跳过%ld",ADShowTime] forState:UIControlStateNormal];
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"MM/dd/yyyy HH:mm";
    
    //获取当前系统的时间，并转成相应的格式
    NSString *currentDateStr = [formate stringFromDate:[NSDate date]];
    NSDate *currentDate = [formate dateFromString:currentDateStr];
    //广告截止的时间也用相同的格式去转换
    NSDate *deadLineDate = [formate dateFromString:self.imgDeadLine];
    
    NSComparisonResult result;
    result = [deadLineDate compare:currentDate];
    if (result != NSOrderedAscending) {//图片有效期内显示，过期隐藏，为了一直显示，暂时不作处理
        [self dismiss];
    }
    else{
        [self startTimer];
        
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        window.hidden = NO;
        [window addSubview:self];
    }
}
- (void)startTimer
{
    _count = _ADShowTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}
@end
