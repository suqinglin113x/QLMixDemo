//
//  QLExplosionView.m
//  4.11
//
//  Created by SU on 16/11/25.
//  Copyright © 2016年 SU. All rights reserved.
//

/**
 *  说明：可用于点赞功能爆炸效果
 */

#import "QLExplosionView.h"

@interface QLExplosionView ()
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;
@end
@implementation QLExplosionView

- (void)setup {
    self.clipsToBounds = NO;
    self.userInteractionEnabled = NO;
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    
    explosionCell.lifetime = 0.7;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 0;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.contents = (id)[[UIImage imageNamed:@"Sparkle"] CGImage];
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;
    
    _explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.emitterPosition = self.center;
    _explosionLayer.name = @"emitterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize = CGSizeMake(25, 0);
    _explosionLayer.emitterCells = @[explosionCell];
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    _explosionLayer.seed = 1366128504;
    [self.layer addSublayer:_explosionLayer];
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}


#pragma mark - Methods

- (void)animate {
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

- (void)explode {
    self.explosionLayer.beginTime = CACurrentMediaTime();
    [self.explosionLayer setValue:@500 forKeyPath:@"emitterCells.explosion.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

- (void)stop {
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}
@end
