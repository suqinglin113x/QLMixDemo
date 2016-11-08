//
//  QLCar.m
//  4.11
//
//  Created by SU on 16/11/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLCar.h"

@implementation QLCar


+ (instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
