
//
//  WKWebViewController.m
//  4.11
//
//  Created by SU on 16/8/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

#import "QLCommonMethod.h"


@interface WKWebViewController ()

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    QLCommonMethod *method = [[QLCommonMethod alloc] init];
    [method performSelector:@selector(eat)];
}

@end
