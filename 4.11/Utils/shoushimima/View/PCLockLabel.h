
#import <UIKit/UIKit.h>

@interface PCLockLabel : UILabel



/*
 *  普通提示信息
 *  type  1字体颜色为红色   2 字体颜色为黑色 3白色
 */
-(void)showNormalMsg:(NSString *)msg andType:(NSInteger)type;


/*
 *  警示信息
 *  type  1字体颜色为红色   2 字体颜色为黑色  3白色
 */
-(void)showWarnMsg:(NSString *)msg andType:(NSInteger)type;

/*
 *  警示信息(shake)
 *  type  1字体颜色为红色   2 字体颜色为黑色  3白色
 */
-(void)showWarnMsgAndShake:(NSString *)msg andType:(NSInteger)type;

@end
