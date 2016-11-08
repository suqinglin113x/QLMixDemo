//
//  QLCar.h
//  4.11
//
//  Created by SU on 16/11/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLCar : NSObject

/*图标*/
@property (nonatomic, copy) NSString *icon;

/*名称*/
@property (nonatomic, copy) NSString *name;

+ (instancetype)carWithDict:(NSDictionary *)dict;

@end
