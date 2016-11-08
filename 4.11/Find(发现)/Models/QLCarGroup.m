//
//  QLCarGroup.m
//  4.11
//
//  Created by SU on 16/11/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLCarGroup.h"
#import "QLCar.h"

@implementation QLCarGroup

- (instancetype)initWithDict:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        NSArray *arr = dict[@"cars"];
        NSMutableArray *temArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            QLCar *car = [QLCar carWithDict:dict];
            [temArr addObject:car];
        }
        self.cars = temArr;
    }
    return self;
}
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
