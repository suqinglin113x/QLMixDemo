//
//  NSObject+Property.h
//  4.11
//
//  Created by SU on 16/9/6.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary;
+ (NSDictionary *)replaceKeyFromPropertyName;
+ (NSDictionary *)objectClassInArray;
@end
