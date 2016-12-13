//
//  QLSpreadController.m
//  4.11
//
//  Created by SU on 16/11/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLSpreadController.h"
#import "QLSpread.h"


@interface QLSpreadController () <UIViewControllerTransitioningDelegate,
                                    UINavigationControllerDelegate>
/**导航方式push、pop、none*/
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation QLSpreadController

- (void)dealloc
{
    
    self.transitioningDelegate = nil;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *dismissBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 70, 70, 30) title:@"dismiss" target:self sel:@selector(dismiss)];
    [self.view addSubview:dismissBtn];
    
    UIButton *popBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(CGRectGetMaxX(dismissBtn.frame) + 20, 70, 50, 30) title:@"pop" target:self sel:@selector(pop)];
    [self.view addSubview:popBtn];
    
    
}

#pragma mark --modal 动画---
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [QLSpread transitionWithTransitionType:QLSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [QLSpread transitionWithTransitionType:QLSpreadTransitionTypeDismiss];
}

#pragma mark --push pop 动画---
- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    _operation = operation;
    //分push 和 pop 两种情况
    return [QLSpread transitionWithTransitionType:operation == UINavigationControllerOperationPush ? QLSpreadTransitionTypePush :QLSpreadTransitionTypePop];
}

//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    if (_operation == UINavigationControllerOperationPush) {
//        
//    }else {
//        
//    }
//}

@end

