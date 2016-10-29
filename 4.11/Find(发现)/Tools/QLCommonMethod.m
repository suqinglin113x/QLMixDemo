//
//  QLCommonMethod.m
//  4.11
//
//  Created by SU on 16/5/10.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLCommonMethod.h"
#import <sys/utsname.h>
@implementation QLCommonMethod


+ (BOOL)fileIsExist:(NSString *)suffixPath
{
    NSString *path = [self filePath:suffixPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)filePath:(NSString *)suffixPath
{
    NSString *path = NSHomeDirectory();
    if (suffixPath != nil)
    {
        path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",suffixPath]];
    }
    else
    {
        path = [path stringByAppendingPathComponent:@"Library/Caches/"];
    }
    return path;
}

+ (NSString *)getDeviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine
                                                encoding:NSUTF8StringEncoding];
    
    if([@"i386" isEqualToString:deviceString]) return @"32-bit Simulator";
    if([@"x86_64" isEqualToString:deviceString]) return @"64-bit Simulator";
    if([@"iPod1,1" isEqualToString:deviceString]) return @"iPod Touch";
    if([@"iPod2,1" isEqualToString:deviceString]) return @"iPod Touch Second Generation";
    if([@"iPod3,1" isEqualToString:deviceString]) return @"iPod Touch Third Generation";
    if([@"iPod4,1" isEqualToString:deviceString]) return @"iPod Touch Fourth Generation";
    if([@"iPhone1,1" isEqualToString:deviceString]) return @"iPhone";
    if([@"iPhone1,2" isEqualToString:deviceString]) return @"iPhone 3G";
    if([@"iPhone2,1" isEqualToString:deviceString]) return @"iPhone 3GS";
    if([@"iPad1,1" isEqualToString:deviceString]) return @"iPad";
    if([@"iPad2,1" isEqualToString:deviceString]) return @"iPad 2";
    if([@"iPad3,1" isEqualToString:deviceString]) return @"3rd Generation iPad";
    if([@"iPhone3,1" isEqualToString:deviceString]) return @"iPhone 4 (GSM)";
    if([@"iPhone3,3" isEqualToString:deviceString]) return @"iPhone 4 (CDMA/Verizon/Sprint)";
    if([@"iPhone4,1" isEqualToString:deviceString]) return @"iPhone 4S";
    if([@"iPhone5,1" isEqualToString:deviceString]) return @"iPhone 5 (model A1428, AT&T/Canada)";
    if([@"iPhone5,2" isEqualToString:deviceString]) return @"iPhone 5 (model A1429, everything else)";
    if([@"iPad3,4" isEqualToString:deviceString]) return @"4th Generation iPad";
    if([@"iPad2,5" isEqualToString:deviceString]) return @"iPad Mini";
    if([@"iPhone5,3" isEqualToString:deviceString]) return @"iPhone 5c (model A1456, A1532 | GSM)";
    if([@"iPhone5,4" isEqualToString:deviceString]) return @"iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)";
    if([@"iPhone6,1" isEqualToString:deviceString]) return @"iPhone 5s (model A1433, A1533 | GSM)";
    if([@"iPhone6,2" isEqualToString:deviceString]) return @"iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)";
    if([@"iPad4,1" isEqualToString:deviceString]) return @"5th Generation iPad (iPad Air) - Wifi";
    if([@"iPad4,2" isEqualToString:deviceString]) return @"5th Generation iPad (iPad Air) - Cellular";
    if([@"iPad4,4" isEqualToString:deviceString]) return @"2nd Generation iPad Mini - Wifi";
    if([@"iPad4,5" isEqualToString:deviceString]) return @"2nd Generation iPad Mini - Cellular";
    if([@"iPhone7,1" isEqualToString:deviceString]) return @"iPhone 6 Plus";
    if([@"iPhone7,2" isEqualToString:deviceString]) return @"iPhone 6";
    return @"unkonwn";
}

+ (void)logProjectFontName
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
}

//
- (NSString *)getFilePath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths firstObject];
    if (fileName) {
        filePath = [filePath stringByAppendingPathComponent:fileName];
    }
    return filePath;
}

//格式化数字
- (NSString *)formateNumber:(double)number
{
    NSNumberFormatter *numFormate = [[NSNumberFormatter alloc] init];
    numFormate.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *resultNum = [numFormate stringFromNumber:[NSNumber numberWithDouble:number]];
    //
    NSRange range = [resultNum rangeOfString:@"."];
    if (range.length) {
        return resultNum;
    }
    else{
        return [NSString stringWithFormat:@"%@.00f",resultNum];
    }
}

//格式化日期
- (NSString *)formateDate:(NSString *)fromDateStr
{
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    dateFormate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate  *date = [dateFormate dateFromString:fromDateStr];//string转date
    NSString *dateString = [dateFormate stringFromDate:date]; //date转string
    return dateString;
}


- (NSDate *)getdate:(NSString *)dateStr
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
   NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:[NSDate date]];
    dateComponents.day = 0;
    dateComponents.year = 0;
    dateComponents.month = 0;
    NSDate *date = [calendar dateFromComponents:dateComponents];
    return date;
}
//上一个月日期
- (void)getLastMonthDate
{
    NSDate *mydate = [NSDate date];
    
    NSCalendar *calen = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *ad = [[NSDateComponents alloc] init];
    
    ad.year = 0;
    ad.month = -1; //前一个月
    ad.day = 0;
    
    NSDate *date = [calen dateByAddingComponents:ad toDate:mydate options:0];
    NSLog(@"%@",date);
}
//字符串utf8
- (NSString *)UTF8:(NSString *)fromStr
{
    return [fromStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)toJsonData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization JSONObjectWithData:theData options:NSJSONReadingMutableContainers error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
    
}

- (NSString *)description
{
    return @"";
}

//根据文字返回frame大小
+ (CGRect)calculateStrRect:(NSString *)str 
{
    CGSize textSize = CGSizeMake(KScreenSize.width - 20, 0);
    NSDictionary *attributes = @{NSFontAttributeName :[UIFont systemFontOfSize:defaultFontSize]};
    CGRect textRect = [str boundingRectWithSize:textSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil];
    return textRect;
}

//截屏
- (UIImage *)screenShot
{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(KScreenSize.width*screenScale, KScreenSize.height*screenScale), YES, 0);
    
    //设置截屏大小
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, KScreenSize.width*screenScale, KScreenSize.height*screenScale);
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *sendImage = [UIImage imageWithCGImage:imageRefRect];
    
    CGImageRelease(imageRefRect);
    viewImage = nil;
    
    return sendImage;
}



/**
 *  在runtime中动态注册类
 */
- (void)runtime
{
//    Class superClass = NSClassFromString(@"login");
//    objc_allocateClassPair(superClass, <#const char *name#>, <#size_t extraBytes#>)
//    objc_registerClassPair(<#__unsafe_unretained Class cls#>)
    
    
}

//使用runtime给现有类添加weak属性
- (void)xx_addWeakAssociation:(id)object forKey:(NSString *)key
{
    
    __weak id weakObject = object;
//    key.hash
    objc_setAssociatedObject(self, &key, ^{
        return weakObject;
    }, OBJC_ASSOCIATION_COPY);
    
}


//网址含中文
- (NSString *)UTF8string:(NSString *)urlPath
{
    NSString *urlString = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //iOS10 上边的方法弃用
    if (currentSystemVersion >= 10.0) {
        urlString = [urlPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    return urlString;
}

// YYKIT 中返回hex颜色
- (NSString *)hexStringWithColor:(UIColor*)FromColor Alpha:(BOOL)withAlpha {
    CGColorRef color = FromColor.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(CGColorGetAlpha(FromColor.CGColor) * 255.0 + 0.5)];
    }
    return hex;
}
+ (NSDictionary *)replaceKeyFromPropertyName
{
    return @{@"ID":@"id"};
}





 
 //动态添加类方法
//void eat(id self, SEL _cmd)
//{
//    
//}
//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//    if (sel == @selector(eat)) {
//        class_addMethod(self, @selector(eat), (IMP) eat, "v@:");
//    }
//    return [super resolveClassMethod:sel];
//}

 
@end
