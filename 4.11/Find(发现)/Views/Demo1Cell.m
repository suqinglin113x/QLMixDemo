//
//  Demo1Cell.m
//  4.11
//
//  Created by SU on 16/9/19.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "Demo1Cell.h"

@interface Demo1Cell ()
@property(nonatomic, strong)UIImageView *imageShow;
@property(nonatomic, strong)UILabel *labelShow;

@end

@implementation Demo1Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
        
        UIImageView *imageShow = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:imageShow];
        _imageShow = imageShow;
        _imageShow.layer.masksToBounds = YES;//图片没这句话它圆不起来
        _imageShow.layer.cornerRadius = 15;
       
        UILabel *labelShow = [[UILabel alloc] initWithFrame:CGRectZero];
        labelShow.font = [UIFont systemFontOfSize:15];
        labelShow.textAlignment = NSTextAlignmentCenter;
        labelShow.textColor = [UIColor whiteColor];
        [self.contentView addSubview:labelShow];
        _labelShow = labelShow;
        
        self.layer.cornerRadius = 20;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageShow.frame = CGRectMake(10, 5, KScreenSize.width/2-30, KScreenSize.width/2-30);
    _labelShow.frame = CGRectMake(10, KScreenSize.width/2-30+5,KScreenSize.width/2-30, 15);
}
- (void)setImageWithName:(NSString *)imageName content:(NSString *)content
{
    _imageShow.image = [UIImage imageNamed:imageName];
    _labelShow.text = content;
}

@end
