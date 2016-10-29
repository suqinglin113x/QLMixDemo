//
//  QLCommonMethod.h
//  4.11
//
//  Created by SU on 16/5/10.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface QLCommonMethod : NSObject

@property (nonatomic, strong)NSObject *categoryProperty;



/**
 *  判断路径是否存在
 */
+ (BOOL) fileIsExist:(NSString *)suffixPath;

/**
 *  获取路径
 */
+ (NSString *) filePath:(NSString *)suffixPath;

//设备信息
/**
 *  设备型号，可通过苹果review
 */
+ (NSString *)getDeviceVersion;

+ (void)logProjectFontName;
//根据文字返回frame大小
+ (CGRect)calculateStrRect:(NSString *)str;

- (NSString *)hexStringWithColor:(UIColor*)FromColor Alpha:(BOOL)withAlpha;

- (void)eat;
@end
