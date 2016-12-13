//
//  ViewController4.m
//  4.11
//
//  Created by SU on 16/6/3.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ViewController4.h"
#define screenSize [[UIScreen mainScreen]bounds].size
@interface ViewController4 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@end

@implementation ViewController4
{
    UIImageView *headImage;
    UIImagePickerController *imagePickController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //头像框
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(screenSize.width/2-75, 100, 150, 150)];
    headImage.layer.cornerRadius = headImage.frame.size.width/2;
    headImage.clipsToBounds = YES;
    headImage.layer.borderWidth = 3;
    headImage.layer.borderColor = [UIColor brownColor].CGColor;
    [self.view addSubview:headImage];
    //添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadImage)];
    tapGes.numberOfTapsRequired = 1;
    [headImage addGestureRecognizer:tapGes];
    
    //初始化imagePicker
    imagePickController = [[UIImagePickerController alloc] init];
    imagePickController.delegate = self;
    imagePickController.allowsEditing = YES;
    imagePickController.view.backgroundColor = [UIColor purpleColor];
}

- (void)changeHeadImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",@"图库", nil];
    [actionSheet showInView:self.view];
}
#pragma mark  delegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"支持相机");
            //跳转到相机
            imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickController animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
            [alert show];
        }
    }
    if (buttonIndex == 1) {//相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            //跳转到相册
            imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickController animated:YES completion:nil];
        }
        else
        {
            
        }
    }
}

//用户选中之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%s,info == %@",__func__,info);
    
    [self fixOrientation:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
}
//修正照片方向
- (UIImage *)fixOrientation:(UIImage *)aImage
{
    if (aImage.imageOrientation == UIImageOrientationUp) {
        return aImage;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
            
        default:
            break;
    }
    return aImage;
}

//pragma 的强大功能
/*
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-相关命令"
 //代码
 #pragma clang diagnostic pop
 */
- (void)pragmaFunction
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable" //去除变量未使用的警告
    int a = 3;
#pragma clang diagnostic pop
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles" //去除循环引用的警告
    self.completedHandle = ^{
        
    };
#pragma clang diagnostic pop
}

@end
