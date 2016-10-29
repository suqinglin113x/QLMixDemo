//
//  NSObject+Property.m
//  4.11
//
//  Created by SU on 16/9/6.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)


+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary
{
    id obj = [[self alloc] init];
    
    //获取所有的成员变量
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    
    for (unsigned int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        
        //取出的成员变量去掉 下划线
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        id value = dictionary[key];
        
        //但这个值为空时，判断一下是否执行了replaceKeyFromPropertyName协议，
        if (!value) {
            if ([self respondsToSelector:@selector(replaceKeyFromPropertyName)]) {
                NSString *replaceKey = [self replaceKeyFromPropertyName][key];
                value = dictionary[replaceKey];
            }
        }
        
        //字典嵌套字典
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSString *type = [NSString stringWithUTF8String:ivar_getName(ivar)];
            NSRange range = [type rangeOfString:@"\""];
            type = [type substringFromIndex:range.location + range.length];
            range = [type rangeOfString:@"\""];
            type = [type substringToIndex:range.location];
            Class modelClass = NSClassFromString(type);
            if (modelClass) {
                value = [modelClass objectWithDictionary:value];
            }
        }
        
        //字典套数组
        if ([value isKindOfClass:[NSArray class]]) {
            if ([self respondsToSelector:@selector(objectClassInArray)]) {
                NSMutableArray *models = [NSMutableArray array];
                NSString *type = [self objectClassInArray][key];
                Class modelClass = NSClassFromString(type);
                for (NSDictionary *dict in value) {
                    id model = [modelClass objectWithDictionary:dict];
                    [models addObject:model];
                }
                value = models;
            }
        }
        
        if (value) {
            [obj setValue:value forKey:key];
        }
    }
    
    //释放ivar
    free(ivars);
    return obj;
}

@end
