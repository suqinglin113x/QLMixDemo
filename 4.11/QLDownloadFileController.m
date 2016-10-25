//
//  QLDownloadFileController.m
//  4.11
//
//  Created by SU on 16/10/25.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLDownloadFileController.h"

@interface QLDownloadFileController ()<NSURLConnectionDataDelegate>

//创建全局的connection
@property (nonatomic, strong) NSURLConnection *connection;

//用来存放小文件下载
@property (nonatomic, strong) NSMutableData *fileData;

//文件总大小
@property (nonatomic, assign) long long  totalLength;

//文件名字
@property (nonatomic, copy) NSString *fileName;

//当前下载文件大小
@property (nonatomic, assign) float currentLength;

//下载进度
@property (nonatomic, assign) CGFloat progress;

//文件保存路径
@property (nonatomic, copy) NSString *filePath;

@end

@implementation QLDownloadFileController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"下载";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //缓存路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [caches stringByAppendingPathComponent:@"minion_01.mp4"];
    

    UIButton *downBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 80, 100, 30) title:@"下载" target:self sel:@selector(downloadFile)];
    [self.view addSubview:downBtn];
   
    UIButton *deleteFileBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 120, 100, 30) title:@"清除缓存" target:self sel:@selector(deleteDownloadFile)];
    [self.view addSubview:deleteFileBtn];
}


- (void)downloadFile
{
    //1.首先判断文件是否存在
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    if ([fileManage fileExistsAtPath:self.filePath]){
        
        
        return;
    }
    
    //2.路径
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //4.使用NSURLConnection设置代理并发送异步请求
   self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}


#pragma mark -----小文件下载-----风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️-----

//#pragma mark -NSURLConnectionDelegate
//
////当接收到服务器响应后调用，只掉用一次
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    //创建一个容器，用来接收服务器返回的数据
//    self.fileData = [NSMutableData data];
//    //获得当前要下载的总文件大小（通过响应头）
//    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//    self.totalLength = res.expectedContentLength;
//    QLLog(@"%zd",self.totalLength);
//    //拿到服务器推荐的文件名称
//    self.fileName = res.suggestedFilename;
//    QLLog(@"%@",self.fileName);
//}
//
////服务器返回数据，调用多次
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    QLLog(@"%s",__func__);
//    //拼接每次下载的数据
//    [self.fileData appendData:data];
//    //计算当前下载进度并刷新UI显示
//    self.currentLength = self.fileData.length;
//    
//    self.progress = self.currentLength / self.totalLength;
//    QLLog(@"%f",self.progress);
//}
//
////网络请求结束后调用
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    //文件下载完毕把接收的文件数据写入到沙盒保存
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    self.filePath = [caches stringByAppendingPathComponent:self.fileName];
//    //.写入本地
//    [self.fileData writeToFile:self.filePath atomically:YES];
//    
//    QLLog(@"%@",self.filePath);
//}



#pragma mark -----大文件下载------风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️----
                                /*思路：边下载边写入*/
#pragma mark -NSURLConnectionDelegate

//当接收到服务器响应后调用，只掉用一次
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //1.获得当前要下载的总文件大小（通过响应头）
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    self.totalLength = res.expectedContentLength;
    QLLog(@"%zd",self.totalLength);
    
    //2.文件名字
    self.fileName = res.suggestedFilename;
    
    //3.创建文件管理者
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [caches stringByAppendingPathComponent:self.fileName];
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    //4.创建一个空的文件
    [fileManage createFileAtPath:self.filePath contents:nil attributes:nil];
    
}

//服务器返回数据，调用多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    QLLog(@"%s",__func__);
 
    //1.使用文件句柄写文件
    NSFileHandle *inFile = [NSFileHandle fileHandleForReadingAtPath:self.filePath];
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.filePath ];
    
    if (!inFile) {
        
        return;
    }
    //2.设置写数据的位置（追加）
    [handle seekToEndOfFile];
    
    //3.写数据
    [handle writeData:data];
   
    //4.关闭句柄
    [handle closeFile];
    
    
    //5.下载进度
    self.currentLength += data.length;
    self.progress = self.currentLength / self.totalLength;
    QLLog(@"%f",self.progress);
    
    if (self.progress == 1.0) {
        [MBProgressHUD showMessage:@"下载完成" toView:self.view];
    }
    
    
}


#pragma mark -----删除已下载文件-------


//删除已下载文件
- (void)deleteDownloadFile
{
    //取消下载
    [self.connection cancel];
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath:self.filePath]){
        [MBProgressHUD showMessage:@"文件不存在或已删除" toView:self.view];
        return;
    }
    [fileManage removeItemAtPath:self.filePath error:nil];
    
    [MBProgressHUD showMessage:@"已删除🚮" toView:self.view];
}

@end
