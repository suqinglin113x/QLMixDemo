//
//  QLWebJSController.m
//  4.11
//
//  Created by SU on 16/11/22.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLWebJSController.h"

@interface QLWebJSController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation QLWebJSController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.webView.delegate = self;
    
    //路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [_webView stringByEvaluatingJavaScriptFromString:@""];
}



@end
