//
//  QLPhotoCell.m
//  4.11
//
//  Created by 苏庆林 on 17/5/10.
//  Copyright © 2017年 SU. All rights reserved.
//

#import "QLPhotoCell.h"

@interface QLPhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@end
@implementation QLPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setImage:(UIImage *)image
{
    _image = image;
    _photoView.image = image;
}

@end
