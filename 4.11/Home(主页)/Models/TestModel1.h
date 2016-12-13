//
//  testModel1.h
//  4.11
//
//  Created by SU on 16/7/7.
//  Copyright © 2016年 SU. All rights reserved.
//


/**
 *  测试xcode7新的特性 ： 泛型 和 __kindof 修饰符
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef  NSInteger age;
/**
 *  <ObjectType:NSNumber*> 存放的数据NSNumber对象
 */
@interface TestModel1 <ObjectType:NSNumber*>: NSObject
{
   
}
/**
 *  <__kindof NSString*> array 存放的数据类型为字符串型
 */
@property(nonatomic, strong)NSMutableArray<__kindof NSString*> *array;
@property(nonatomic)age a;

@property (nonatomic, assign) NSInteger result;
/**链式编程 采用block方式，返回值为类对象本身*/
@property (nonatomic, readonly, copy) TestModel1 *(^add)(NSInteger num);
@property (nonatomic, readonly, copy) TestModel1 *(^minus)(NSInteger num);

- (void)pushObject:(ObjectType)obj;



+ (UIColor *)colorFromHexRGB:(NSString *)incolorString;


@end
TestModel1 *te();
