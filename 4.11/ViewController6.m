//
//  ViewController6.m
//  4.11
//
//  Created by SU on 16/6/27.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ViewController6.h"
#import "Masonry.h"

@interface ViewController6 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUpNaviView];
    if ([UIDevice currentDevice].systemVersion.integerValue >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)addUpNaviView
{
    naviView = [[UIView alloc] init];
    naviView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:naviView];
    
    //frame
    naviView.frame = CGRectInset(self.view.bounds, 20, 20);
    
    [naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.height.equalTo(@33);
        
    }];

}

- (void)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        [[UINavigationBar appearance] setBackgroundImage:nil forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }];
    
}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self) weakSelf = self;
    NSString *type = info[UIImagePickerControllerMediaType];
    if ([type isEqualToString:@""]) {
//        [self showLoadingViewWithText:@"正在上传头像..."];
        
        //先把图片转成NSData
        UIImage *imageTmp = nil;
        imageTmp = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
           //之后开始上传头像
            [weakSelf uploadUserImage:imageTmp];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//上传头像
- (void)uploadUserImage:(UIImage *)uploadImage
{
    __weak typeof(self) weakSelf = self;
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithData:UIImagePNGRepresentation(uploadImage)], 0.2);
    //上传的url
    NSString *url = [NSString stringWithFormat:@""];
    //地址加密
    NSString *urlPath = @"进行加密";
    
}

@end
