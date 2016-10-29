//
//  ViewController7.m
//  4.11
//
//  Created by SU on 16/6/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ViewController7.h"

#import <objc/runtime.h> //******runtime机制******//
#import <ImageIO/ImageIO.h>
#include <stdio.h>
#import <objc/objc-sync.h>

/**
 *  三种字符串 的 宏定义
 */
//FOUNDATION_EXPORT const NSString *exportStr;
//#define string2 @"happy"
//extern NSString *externStr;

@interface ViewController7 () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController7
{
    UITableView *tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    time_t b = 3;
    
    
    /**
     *  三种定义 宏字符串的方法下字符串 的比较
     */
//    exportStr = @"china";
//    externStr = @"china";
//    NSString *tempStr = @"happy";
//    if (tempStr == exportStr){
//        
//    }
//    
//    if ([tempStr isEqualToString:string2]) {
//        
//    }
//    
//    if (tempStr == externStr) {
//        
//    }
    
}

- (void)thread
{
    NSThread *thread = [NSThread new];
   NSMutableArray *array = [NSMutableArray arrayWithArray:[NSThread callStackSymbols]];
    [array addObject:@"dd"];
    
}

- (void)gcd
{
    dispatch_queue_t queue0 = dispatch_get_main_queue();
    dispatch_queue_t queue1 = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    dispatch_queue_t queue2 = dispatch_queue_create("com.SerialQueue" , DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_get_current_queue();

    printf("%@,%@,%@,%@",queue0,queue1,queue2,queue3);
   
    dispatch_queue_attr_t att = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INTERACTIVE, -1);
}

- (void)dispatchTime
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)2*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)test
{
    typeof(self) weakSelf = self;
    UIButton *btn = [[UIButton alloc]init];
    btn.contentHorizontalAlignment = 0;
    
    [self openCareView];
    
    NSArray <NSString*>*strings = @[@"dada",@"asdaddas"]; //泛型
//    NSArray *strings = @[@"dada",@"asdaddas"];
    strings.firstObject.length;
}

- (__kindof NSArray*)openCareView
{
    NSArray *objs = @[[[UILabel alloc] initWithFrame:CGRectZero],
                      [[UIButton alloc] initWithFrame:CGRectZero],
                      [[UITextField alloc] initWithFrame:CGRectZero]];
    return objs;
}


- (void)imageRef
{
    NSString *imagePathStr = [[NSBundle mainBundle] pathForResource:@"fdgdf" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePathStr];
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    NSUInteger numberOfFrames = CGImageSourceGetCount(imageSourceRef);
    NSDictionary *imageProperties = CFBridgingRelease(CGImageSourceCopyProperties(imageSourceRef, NULL));
    NSDictionary *gifProperties = imageProperties [@"kCGImagePropertyGIFDictionary"];
    
}


- (void)tabbaritem
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:nil selectedImage:nil];
    item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = item;
    //添加到 [[UITabBarController alloc] init].viewControllers
    
}

@end
