//
//  QLFlowLayout.h
//  4.11
//
//  Created by SU on 16/9/26.
//  Copyright © 2016年 SU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QLFlowLayout;

@protocol QLFlowLayoutDelagate <NSObject>

@required

//返回index位置下的item高度
- (CGFloat)waterFallLayout:(QLFlowLayout *)layout heightForItemAtIndex:(NSInteger)index width:(CGFloat)width;

@optional
//返回瀑布流的列数
- (NSInteger)columnCountOfWaterFallLlayout:(QLFlowLayout *)layout;

//返回行间距
- (CGFloat)rowMarginOfWaterFallLayout:(QLFlowLayout *)layout;

//返回列间距
- (CGFloat)columnMarginOfWaterFallLayout:(QLFlowLayout *)layout;

//返回边缘间距
- (UIEdgeInsets)edgInsetsOfWaterFallLayout:(QLFlowLayout *)layout;

@end

@interface QLFlowLayout : UICollectionViewFlowLayout

/*代理*/
@property (nonatomic, weak) id <QLFlowLayoutDelagate> delagate;

@end
