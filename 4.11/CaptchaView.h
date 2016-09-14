//
//  CaptchaView.h
//  4.11
//
//  Created by SU on 16/8/19.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptchaView : UIView


@property (nonatomic, retain)NSArray *changeArray;//
@property (nonatomic, retain)NSMutableString *changeString;//

- (void)changeCaptcha;
@end
