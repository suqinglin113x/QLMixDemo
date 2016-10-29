//
//  QLCollectionViewFlowLayout.m
//  4.11
//
//  Created by SU on 16/9/5.
//  Copyright © 2016年 SU. All rights reserved.
//  实现 section  header 的顶部悬停

#import "QLCollectionViewFlowLayout.h"

@implementation QLCollectionViewFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        _naviHeight = 64.f;
    }
    return self;
}

//YES :标示一旦滚动就实时调用下面这个layoutAttributesForElementsInRect: 方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //UIcollectionViewLayoutAttributes ：我称它为collectionView中的item （包括cell和header、footer）的《结构信息》
    //截取到父类所返回的数组（里面含有当前屏幕所展示的item的结构信息），并转化成不可变的数组
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    //创建存索引的数组，无符号，无序，不可重复（重复的话会自动过滤）
    NSMutableIndexSet *unsignHeaderSecrions = [NSMutableIndexSet indexSet];
    
    //遍历superArray，得到一个当前屏幕中所有的section数组
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        //如果当前的元素是cell，将cell所在的分区section加入数组，重复的自动过滤
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [unsignHeaderSecrions addIndex:attributes.indexPath.section];
        }
    }
    
    //遍历superArray，将当前屏幕中拥有的header的section从数组中移除，得到一个当前屏幕中没有header的section数组
    //正常情况下，随着手指往上移，header脱离屏幕会被系统回收而cell尚在，也会触发该方法
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        //如果当前的元素是一个header，将header所在的section从数组中移除
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [unsignHeaderSecrions removeIndex:attributes.indexPath.section];
        }
    }
    
    //遍历当前屏幕中没有header的section数组
    [unsignHeaderSecrions enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
       //取到当前section中的第一个item的indexpath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        //获取当前section在正常情况下已经离开屏幕的header结构信息
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        //如果当前分区确实有离开屏幕而被系统回收的header
        if (attributes){
            //将该header结构信息重新加入到superArray
            [superArray addObject:attributes];
        }
    }];
    
    //遍历superArray，改变header结构信息中的参数，使它可以在当前section还没完全离开屏幕的时候一直显示
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        //如果当前item是header
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            //得到当前header所在分区的cell的数量
            NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
            //得到第一个item的indexPath
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
            //得到最后一个item的indexPath
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:attributes.indexPath.section];
            //得到第一个和最后一个的结构信息
            UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
            if (numberOfItemsInSection>0) {
                //cell有值。则获取第一个和最后一个cell的结构信息
                firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            }
            else{
                //cell没值，则新建一个attributes
                firstItemAttributes = [UICollectionViewLayoutAttributes new];
                //
                CGFloat y = self.sectionInset.top + CGRectGetMaxY(attributes.frame);
                firstItemAttributes.frame = CGRectMake(0, y, 0, 0);
                //因为只有一个cell，所以最后一个cell等于第一个cell
                lastItemAttributes = firstItemAttributes;
            }
            
            //获取当前header的frame
            CGRect rect = attributes.frame;
            //当前滑动距离+导航栏
            CGFloat offset = self.collectionView.contentOffset.y + _naviHeight;
            //第一个cell的
            CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - self.sectionInset.top;
            
            CGFloat maxY = MAX(offset, headerY);
            
            //最后一个cell的
            CGFloat headerMissingY = lastItemAttributes.frame.origin.y + self.sectionInset.bottom - rect.size.height;
            
            rect.origin.y = MIN(maxY, headerMissingY);
            //给header的结构信心赋值
            attributes.frame = rect;
            
            //
            attributes.zIndex = 7;
        }
    }
    
    return [superArray copy];
}
@end
