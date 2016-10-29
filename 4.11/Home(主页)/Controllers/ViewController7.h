//
//  ViewController7.h
//  4.11
//
//  Created by SU on 16/6/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController7 : UIViewController
-(void)getlistPage:(NSInteger)page andsuccess:(void(^)(NSArray *array,BOOL isnextpage))success andfaile:(void(^)(NSError *error))faile;

@end
typedef NSString * MobTypeString;
extern MobTypeString const mobsina;
static const NSInteger tag = 19;