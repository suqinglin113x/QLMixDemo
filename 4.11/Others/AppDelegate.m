//
//  AppDelegate.m
//  4.11
//
//  Created by SU on 16/4/11.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "AppDelegate.h"

//weixin
#import "WXApi.h"

//ios10  推送
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

//开屏广告
#import "SplashScreenDataManager.h"
#import "SplashScreenView.h"

//左右侧滑
#import "SWRevealViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"


#import "ViewController.h"
#import "SecondController.h"
#import "ThirdController.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate, WXApiDelegate> //代理

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//     //ios10 前
//    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
//        
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
//        
//        [application registerUserNotificationSettings:settings];
//    }
    
    
    //ios10 推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        //授权
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                QLLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    QLLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                QLLog(@"注册失败");
            }
        }];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //iOS8系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    // 加载tabbar
    [self initTabBar];
    
    //只加载一次广告页面
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"loadAD"]){
        //开屏广告
        [self loadAd];
    }
    
    
    
    //注册微信
    [WXApi registerApp:@"wxfb636c50cdc9ba61"];
    
    
    return YES;
}

-(void)initTabBar
{
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:nil tag:10001];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[SecondController new]];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:nil tag:1002];
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[ThirdController new]];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:nil tag:1003];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav2, nav1, nav3];
    
    
    
    self.window.rootViewController = tabBarController;
    
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    //应用在前台收到通知 NSLog(@"========%@", notification);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    //点击通知进入应用 NSLog(@"response:%@", response);
}

#pragma mark --广告页---
- (void)loadAd
{
    //     启动页停留1秒
    [NSThread sleepForTimeInterval:1];
    
    NSString *filePath = [SplashScreenDataManager getFilePathWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:adImageName]];
    BOOL exist = [SplashScreenDataManager isFileExistWithFilePath:filePath];
    
    if (exist) {
        SplashScreenView *advertiseView = [[SplashScreenView alloc] initWithFrame:self.window.bounds];
        advertiseView.imgFilePath = filePath;
        advertiseView.imgLinkUrl = [[NSUserDefaults standardUserDefaults] valueForKey:adUrl];
        advertiseView.imgDeadLine = [[NSUserDefaults standardUserDefaults] valueForKey:adDeadline];
    
        [advertiseView showSplashScreenWithTimer:3];
    }
    
    //无论沙河中是否存在广告图片，都需要重新调用广告接口，判断是否需要更新
    [SplashScreenDataManager getAdvertisingImageData];
    
    //存储广告加载次数，下次不再加载
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"loadAD"];
}


/**添加本地通知*/

-(void)addLocalNotification{
    
    //ios10 之后的通知
    if (currentSystemVersion >= 10.0) {
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @" Just K K Kidding U !";
        content.subtitle = @"iOS10 本地推送";
        content.body = @"谁念西风独自凉，萧萧黄叶闭疏窗。";
        content.badge = @1;
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cellback" ofType:@"gif"];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
        if (error) {
            QLLog(@"attachment error: %@", error.description);
        }
        content.attachments = @[attachment];
        content.launchImageName = @"cellback.gif";
        //设置声音(可自定制)
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        content.sound = sound;
        //触发模式
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5.0 repeats:NO];
        //设置request
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"request" content:content trigger:trigger];
        //发送本地通知
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                QLLog(@"本地通知error：%@", error.description);
            }
        }];
    }
    
    else{
        
        //注册通知 iOS8 ~ iOS10
        //定义本地通知对象
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        //设置调用时间
        notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:5.0];//通知触发的时间，10s以后
        //设置本地通知的时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        //通知重复次数
        notification.repeatInterval = 2;
        notification.applicationIconBadgeNumber = 1;//应用程序图标右上角显示的消息数
        notification.repeatCalendar = [NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
        
        //设置通知属性
        notification.alertBody = @"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
        notification.alertAction = @"打开应用"; //待机界面的滑动动作提示
        notification.alertLaunchImage = @"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
        //notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
        notification.soundName = @"msg.caf";//通知声音（需要真机才能听到声音）
        
        //设置用户信息
        notification.userInfo = @{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
        
        //执行通知注册
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
        //立即触发一个通知
        //    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    
}

// 此方法通用
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //获得返回的device token
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    QLLog(@"注册远程推送失败！");
}
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self addLocalNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    application.applicationIconBadgeNumber = 0;
    
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --调微信--
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

/*
 *  当其他APP通过应用跳转打开该APP时调用
 *  @param  app      应用对象
 *  @param  url      跳转打开该APP的url
 *  @param  return   是否允许打开该APP
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark ---weixin delegate ---
- (void)onReq:(BaseReq *)req
{
    
}
- (void)onResp:(BaseResp *)resp
{
    
}

@end
