//
//  QLSpread.h
//  4.11
//
//  Created by SU on 16/11/29.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QLSpreadTransitionType) {
    QLSpreadTransitionTypePresent = 0,
    QLSpreadTransitionTypeDismiss = 1,
    QLSpreadTransitionTypePush = 2,
    QLSpreadTransitionTypePop = 3
};

@interface QLSpread : NSObject < UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, assign) QLSpreadTransitionType type;

+ (instancetype)transitionWithTransitionType:(QLSpreadTransitionType)type;

- (instancetype)initWithTransitionType:(QLSpreadTransitionType)type;
@end
