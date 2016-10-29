//
//  ADViewController.m
//  4.11
//
//  Created by SU on 16/9/12.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController ()

@property(nonatomic, strong)UIWebView *webView;

@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.title = @"广告详情页";
    self.navigationController.navigationBar.translucent = NO;
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.scrollView.bounces = NO;
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:self.urlString];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
         
    });
}


@end
