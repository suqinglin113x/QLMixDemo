
//  ViewController2.m
//  4.11
//
//  Created by SU on 16/4/22.
//  Copyright © 2016年 SU. All rights reserved.
//
#define ScreenSize [UIScreen mainScreen].bounds.size

#import "ViewController2.h"
#import "ViewController.h"
#import "ViewController3.h"

void myAlert(NSString *name, NSString *age){
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:name message:age preferredStyle:0];
                                
    [alertVC addAction:[[UIAlertAction alloc]init]];
    [alertVC preferredAction];
}
@interface ViewController2 ()<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray                    *pickerOneArr;
    NSMutableArray                    *pickerTwoArr;
    NSMutableArray                    *pickerThressArr;
}
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
    
    
    UIPickerView *pickView = [[UIPickerView alloc]init];
    pickView.delegate = self;
    pickView.backgroundColor = [UIColor redColor];
    pickView.frame = CGRectMake(0, 50, ScreenSize.width, 150);
    [self.view addSubview:pickView];
    
}






//pickView列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//每组的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 1)
    {
        return 5;
    }
    if (component == 0)
    {
        return 6;
    }
    else
    {
        return 5;
    }
}

//pickView的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [UIScreen mainScreen].bounds.size.width *0.33;
}
//高度
 -(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return @"省";
    }
    if (component == 1) {
        return @"县";
    }
    return @"乡";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        pickerTwoArr = [[pickerOneArr objectAtIndex:row] objectForKey:@"city"];
        if (pickerTwoArr.count > 0) {
            pickerThressArr = [[pickerTwoArr objectAtIndex:0] objectForKey:@"area"];
        }else
        {
            [pickerThressArr removeAllObjects];
        }
        [pickerView reloadAllComponents];
    }
    else if (component == 1)
    {
        pickerThressArr = [[pickerTwoArr objectAtIndex:row] objectForKey:@"area"];
        [pickerView reloadComponent:2];
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLab = (UILabel *)view;
    if (!pickerLab) {
        pickerLab = [[UILabel alloc]init];
        pickerLab.minimumScaleFactor = 8.f;
        pickerLab.adjustsFontSizeToFitWidth = YES;
        pickerLab.layer.cornerRadius = 10.0;
        pickerLab.layer.borderColor = [UIColor greenColor].CGColor;
        pickerLab.layer.borderWidth = 3.0;
        pickerLab.clipsToBounds = YES;
        [pickerLab setTextAlignment:NSTextAlignmentCenter];
        [pickerLab setFont:[UIFont boldSystemFontOfSize:15]];
        [pickerLab setBackgroundColor:[UIColor grayColor]];
    }
    pickerLab.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLab;
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"不要输入低于4个或者高于16个" message:@"您输入的昵称格式有误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
   
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            
            [self presentViewController:[[ViewController3 alloc]init] animated:YES completion:nil];
            
        });
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



/**
 *  暂停动画
 *  UILabel *labelOne = [UILabel alloc] init};
 *  CALayer *layer = labelOne.layer;
 *  @param layer 是当前控件所在的layer
 */
- (void)pauseAnimation :(CALayer *)layer
{
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //层的停止时间为上面设置的pasuse时间
    layer.timeOffset = pauseTime;
    //当前层的速度
    layer.speed = 0;
    
}

/**
 *  开始动画
 */
- (void)startAnimation :(CALayer *)layer
{
    CFTimeInterval pauseTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    
    //这几个属性必须全部写上
    layer.speed = 1.0;
    layer.timeOffset = 0;
    layer.beginTime = 0;
    
    layer.beginTime = timeSincePause;
    
    
}




+ (void)run
{
    NSLog(@"run");
}
+ (void)cry
{
    NSLog(@"cty");
}
@end
