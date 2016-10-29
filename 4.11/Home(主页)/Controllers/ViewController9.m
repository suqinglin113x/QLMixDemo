//
//  ViewController9.m
//  4.11
//
//  Created by SU on 16/8/4.
//  Copyright © 2016年 SU. All rights reserved.
//

/**
 *  手势密码
 */

#import "ViewController9.h"
#import "PCCircleView.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "PCCircleViewConst.h"


@interface ViewController9 ()<CircleViewDelegate>

@property (nonatomic, strong) PCCircleView *lockView;

@property (nonatomic, strong) PCLockLabel *msgLabel;

@property (nonatomic, strong) PCCircleInfoView *infoView;

@end

@implementation ViewController9

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.界面相同部分(解锁界面)
    [self setupLockView];
    
    //2.界面不同部分
    [self setupDifferentUI];
        
}



- (void)setupLockView
{
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    self.msgLabel = [[PCLockLabel alloc] init];
    self.msgLabel.frame = CGRectMake(0, 0, KScreenSize.width, adoptValue(20));
    self.msgLabel.backgroundColor = [UIColor clearColor];
    self.msgLabel.center = CGPointMake(KScreenSize.width/2, KScreenSize.height *0.15 + 40);
    self.msgLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.msgLabel];
    [self.msgLabel showNormalMsg:gestureTextBeforeSet andType:2];
}

- (void)setupDifferentUI
{
    [self.lockView setType:CircleViewTypeSetting];
    if (self.type == GestureTypeSetting) {
        NSLog(@"设置手势密码");
    }
    if (self.type == GestureTypeLogin) {
        [self.lockView setType:CircleViewTypeLogin];
        
        [self.msgLabel showNormalMsg:gestureTextOldGesture andType:2];
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self createButton:bottomBtn frame:CGRectMake(KScreenSize.width*0.25, KScreenSize.height-60, KScreenSize.width/2, 20) title:@"登陆其他账号"];
        
    }
}

- (void)createButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title
{
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn addTarget:self action:@selector(changeToOtherLoginWays) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)changeToOtherLoginWays
{
    Class loginVC = NSClassFromString(@"LoginViewController");
    
    [self presentViewController:[[loginVC alloc] init] animated:YES completion:nil];
}



#pragma mark pccricleview delegate

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    
}

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    
}
@end
