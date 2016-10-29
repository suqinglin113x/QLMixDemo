//
//  shadowView.m
//  4.11
//
//  Created by SU on 16/8/3.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ShadowView.h"

@interface ShadowView ()<UIGestureRecognizerDelegate>

@end

@implementation ShadowView

- (id)init
{
    if (self = [super init]) {
        UIImage *image ;
        CALayer *layer;
        layer.contents =(__bridge id)image.CGImage;
    }
    return self;
}

+ (ShadowView *)shareIntefaceShadowView
{
    static ShadowView *shadowView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shadowView = [[ShadowView alloc] init];
        shadowView.window = [[UIWindow alloc] init];
        shadowView.window.frame = CGRectMake(0, 0, KScreenSize.width, adoptValue(320));
        shadowView.window.windowLevel = UIWindowLevelStatusBar;
        shadowView.window.hidden = YES;
        shadowView.window.backgroundColor = [UIColor clearColor];
        
        shadowView.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KScreenSize.width, adoptValue(320))];
        shadowView.maskView.backgroundColor = [UIColor blackColor];
        shadowView.maskView.alpha = 0.8;
        shadowView.maskView.hidden = YES;
        [shadowView.window addSubview:shadowView.maskView];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewHide)];
        gesture.delegate = shadowView;
        [shadowView.maskView addGestureRecognizer:gesture];
        
        shadowView.hidden = YES;
    });
    
    return shadowView;
}

- (void)maskViewShow
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.maskView.hidden = NO;
    self.window.hidden = NO;
    self.hidden = NO;
    
}

- (void)maskViewHide
{
    if ([self.delegate performSelector:@selector(shadowViewHidenAction)]) {
        [self.delegate shadowViewHidenAction];
    }
}

- (void)maskViewScreenRect
{
    self.window.frame = CGRectMake(0, 0, KScreenSize.width, adoptValue(320));
    self.maskView.frame = self.window.frame;
    [self maskViewShow];
}

- (void)maskViewShow:(CGRect)frame
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.window setFrame:frame];
    [self.maskView setFrame:frame];
    [self maskViewShow];
}
@end
