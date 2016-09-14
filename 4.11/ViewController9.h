//
//  ViewController9.h
//  4.11
//
//  Created by SU on 16/8/4.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GestureTypeSetting = 1,
    GestureTypeChange = 1,
    GestureTypeLogin = 1,
    
}GestureType;

@interface ViewController9 : UIViewController

/**
 *      CircleViewTypeSetting = 1, // 设置手势密码
        CircleViewTypeLogin,       // 登陆手势密码
        CircleViewTypeVerify       // 验证旧手势密码
 */
@property (nonatomic, assign) GestureType type;


@end

