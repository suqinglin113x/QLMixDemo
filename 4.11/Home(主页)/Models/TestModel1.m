//
//  testModel1.m
//  4.11
//
//  Created by SU on 16/7/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "TestModel1.h"
#import <objc/message.h>

@implementation TestModel1

- (void)pushObject:(NSString *)obj
{
    TestModel1 *testModel = [[TestModel1 alloc] init];
    [testModel pushObject:@2];
    
    
    [_array addObject:@2];  // 应将@2换成@"2"
   
    
    NSMutableString *str = _array.lastObject;  //前面的array不加__kondof这里会出现警告
    NSLog(@"%@",str);
    
    u_int count;
    
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSLog(@"%@",propertyList);
    
    
    
    
    // objc_msgSend()报错Too many arguments to function cal
    //Build Setting--> Apple LLVM 6.0 - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO
    objc_msgSend(testModel, @selector(test));
}

- (void)test
{
    id object ;
    objc_storeWeak(&object, object);
    
    objc_msgSend(self, @selector(pushObject:));
    IMP imp = class_getMethodImplementation(object_getClass(self), @selector(pushObject:));
    
}

- (TestModel1 *(^)(NSInteger))add
{
    return ^ id(NSInteger num){
        self.result += num;
        return self;
    };
}
- (TestModel1 *(^)(NSInteger))minus
{
    return ^id (NSInteger num){
        self.result -= num;
        return self;
    };
}
@end
