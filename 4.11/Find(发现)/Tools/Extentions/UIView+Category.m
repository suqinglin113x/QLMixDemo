//
//  UIView+Category.m
//  4.11
//
//  Created by SU on 16/12/2.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)


- (void)setAnchorPointTo:(CGPoint)point
{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) *self.frame.size.width, (point.y - self.layer.anchorPoint.y) *self.frame.size.height);
    self.layer.anchorPoint = point;
}
@end
