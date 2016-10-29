//
//  ViewController5.m
//  4.11
//
//  Created by SU on 16/6/27.
//  Copyright © 2016年 SU. All rights reserved.
//
/**
 *  CAAnimation 控制 layer 层动画  AVCapture原生二维码扫描
 */
#import "ViewController5.h"

#import <AVFoundation/AVFoundation.h>


@interface ViewController5 ()
<UINavigationControllerDelegate,UIImagePickerControllerDelegate,AVCaptureMetadataOutputObjectsDelegate> //用于处理采集信息的代理

@property(nonatomic, strong) AVCaptureSession *session; //输入输出的中间桥梁
@property(nonatomic, strong) UIView *scanWindow;
@property(nonatomic, strong) UIImageView *scanNetImageView;
@property(nonatomic, weak) UIView *maskView;

@end


static const CGFloat kMargin = 30;
static const CGFloat kBorderW = 100;

@implementation ViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anima = [_scanNetImageView.layer animationForKey:@"translationAnimation"];
    if (anima) {
        //1.将动画的时间偏移量作为暂停的时间点
        CFTimeInterval pauseTime = _scanNetImageView.layer.timeOffset;
        //2.根据媒体时间计算出准确的启动时间，对之前暂停动画的时间进行修复
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        
        _scanNetImageView.layer.beginTime = 0;
        _scanNetImageView.layer.timeOffset = 0;
        _scanNetImageView.layer.speed = 1;
        _scanNetImageView.layer.beginTime = beginTime;
    }else{
        CGFloat scanNetImageViewH = 241;
        CGFloat scanNetImageViewW = _scanWindow.frame.size.width - kMargin * 2;
        CGFloat scanWindowH = self.view.frame.size.width - kMargin * 2;
        _scanNetImageView.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnima = [CABasicAnimation animation];
        scanNetAnima.keyPath = @"transform.translation.y";
        scanNetAnima.byValue = @(scanWindowH);
        scanNetAnima.duration = 1;
        scanNetAnima.repeatCount = MAXFLOAT;
        [_scanNetImageView.layer addAnimation:scanNetAnima forKey:@"translationAnimation"];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[];
    }
}


#pragma mark -- 扫描区域

- (void)setupScanWindowView
{
    CGFloat buttonWH = 18;
    CGFloat scanWindowH = self.view.frame.size.width - kMargin * 2;
    CGFloat scanWindowW = self.view.frame.size.height - kMargin * 2;
    
    _scanWindow = [[UIView alloc] initWithFrame:CGRectMake(kMargin, kBorderW, scanWindowW, scanWindowH)];
    [self.view addSubview:_scanWindow];
    
    _scanNetImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
    
    UIButton *topLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_1"] forState:UIControlStateNormal];
    
    UIButton *topRight = [[UIButton alloc] initWithFrame:CGRectMake(scanWindowW - buttonWH, 0, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_2"] forState:UIControlStateNormal];
    
    
    UIButton *bottomLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, scanWindowH - buttonWH, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_3"] forState:UIControlStateNormal];
    
    
    UIButton *bottomRight = [[UIButton alloc] initWithFrame:CGRectMake(topRight.frame.origin.x, bottomLeft.frame.origin.y, buttonWH, buttonWH)];
    [topLeft setImage:[UIImage imageNamed:@"scan_4"] forState:UIControlStateNormal];
    
    [_scanWindow addSubview:topLeft];
    [_scanWindow addSubview:topRight];
    [_scanWindow addSubview:bottomLeft];
    [_scanWindow addSubview:bottomRight];
}



#pragma mark - 开始扫描
- (void)beginScaning
{
    
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    if (!input) {
        return;
    }
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置有效的扫描区域 （）
   
    /*
     AVCaptureMetadataOutput 中的属性rectOfInterest 看起来是CGRect类型, 结果让你填写一个比例, 当你填写比例是你会发现还是有各种问题,  最后总结一下, 假如你的屏幕的frame 为  x , y,  w, h,  你要设置的矩形快的frame  为  x1, y1, w1, h1.   那么你的 rectOfInterest 应该设置为   CGRectMake(y1/y, x1/x, h1/h, w1/w),    不知道苹果的工程师怎么想的, 为什么坐标系搞这么复杂.直接设置实际大小
     */
    //得到比例值
    CGRect scanCrop = [self getScanCrop:_scanWindow.frame readerViewBounda:self.view.frame];
    //必须是个比例值
    output.rectOfInterest = scanCrop;
    
    //初始化链接对象
    _session = [[AVCaptureSession alloc] init];
    
    //高质量采集lv
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //添加输入输出流
    [_session addInput:input];
    [_session addOutput:output];
    
    //设置扫描支持的编码格式（如下设置条形码和二维码兼容）
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.frame = self.view.frame;
    //设置填充满样式
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //开始捕获
    [_session startRunning];
    
}


#pragma mark -- 获取扫描区域的比例关系
/**
 *  @param rect           扫描的背景view
 *  @param readViewBounds 当前控制器的self.view
 *
 *  @return 返回一个比例rect
 */
- (CGRect)getScanCrop:(CGRect)rect readerViewBounda:(CGRect)readViewBounds
{
    CGFloat x, y, width, height;
    x = (CGRectGetHeight(readViewBounds) - CGRectGetHeight(rect))/2/CGRectGetHeight(readViewBounds);
    y = (CGRectGetWidth(readViewBounds) - CGRectGetWidth(rect)/2/CGRectGetWidth(readViewBounds));
    width = CGRectGetHeight(rect)/CGRectGetHeight(readViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readViewBounds);
    
    return CGRectMake(x, y, width, height);
}

- (void)openFlash:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self turnTorchOn:YES];
    }else{
        [self turnTorchOn:NO];
    }
}

#pragma mark 摄像头

- (void)turnTorchOn:(BOOL)on
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasFlash] && [device hasTorch]) {
            
            [device lockForConfiguration:nil];
            if (on) {
                //打开手电筒和闪关灯
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            }else{
                [device setFlashMode:AVCaptureFlashModeOff];
                [device setTorchMode:AVCaptureTorchModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark 我的相册
- (void)myAlbum
{
    NSLog(@"我的相册");
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //1.初始化相册拾取器
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        //2.设置代理
        pickVC.delegate = self;
        //3.设置资源
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        //4.随便给他一个转场动画
        pickVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:pickVC animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设备不支持相册，请在设置->隐私->照片中进行设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark imagePickController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //1、获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //初始化一个检测器
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    [picker dismissViewControllerAnimated:YES completion:^{
       
        //检测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count > 0) {
            /**结果对象*/
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:scannedResult delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该图片中没有包含一个二维码" delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"再次扫描", nil];
        [alertView show];
    }
}
@end
