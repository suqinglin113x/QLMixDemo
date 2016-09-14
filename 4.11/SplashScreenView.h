//
//  SplashScreenView.h
//  
//
//  Created by SU on 16/9/9.
//
//

#import <UIKit/UIKit.h>

static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
static NSString *const adDeadline = @"adDeadline";

@interface SplashScreenView : UIView

/*显示广告页面方法*/
- (void)showSplashScreenWithTimer:(NSInteger)ADShowTime;

/**广告的显示时间*/
@property(nonatomic, assign)NSInteger ADShowTime;

/**图片路径*/
@property(nonatomic, copy)NSString *imgFilePath;

//图片对应的url地址
@property(nonatomic, copy)NSString *imgLinkUrl;

//广告图的有效时间
@property(nonatomic, copy)NSString *imgDeadLine;
@end
