//
//  ViewController6.h
//  4.11
//
//  Created by SU on 16/6/27.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ViewController5.h"

@interface ViewController6 : ViewController5

{
    UIView *naviView;
    UIButton *backBtn;
    UIButton *rightBtn;
    UILabel *upTitleLab;
}

- (void)pushNewViewController:(UIViewController *)VC;
- (void)pushNewViewControllerAndRemoveNow:(UIViewController *)VC;

- (void)backBrnPressed:(UIButton *)btn;


- (void)addUpNaviView;

@end
