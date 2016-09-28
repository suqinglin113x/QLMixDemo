//
//  FallWaterCell.m
//  4.11
//
//  Created by SU on 16/9/26.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "FallWaterCell.h"

@interface FallWaterCell ()
@property(nonatomic, strong)UIImageView *imageView;
@end

@implementation FallWaterCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.contentView.frame;
}

- (void)setImageName:(NSString *)imageName
{
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
