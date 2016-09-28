//
//  ViewController.m
//  4.11
//
//  Created by SU on 16/4/11.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ViewController.h"
#import "CTPropertyViewController.h"
#import "ViewController2.h"
#import "QLCommonMethod.h"


@interface ViewController ()
{
    NSInteger currentIndex;
    UIView *backView;
    CGPoint lastPoint;
    
    view1 *_rectView;
}
@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    view1 *rectLayer = [[view1 alloc] initWithFrame:CGRectMake(0, 250, 375, 367)];
    rectLayer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rectLayer];
    _rectView = rectLayer;
    [rectLayer initRectLayer];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.hidden = YES;
//    [self createBtn];
    self.modalPresentationCapturesStatusBarAppearance = YES;
    [self imageGif];
    
    [self objcRuntime];
    
    QLCommonMethod *method = [[QLCommonMethod alloc] init];
    [method hexStringWithColor:[UIColor redColor] Alpha:NO];
    
    view1 *rectLayer = [[view1 alloc] initWithFrame:CGRectMake(0, 250, 375, 367)];
    rectLayer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rectLayer];
    
    [rectLayer initRectLayer];
    
    UIPanGestureRecognizer *pan  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panIt:)];
    
    [self.view addGestureRecognizer:pan];
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 64, 375, 667)];
    backView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:backView];
    
}
- (void)panIt:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.view];
    QLLog(@"%@",NSStringFromCGPoint(point));
    
    BOOL needMoveWithTap = YES;
    CGFloat px = self.view.frame.origin.x;
    if (px < 0) {
        needMoveWithTap = NO;
    }
    
    if (needMoveWithTap && (pan.view.frame.origin.x >= 0) && (pan.view.frame.origin.x <= 300)) {
        CGFloat rectcenterX = pan.view.center.x + point.x * 0.5;
        if (rectcenterX <= KScreenSize.width * 0.5 - 2) {
            rectcenterX = KScreenSize.width / 2 - 2;
        }
        CGFloat rectcenterY = pan.view.center.y;
        pan.view.center = CGPointMake(rectcenterX, rectcenterY);
        
        CGFloat scale = 1 - (1 - 0.8) * (pan.view.frame.origin.x / (300));
        pan.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
        
    }
}

- (void)objcRuntime
{
    Class class = NSClassFromString(@"ViewController2");
    UIViewController *VC2 = [[class alloc] init];
    SEL selector2 = NSSelectorFromString(@"createBtn");
    [self performSelector:selector2];
    
}

- (void)getClassMethods
{
    Method method1 = class_getClassMethod([ViewController2 class], @selector(run));
    Method method2 = class_getClassMethod([ViewController2 class], @selector(cry));
    
    //交换后，先打印cry，后打印run
    method_exchangeImplementations(method1, method2);
    [ViewController2 run];
    [ViewController2 cry];
 }
/**
 *  添加按钮
 */
- (void)createBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 70, 375, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clickMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:btn];
    
}
/**
 *  按钮action
 */
- (void)clickMe
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"怎么样子" preferredStyle:0];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"next" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CTPropertyViewController *VC = [[CTPropertyViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:VC];
//        navi.navigationBarHidden = YES;
        [self presentViewController:navi animated:YES completion:nil];
        
    }];
    UIAlertAction *Action = [UIAlertAction actionWithTitle:@"reset" style:UIAlertActionStyleDestructive handler:nil];
    
    [alertController addAction:Action];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    //显示
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 *  使用sdwebimage加载动态图
 *  两种加载方法
 */
- (void)imageGif
{
    UIImageView *imageTestV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 200, 200)];
    NSString *imageStr = [[NSBundle mainBundle] pathForResource:@"1.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:imageStr];
    imageTestV.image = [UIImage sd_animatedGIFWithData:data];
    imageTestV.image = [UIImage sd_animatedGIFNamed:@"1"];
    [self.view addSubview:imageTestV];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
    
}

/**
 *  比较字符串
 */
- (void) compareStrOne:(NSString *)strOne strTwo:(NSString *)strTwo
{
    NSComparisonResult result = [strOne compare:strTwo];
    if (result == NSOrderedSame) {
        return;
    }
}

- (void)constraintView
{
    UILabel* logoImageView = [[UILabel alloc] init];
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
  
    logoImageView.backgroundColor = [UIColor redColor];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:logoImageView];
    //logoImageView左侧与父视图左侧对齐
    NSLayoutConstraint* leftConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    
    //logoImageView右侧与父视图右侧对齐
    NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    
    //logoImageView顶部与父视图顶部对齐
    NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:200.0f];
    
    //logoImageView高度为父视图高度一半
//        NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0.0f];
    
    //iOS 6.0或者7.0调用addConstraints
    //[self.view addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
    
    //iOS 8.0以后设置active属性值
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
//        heightConstraint.active = YES;
}

- (void)dealloc
{
    NSLog(@"我被调用了");
}
@end
