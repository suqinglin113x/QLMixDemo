//
//  QLInfinitRollScrollView.h
//  4.11
//
//  Created by SU on 16/11/11.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    QLInfinitRollScrollViewTypePortrait,    //竖roll
    QLInfinitRollScrollViewTypelandscape,   //横roll
} QLInfinitRollScrollViewType;

@class QLInfinitRollScrollView;
@protocol QLInfinitRollScrollViewDelegate <NSObject>

@optional
/**点击图片*/
- (void)infinitRollScrollView:(QLInfinitRollScrollView *)scrollView tapImageWithInfo:(id)info;
@end



@interface QLInfinitRollScrollView : UIView

/**需要显示的图片资源*/
@property (nonatomic, strong) NSArray *imageArray;

/**是否竖屏，默认NO*/
@property (nonatomic, assign) QLInfinitRollScrollViewType rollDirectionType;

/**页码指示器*/
@property (nonatomic, strong) UIPageControl *pageControl;

/**需要imageView的总数*/
@property (nonatomic, assign) NSInteger imageViewCount;

/**图片对应的model*/
@property (nonatomic, strong) NSMutableArray *imageModelInfoArr;

/**代理*/
@property (nonatomic, weak) id <QLInfinitRollScrollViewDelegate> delegate;

@end
