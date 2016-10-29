//
//  ViewController3.m
//  4.11
//
//  Created by SU on 16/5/20.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController4.h"

@interface UserInfoTableViewItemData : NSObject

@property(nonatomic, copy)NSString              *title;
@property(nonatomic, copy)id                    value;
@property(nonatomic, copy)NSString              *tag;

- (instancetype)initItemDataWithTitle:(NSString *)title Value:(id)value Tag:(NSString *)tag;

@end

@implementation UserInfoTableViewItemData

- (instancetype)initItemDataWithTitle:(NSString *)title Value:(id)value Tag:(NSString *)tag
{
    self.title = title;
    self.value = value;
    self.tag = tag;
    return self;
}

@end

@interface ViewController3 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册",@"拍照", nil];
//    [actionSheet showInView:self.view];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ViewController4 *VC4 = [[ViewController4 alloc] init];
    [self presentViewController:VC4 animated:YES completion:nil];
}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        return;
    }
    switch (buttonIndex) {
        case 0:
        {
            [self openPhotoLibrary];
            break;
        }
        case 1:
        {
            [self openCamera];
            break;
        }
        default:
            break;
    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (void)openPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarPosition:3 barMetrics:0];
    }];
}

- (void)openCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
    else{
        //提示无法使用相机
    }
}

#pragma mark UIImagePickerControlerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self) weakSelf = self;
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        __weak typeof(self) weakSelf = self;
        //先把图片转换成NSdata
        UIImage *imgTmp = nil;
        if (picker.allowsEditing)
        {
            imgTmp = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            imgTmp = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //截图保存到相册
//        UIImageWriteToSavedPhotosAlbum(imgTmp, self, nil, nil);
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            [weakSelf uploadUserAvatarImage:imgTmp];
        }];
    }
}

- (void)uploadUserAvatarImage:(UIImage *)avatarImage
{
    __weak typeof(self) weakSelf = self;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
