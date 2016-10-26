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
    
    //默认文件名字：minion_01.mp4
    self.filePath = [caches stringByAppendingPathComponent:@"minion_01.mp4"];
    

    [self createUI];
    
    
}

#pragma mark--methods-------风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️------
- (void)createUI
{
    UIButton *downBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 80, 100, 30) title:@"下载" target:self sel:@selector(btnClickToDownloadFile)];
    [self.view addSubview:downBtn];
    
    UIButton *deleteFileBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 120, 100, 30) title:@"清除缓存" target:self sel:@selector(deleteDownloadFile)];
    [self.view addSubview:deleteFileBtn];
    
    UILabel *progressLabel = [QLViewCreateTool createLabelWithFrame:CGRectMake(120, 80, 70, 30) title:@"0.00"];
    progressLabel.tag = 100;
    [self.view addSubview:progressLabel];
    
}

- (void)btnClickToDownloadFile
{
    //1.首先判断文件是否存在
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    if ([fileManage fileExistsAtPath:self.filePath]){
        [MBProgressHUD showMessage:@"文件可能已存在咯📂！"];
//        [MBProgressHUD showMessage:@"文件可能已存在咯📂！" toView:self.view];
        return;
    }
    
    
    //下载小文件和大文件
    //[self downloadNormalFile];
    
    //大文件断点下载
    [self breakpointDownloadFile];
    
  
}

/**
 *  普通方式下载
 */
//- (void)downloadNormalFile
//{
//    //1.路径
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
//    
//    //2.创建请求对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    //3.使用NSURLConnection设置代理并发送异步请求
//    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    
//}


#pragma mark -----小文件下载-----风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️-----

#pragma mark -NSURLConnectionDataDelegate

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
//    self.connection = nil;
//}



#pragma mark -----大文件下载------风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️----
                                /*思路：边下载边写入*/
#pragma mark -NSURLConnectionDataDelegate

////当接收到服务器响应后调用，只掉用一次
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    //1.获得当前要下载的总文件大小（通过响应头）
//    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//    self.totalLength = res.expectedContentLength;
//    QLLog(@"%zd",self.totalLength);
//    
//    //2.文件名字
//    self.fileName = res.suggestedFilename;
//    
//    //3.创建文件管理者
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    self.filePath = [caches stringByAppendingPathComponent:self.fileName];
//    
//    NSFileManager *fileManage = [NSFileManager defaultManager];
//    
//    //4.创建一个空的文件
//    [fileManage createFileAtPath:self.filePath contents:nil attributes:nil];
//    
//}
//
////服务器返回数据，调用多次
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    QLLog(@"%s",__func__);
// 
//    //1.使用文件句柄写文件
//    NSFileHandle *inFile = [NSFileHandle fileHandleForReadingAtPath:self.filePath];
//    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:self.filePath ];
//    
//    if (!inFile) {
//        
//        return;
//    }
//    //2.设置写数据的位置（追加）
//    [handle seekToEndOfFile];
//    
//    //3.写数据
//    [handle writeData:data];
//   
//    //4.关闭句柄
//    [handle closeFile];
//    
//    
//    //5.下载进度
//    self.currentLength += data.length;
//    self.progress = self.currentLength / self.totalLength;
//    QLLog(@"%f",self.progress);
//    
//    if (self.progress == 1.0) {
//        [MBProgressHUD showMessage:@"下载完成" toView:self.view];
//    }
//    
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    self.connection = nil;
//}



#pragma mark -----大文件 断点 下载------风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️----


/**
 *  大文件断点下载
 */
- (void)breakpointDownloadFile
{
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    
    //2.创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2.1 设置下载文件的某一部分
    // 思路：只要设置HTTP请求头的Range属性，就可以实现从指定位置开始下载
    /*
     Range: bytes=0-499 表示头500个字节
     Range: bytes=500-999 表示第二个500字节
     Range: bytes=-500 表示最后500个字节
     Range: bytes=500- 表示500字节以后的范围
     */
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-", self.currentLength];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    //3.使用NSURLConnection设置代理并发送异步请求
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

#pragma mark ----NSURLConnectionDataDelegate

//当接收到服务器响应后调用，只掉用一次
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //获得当前下载文件的总大小（通过响应头）
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    
    //注意点：res.expectedContentLength获得是本次请求要下载的文件大小,(并非是完整的文件大小)
    //因此：文件的总大小 = 本次要下载的文件大小 + 已经下载的文件大小
    self.totalLength = res.expectedContentLength + self.currentLength;
    QLLog(@"currentLength----%zd", self.currentLength);
    QLLog(@"totalLength---%zd", self.totalLength);
    
    //判断当前是否已经下载过，如果当前文件已经存在，直接返回
    if (self.currentLength > 0) {
        return;
    }
    
    self.fileName = res.suggestedFilename;
    
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [cache stringByAppendingPathComponent:self.fileName];
    QLLog(@"%@", self.filePath);
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    [fileManage createFileAtPath:self.filePath contents:nil attributes:nil];
    
}

//服务器返回数据，调用多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //1.创建一个数据输出流
    /*
     第一个参数：二进制的数据流要写入到路径
     第二个参数：采用什么样的方式写入数据流，如果yes追加，no覆盖
     */
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:YES];
    
    //如果文件不存在自动创建
    [stream open];
    
    //2.当接受到数据时写数据
    [stream write:data.bytes maxLength:data.length];
    
    //3.下载完成关闭流
    [stream close];
    
    self.currentLength += data.length;
    
    //4.进度
    self.progress = self.currentLength / self.totalLength;
    UILabel *progressLabel = [(UILabel *)self.view viewWithTag:100];
    progressLabel.text = [NSString stringWithFormat:@"%.2f", self.progress];
    //QLLog(@"%f",self.progress);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.progress == 1.00) {
        
        [MBProgressHUD showMessage:@"下载完成"];
    }
    self.connection = nil;
}


#pragma mark -----删除已下载文件-------风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️----

//删除已下载文件
- (void)deleteDownloadFile
{
    //1.正在下载的取消下载
    [self.connection cancel];
    self.connection = nil;
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    
    if (![fileManage fileExistsAtPath:self.filePath]){
        [MBProgressHUD showMessage:@"文件不存在或已删除！" toView:self.view];
        return;
    }
    
    //删除缓存文件
    [fileManage removeItemAtPath:self.filePath error:nil];
    [MBProgressHUD showMessage:@"已删除🚮！" toView:self.view];
}

@end
