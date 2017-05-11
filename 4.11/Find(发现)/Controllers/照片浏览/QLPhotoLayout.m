//
//  QLPhotoLayout.m
//  4.11
//
//  Created by 苏庆林 on 17/5/10.
//  Copyright © 2017年 SU. All rights reserved.
//

#import "QLPhotoLayout.h"

@implementation QLPhotoLayout

// 重写他的方法，扩展功能

// 计算cell的布局，不经常调用
- (void)prepareLayout
{
    [super prepareLayout];
    
}

// 指定一个区域，确定其中cell的尺寸
// 可以一次性返回所有cell的尺寸
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获得区域内的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect: self.collectionView.bounds];
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        // 计算到中心点距离
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width *0.5);
        // 计算缩放比例
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width *0.5) *0.25;
        
        // 缩放转换
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrs; // count = 3
}

// 当手指离开屏幕时才调用(所以此处取contentOffset得值不准确)：确定最终偏移量，
// velocity:手指滑动速度
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSLog(@"%f %f", proposedContentOffset.x, self.collectionView.contentOffset.x);
    // 获取最终显示的区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    // 获得区域内的cell
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    
    CGFloat MINMARGIN = MAXFLOAT;

    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 计算到中心点距离
        CGFloat delta = (attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width *0.5;
        if (fabs(delta) < fabs(MINMARGIN)) {
            MINMARGIN = delta;
        }
    }
    proposedContentOffset.x += MINMARGIN;
    return proposedContentOffset;
}

// 在滚动的时候是否允许刷新布局，默认NO
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//
- (CGSize) collectionViewContentSize
{
    return [super collectionViewContentSize];
}
@end
