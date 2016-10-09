//
//  SViewControllerDemo2.m
//  4.11
//
//  Created by SU on 16/9/26.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SViewControllerDemo2.h"
#import "QLFlowLayout.h"
#import "FallWaterCell.h"

@interface SViewControllerDemo2 ()<UICollectionViewDelegate,UICollectionViewDataSource,QLFlowLayoutDelagate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation SViewControllerDemo2
{
    NSMutableArray *dataList;
    NSMutableArray *sectionOne;
    NSMutableArray *heightArr; //存储所有高度的数组
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"瀑布流";
    
    [self initData];
    [self initView];

}

- (void)initData
{
    if (!dataList) {
        dataList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [dataList removeAllObjects];
    if (!heightArr) {
        heightArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [heightArr removeAllObjects];
    for (int i = 0; i < 32; i++) {
        [dataList addObject:[NSString stringWithFormat:@"%zi.JPG",i]];
        CGFloat height = 100 + (arc4random()%100);
        [heightArr addObject:[NSString stringWithFormat:@"%f",height]];
    }
}

- (void)initView
{
    QLFlowLayout *layout = [[QLFlowLayout alloc] init];
    layout.delagate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    [_collectionView registerClass:[FallWaterCell class] forCellWithReuseIdentifier:@"FallWaterCell"];
    

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataList.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FallWaterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FallWaterCell" forIndexPath:indexPath];
    cell.imageName = [dataList objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - <QLFlowLayoutDelagate>
/**
 *  返回每个item的高度
 */

- (CGFloat)waterFallLayout:(QLFlowLayout *)layout heightForItemAtIndex:(NSInteger)index width:(CGFloat)width
{
    return [heightArr[index] doubleValue];
}

//- (UIEdgeInsets)edgInsetsOfWaterFallLayout:(QLFlowLayout *)layout
//{
//    return UIEdgeInsetsMake(0, 30, 30, 10);
//}
@end

