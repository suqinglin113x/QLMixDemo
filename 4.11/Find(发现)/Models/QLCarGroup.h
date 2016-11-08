//
//  QLCarGroup.h
//  4.11
//
//  Created by SU on 16/11/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLCarGroup : NSObject

/*里面装着QLCar模型*/
@property (nonatomic, strong) NSMutableArray *cars;

/*组标题*/
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end
