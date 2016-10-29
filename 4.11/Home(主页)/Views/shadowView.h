//
//  shadowView.h
//  4.11
//
//  Created by SU on 16/8/3.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shadowViewDelegate <NSObject>

@optional
- (void)shadowViewHidenAction;

@end

@interface ShadowView : UIView

@property (nonatomic, strong)UIWindow *window;
@property (nonatomic, strong)UIView *maskView;

@property (nonatomic, weak)id <shadowViewDelegate> delegate;

+ (ShadowView *)shareIntefaceShadowView;

- (void)maskViewShow:(CGRect)frame;
- (void)maskViewShow;
- (void)maskViewHide;
- (void)maskViewScreenRect;


@end
