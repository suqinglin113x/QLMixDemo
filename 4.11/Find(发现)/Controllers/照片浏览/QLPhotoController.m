//
//  QLPhotoController.m
//  4.11
//
//  Created by 苏庆林 on 17/5/10.
//  Copyright © 2017年 SU. All rights reserved.
//

#import "QLPhotoController.h"
#import "QLPhotoCell.h"
#import "QLPhotoLayout.h" // 自定义流水布局

@interface QLPhotoController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout; // 系统流水布局

@end

@implementation QLPhotoController

static NSString *const identifier = @"photoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.layout =  ({
        QLPhotoLayout *layout = [[QLPhotoLayout alloc] init];
        layout.itemSize = CGSizeMake(180, 180);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置开始和结尾的内边距
        CGFloat margin = (KScreenSize.width - 160) * 0.5;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.minimumLineSpacing = 30;
        
        layout;
    });
    
    
    self.collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        collectionView.backgroundColor = [UIColor brownColor];
        collectionView.center = self.view.center;
        collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QLPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
        
        self.collectionView = collectionView;
        [self.view addSubview:self.collectionView];
        collectionView;
    });
}

- (UICollectionViewFlowLayout *)createLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(180, 180);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置开始和结尾的内边距
    CGFloat margin = (KScreenSize.width - 160) * 0.5;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = 30;

    return layout;
}
- (void)createCollectionView:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor brownColor];
    collectionView.center = self.view.center;
    collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QLPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    QLPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[QLPhotoCell alloc] init];
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%ld", indexPath.item];
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QL__Func__;
}
@end
