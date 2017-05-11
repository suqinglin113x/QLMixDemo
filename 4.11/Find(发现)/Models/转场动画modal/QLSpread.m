//
//  QLSpread.m
//  4.11
//
//  Created by SU on 16/11/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLSpread.h"
#import "QLSpreadController.h"
#import "UIView+Category.h"

@implementation QLSpread

+ (instancetype)transitionWithTransitionType:(QLSpreadTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(QLSpreadTransitionType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

//返回动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case QLSpreadTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case QLSpreadTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        case QLSpreadTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case QLSpreadTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
        default:
            break;
    }
}

#pragma mark -- push、pop 动画--
/**push*/
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //创建一个快照view
    UIView *snapView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapView.frame = fromVC.view.frame;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:snapView];
    [containerView addSubview:toVC.view];
    fromVC.view.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];
    [snapView.layer setAnchorPoint:CGPointMake(0, 0.5)];
    [snapView setAnchorPointTo:CGPointMake(0, 0.5)];
    CATransform3D transform3D =  CATransform3DIdentity;
    transform3D.m34 = -0.002;
    containerView.layer.sublayerTransform = transform3D;
    //增加阴影
    CAGradientLayer *fromGradient = [CAGradientLayer layer];
    fromGradient.frame = fromVC.view.bounds;
    fromGradient.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor blackColor]];
    fromGradient.startPoint = CGPointMake(0.0, 0.5);
}

/**pop*/
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}
#pragma mark -- modal 动画--
/**present*/
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //0、目标vc = QLSpreadController，把目标vc的view添加到过渡上下文中的containerView中，
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVC.view];
    
    //1、添加过渡时的动画，画两个圆路径
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 100, 20, 20)];
    CGFloat x = MAX(200, containView.frame.size.width - 200);
    CGFloat y = MAX(100, containView.frame.size.height - 100);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containView.center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];

    //2、创建CAShapeLayer进行覆盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.view的遮盖
    toVC.view.layer.mask = maskLayer;
    
    //3、创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endCycle.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

/**dismiss*/
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //0、从当前的vc = QLSpreadController返回，
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //1、创建动画，
    CGFloat radius = sqrt(containerView.frame.size.height *containerView.frame.size.height + containerView.frame.size.width *containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI *2 clockwise:YES];
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 100, 10, 10)];
    
    //2、创建cashapelayer进行覆盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    [maskLayer setFillColor:[[UIColor colorWithRed:0.2 green:1.0 blue:0.0 alpha:1.0f] CGColor]]; //貌似无效，没法渲染
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    //3、创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endCycle.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (_type) {
        case QLSpreadTransitionTypePresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
            
        case QLSpreadTransitionTypeDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
            
        default:
            break;
    }
}
@end
