//
//  view1.h
//  4.11
//
//  Created by SU on 16/7/26.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface view1 : UIView
@property(nonatomic, copy)NSString *name;


- (void)createGaussianBlur;
- (void)initRectLayer;

@end
