//
//  QLFlowLayout.m
//  4.11
//
//  Created by SU on 16/9/26.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLFlowLayout.h"

static const CGFloat QLDefaultColumnCount = 3; //列数
static const CGFloat QLDefaultRowMargin = 10; //行间距
static const CGFloat QLDefaultColumnMargin = 10; //列间距
static const UIEdgeInsets QLDefaultEdgeInsets = {10, 10, 10, 10}; //


@interface QLFlowLayout ()

{
    struct { //记录代理书否响应选择器
        BOOL didRespondColumnCount:1;
        BOOL didRespondColumnMArgin:1;
        BOOL didRespondRowMargin:1;
        BOOL didRespondEdgeInsets:1;
    } _delegateFlags;
}

/** cell的布局属性数组*/
@property(nonatomic, strong)NSMutableArray *attrsArray;

/** 每列的高度数组*/
@property(nonatomic, strong)NSMutableArray *columnHeights;

/** 最大Y值*/
@property(nonatomic, assign)CGFloat maxY;

@property(nonatomic, assign)CGFloat height;
@end


@implementation QLFlowLayout

#pragma mark - 懒加载
- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
- (NSMutableArray *)columnHeights

{
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

#pragma mark - layout方法

//准备布局

- (void)prepareLayout
{
    [super prepareLayout];
    
    //初始化列的最大高度数组
    [self setupColumnHeightsArray];
    
    //初始化item布局属性数组
    [self setupAttrsArray];
    
    //设置代理方法的标志
    [self setupDelegateFlags];
    
    //计算最大的Y值
    self.maxY = [self maxYWithColumnmHeightsArray:self.columnHeights];
}

/**
 *  返回rect范围内的item的布局数组，（这个方法会频繁调用）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attrsArray;
}

/**
 *  返回indexPath位置的item布局属性
 */

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //开始计算item的 x, y, width, height
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    CGFloat width = (collectionWidth - [self edgeInsets].left - [self edgeInsets].right - ([self columnCount] -1) *[self columnMargin]) / [self columnCount];
    __block NSUInteger minColumn = 0; //默认最短列为第0列
    __block CGFloat minHeight = MAXFLOAT;
    
    //计算当前item应该放在哪一列
    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { //遍历找出最小高度的列
        CGFloat height = [obj doubleValue];
        if (minHeight > height) {
            minHeight = height;
            minColumn = idx;
        }
    }];
    
    CGFloat height = [self.delagate waterFallLayout:self heightForItemAtIndex:indexPath.item width:width];
    CGFloat x = [self edgeInsets].left + minColumn * ([self columnMargin] + width);
    CGFloat y = minHeight + [self rowMargin];
    
    attrs.frame = CGRectMake(x, y, width, height);
    
    self.height = height;
   
   
    //更新数组中的最短列高度
    self.columnHeights[minColumn] = @(y + height);
    
    return attrs;
}

/**
 *  返回collectionView的contentSize
 */
- (CGSize)collectionViewContentSize
{
//    NSLog(@"%f",self.maxY);
    return CGSizeMake(0, self.maxY + [self edgeInsets].bottom);
}

//得到最大列的高度
- (CGFloat)maxYWithColumnmHeightsArray:(NSArray *)array
{
    __block CGFloat maxY = 0;
    [_columnHeights enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([heightNumber doubleValue] > maxY) {
            maxY = [heightNumber doubleValue];
            QLLog(@"%f",maxY);
        }
    }];
    return maxY;
}
#pragma mark - 私有方法
/**
 *  因为返回代理方法调用的频率非常频繁，所以prepareLayout的时候设置一次标示，调用代理方法的时候就直接判断即可，可提高效率
 */
- (void)setupDelegateFlags
{
    _delegateFlags.didRespondEdgeInsets = [self.delagate respondsToSelector:@selector(edgInsetsOfWaterFallLayout:)];
    _delegateFlags.didRespondRowMargin = [self.delagate respondsToSelector:@selector(rowMarginOfWaterFallLayout:)];
    _delegateFlags.didRespondColumnCount = [self.delagate respondsToSelector:@selector(columnCountOfWaterFallLlayout:)];
    _delegateFlags.didRespondColumnMArgin = [self.delagate respondsToSelector:@selector(columnMarginOfWaterFallLayout:)];
}



- (void)setupColumnHeightsArray
{
    // 清空最大高度数组
    [self.columnHeights removeAllObjects];
    
    // 初始化列高度
    for (int i = 0; i < [self columnCount]; i++) {
        [self.columnHeights addObject:@([self edgeInsets].top)];
    }
}

- (void)setupAttrsArray
{
    //清空item布局属性数组
    [self.attrsArray removeAllObjects];
    
    // 计算item的attrs
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            
            [self.attrsArray addObject:attrs];
        }
    }
}


#pragma mark - 根据情况返回参数

- (CGFloat)columnMargin
{
    return _delegateFlags.didRespondColumnMArgin ? [self.delagate columnMarginOfWaterFallLayout:self] : QLDefaultColumnMargin;
}

- (CGFloat)rowMargin
{
    return _delegateFlags.didRespondRowMargin ? [self.delagate rowMarginOfWaterFallLayout:self] : QLDefaultRowMargin;
}

- (NSInteger)columnCount
{
    return _delegateFlags.didRespondColumnCount ? [self.delagate columnCountOfWaterFallLlayout:self] : QLDefaultColumnCount;
}

- (UIEdgeInsets)edgeInsets
{

    UIEdgeInsets edginsets = UIEdgeInsetsZero;
    if (_delegateFlags.didRespondEdgeInsets) {
       edginsets = [self.delagate edgInsetsOfWaterFallLayout:self];
    }else
    {
       edginsets = QLDefaultEdgeInsets;
    }
    return edginsets;
}


@end
