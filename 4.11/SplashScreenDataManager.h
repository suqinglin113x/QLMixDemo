//
//  SplashScreenDataManager.h
//  
//
//  Created by SU on 16/9/9.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SplashScreenDataManager : NSObject

@property (nonatomic, strong)NSArray *resultArray;
@property (nonatomic, strong)NSString *documentPath;
@property (nonatomic, strong)UIImageView *splashImageView;
@property (nonatomic, copy)NSString *imageUrl;

+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName imageLinkUrl:(NSString *)imageLinkUrl imageDeadline:(NSString *)imageDeadLine;

+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;

+ (void)getAdvertisingImageData;

+ (NSString *)getFilePathWithImageName:(NSString *)imageName;

@end
