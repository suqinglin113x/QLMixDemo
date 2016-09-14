//
//  CTPropertyViewController.m
//  4.11
//
//  Created by SU on 16/4/13.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "CTPropertyViewController.h"
#import "ViewController2.h"
#import <YYKit.h>
#import "BezierPathView.h"

@interface CTPropertyViewController ()<ThrowLineToolDelegate>
@property (nonatomic, strong)UIButton *mySapceBtn;
@property (nonatomic, strong)UIView *navView;

@end

@implementation CTPropertyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.7]] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:255 green:2552 blue:255 alpha:1]];//透明没用
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"我是第二";
    
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     设置导航颜色、属性
     
     */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hello" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"world" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];//字体颜色
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
    
    
    

//    [self useNetworkingToUploadPic];
    
    
    
    
  
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIAlertController *alVC = [UIAlertController alertControllerWithTitle:@"haha" message:@"提示信息栏" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"previous" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"next" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:[ViewController2 new] animated:YES completion:nil];
    }];
    UIAlertAction *ac3 = [UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alVC addAction:ac1];
    [alVC addAction:ac2];
    [alVC addAction:ac3];
    [self presentViewController:alVC animated:YES completion:nil];
}


/**
 *  使用afnetworking上传数据
 */
- (void)useNetworkingToUploadPic
{
    //上传地址
    NSString *upToUrl = @"https://pan.baidu.com/disk/home?errno=0&errmsg=Auth%20Login%20Sucess&stoken=a3d6b82554dea2044f3fb8fd6523910c48c22bf3b94e136d5d8feb8cdc6841540b489ef231e97c7c30212153207c326e79c51bb290147eafb85ffc4eb2504ec51340abeb0574&bduss=2677070b8d6ced3c65876ecbcaefa18a2c7356f8be8aba97550155a9aaab09b4ae53ae18cd5be617d167f88ada421d54d5346682d6a7e8368a3d7e7adcb4856c113106e8099462cf4445cea1eda2150eda9dea1c5100e9441264b3684b888bf8caf643395278a0c06757b8d04c50f14be1b6ec0f594fdf4caea8641e2086fc4f725c90ccdc7aff04707bf700757ca570d7a29a5526a6d1743946cf854707b47468b10bd79937604d2caacff9fb483070733fed817f8226033274171478425f2053f70b566444&ssnerror=0#list/path=%2F";

    //上传的图片等先转成NSData
    NSString *path = [[NSBundle mainBundle] pathForResource:@"2.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    [manage POST:upToUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"love" fileName:@"love.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        UIImage *image = [UIImage imageWithData:responseObject];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    //创建请求 (此版本AF过期)
//    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
//    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    //发送请求
//    [manage POST:upToUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        [formData appendPartWithFileData:data name:@"love" fileName:@"love.png" mimeType:@"image/png"];
//        
//        
//    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//        UIImage *image = [UIImage imageWithData:responseObject];
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 60, 150, 150)];
//        imageView.backgroundColor = [UIColor purpleColor];
//        [self.view addSubview:imageView];
//        imageView.image = image;
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"---result---%@",dict);
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        
//        
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        
//    }];
}

- (void)beginThrowing:(UIView *)view
{
    ThrowLineTool *tool = [ThrowLineTool sharedTool];
    tool.delegate = self;
    UIImageView *bagImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_center_point"]];
    CGFloat startX = 0;//arc4random() % (NSInteger)CGRectGetWidth(self.frame);
    CGFloat startY = 150;//CGRectGetHeight(self.frame);
    CGFloat endX = CGRectGetMidX(bagImgView.frame) + 10 - (arc4random() % 50);
    CGFloat endY = CGRectGetMidY(bagImgView.frame);
    CGFloat height = 50 + arc4random() % 40;
    view.backgroundColor = [UIColor redColor];
    [tool throwObject:view
                 from:CGPointMake(startX, startY)
                   to:CGPointMake(endX, endY)
               height:height duration:1.6];
}

@end
