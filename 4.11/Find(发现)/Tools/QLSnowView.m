//
//  QLSnowView.m
//  4.11
//
//  Created by SU on 16/11/25.
//  Copyright © 2016年 SU. All rights reserved.
//

/**
 *  说明：下雪效果
 */

#import "QLSnowView.h"

@interface QLSnowView ()
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation QLSnowView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self createEmitter];
    
}

- (void)createEmitter
{
    
    self.clipsToBounds = NO;
    self.userInteractionEnabled = NO;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"snow";
    cell.contents = (id)[UIImage imageNamed:@"favorite"].CGImage;
    cell.lifetime = 10.f;
    cell.lifetimeRange = 100.f;
    cell.birthRate = 10;
    cell.velocity = 10;
    cell.velocityRange = 10.f;
    cell.emissionRange = M_PI_2;
    cell.yAcceleration = 2;
    cell.scale = 0.5f;
    cell.scaleRange = 0.02;
    
    
    _emitterLayer = [CAEmitterLayer layer];
    _emitterLayer.emitterMode = kCAEmitterLayerSurface; //layer弹出方式
    _emitterLayer.emitterSize = CGSizeMake(self.bounds.size.width *2, 100);
    _emitterLayer.emitterShape = kCAEmitterLayerLine; //layer形状
    _emitterLayer.emitterPosition = CGPointMake(100, -40);
    _emitterLayer.emitterCells = @[cell];
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    _emitterLayer.masksToBounds = NO;
    _emitterLayer.frame = [UIScreen mainScreen].bounds;
    
    [self.layer addSublayer:_emitterLayer];
    
}


- (void)startAnimation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.emitterLayer.beginTime = CACurrentMediaTime();
        CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"emitterCells.snow.birthRate"];
        baseAni.fromValue = @0;
        baseAni.toValue = @1000;
        [_emitterLayer addAnimation:baseAni forKey:nil];
    });
}


@end
