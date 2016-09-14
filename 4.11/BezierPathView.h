//
//  BezierPathView.h
//  4.11
//
//  Created by SU on 16/9/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, QLBezierPathType) {
    kDefaultPath = 1, //三角形
    kRectPath = 2, //矩形
    kCirclePath = 3,//圆
    kOvalPath = 4,//椭圆
    kRoundedRectPath = 5,//带圆角的矩形
    kArcPath = 6,//弧
    kSecondBezierpath = 7,//二次贝塞尔曲线
    kThirdBezierPath = 8,//三次贝塞尔曲线
    
};


@interface BezierPathView : UIView

@property(nonatomic, assign)QLBezierPathType type;

@end
