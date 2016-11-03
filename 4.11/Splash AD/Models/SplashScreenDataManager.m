//
//  SplashScreenDataManager.m
//  
//
//  Created by SU on 16/9/9.
//
//

#import "SplashScreenDataManager.h"
#import "SplashScreenView.h"

@implementation SplashScreenDataManager

/**
 *  判断文件是否存在
 */
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManage fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告界面
 */
+ (void)getAdvertisingImageData
{
    NSArray *imageArray = @[@"http://img1.126.net/channel6/2016/022471/0805/2.jpg?dpi=6401136", @"http://image.woshipm.com/wp-files/2016/08/555670852352118156.jpg"];
    NSString *imageUrl = imageArray[0];
    NSString *imageLinkUrl = @"http://www.jianshu.com/users/73145ff36491/timeline";
    NSString *imageDeadLine = @"09/30/2016 14:25";
    
    //获取图片名
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    //拼接沙河路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist) {
        [self downloadAdImageWithUrl:imageUrl imageName:imageName imageLinkUrl:imageLinkUrl imageDeadline:imageDeadLine];
     
    }
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
/**
 *  下载新图片
 *
 *  @param imageUrl      开屏图片地址
 *  @param imageName     图片名字
 *  @param imageLinkUrl  广告链接地址
 *  @param imageDeadLine 图片过期时间
 */
+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName imageLinkUrl:(NSString *)imageLinkUrl imageDeadline:(NSString *)imageDeadLine
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName];
        BOOL success = [UIImageJPEGRepresentation(image, 0) writeToFile:filePath atomically:YES];
        if (success) {
            if (![imageName isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:adImageName]]) {
                
                [self deleteOldImage];
            }
            
            [[NSUserDefaults standardUserDefaults] setValue:imageDeadLine forKey:adDeadline];
            [[NSUserDefaults standardUserDefaults] setValue:imageLinkUrl forKey:adUrl];
            [[NSUserDefaults standardUserDefaults] setValue:imageName forKey:adImageName];
        }
        else{
            NSLog(@"保存失败");
        }
        
    });
}
/**
 *  删除旧图片
 */
+ (void)deleteOldImage
{
    NSString *imageName = [[NSUserDefaults standardUserDefaults] objectForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        
        NSFileManager *manageer = [NSFileManager defaultManager];
        [manageer removeItemAtPath:filePath error:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:adImageName];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:adUrl];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:adDeadline];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}
/**
 *  根据图片名字拼接 文件路径
 */
 + (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [path stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}
@end
