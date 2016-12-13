//
//  QLUploadFileController.m
//  4.11
//
//  Created by SU on 16/10/27.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLUploadFileController.h"

@interface QLUploadFileController () <NSURLConnectionDataDelegate>

@end

@implementation QLUploadFileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navigationItem.title = @"上传";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self uploadFile];
    
}

- (void)uploadFile
{
    /**
     *  post的上传文件，不同于普通的数据上传，
     *  普通上传，只是将数据转换成二进制放置在请求体中，进行上传，有响应体得到结果。
     *  post上传，当上传文件是， 请求体中会多一部分东西， Content——Type，这是在请求体中必须要书写的，而且必须要书写正确，不能有一个标点符号的错误。负责就会请求不上去，或者出现请求的错误（无名的问题等）
     *  其中在post 请求体中加入的格式有{1、边界 2、参数 3、换行 4、具体数据 5、换行 6、边界 7、换行 8、对象 9、结束符}
     */
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方式 post
    request.HTTPMethod = @"POST";
    
    
    // 设置请求头数据 。  boundary：边界
    [request setValue:@"multipart/form-data; boundary=----WebKitFormBoundaryftnnT7s3iF7wV5q6" forHTTPHeaderField:@"Content-Type"];
    
    // 给请求体加入固定格式数据
    NSMutableData *data = [NSMutableData data];
    
    /*******************设置文件参数***********************/
    // 设置边界 注：必须和请求头数据设置的边界 一样， 前面多两个“-”；（字符串 转 data 数据）
    [data appendData:[@"------WebKitFormBoundaryftnnT7s3iF7wV5q6" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 设置传入数据的基本属性， 包括有 传入方式 data ，传入的类型（名称） ，传入的文件名， 。
    [data appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"2.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 设置 内容的类型  “文件类型/扩展名” MIME中的
    [data appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 加入数据内容
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    UIImage *image = [UIImage imageNamed:@"2"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [data appendData:imageData];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 设置边界
    [data appendData:[@"------WebKitFormBoundaryftnnT7s3iF7wV5q6" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    /******************非文件参数***************************/
    // 内容设置 ， 设置传入的类型（名称）
    [data appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 传入的名称username = lxl
    [data appendData:[@"lxl" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 退出边界
    [data appendData:[@"------WebKitFormBoundaryftnnT7s3iF7wV5q6--" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    request.HTTPBody = data;
    
    
    [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //解析服务器返回的数据
        NSString *message = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        QLLog(@"%@",message);
        
    }];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}
@end
