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
@property (nonatomic, assign, getter=issysLayoutStyle) BOOL sysLayoutStyle;

@end

@implementation QLPhotoController

static NSString *const identifier = @"photoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加一个按钮
    UIButton *seleLayoutStyleBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, 70, 150, 30) title:@"改变流水布局模式" target:self sel:@selector(switchLayoutStytle:)];
    [self.view addSubview:seleLayoutStyleBtn];
    
    // block式创建
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

// 正常方法创建
- (UICollectionViewFlowLayout *)createLayout:(UICollectionViewFlowLayout *)layout
{
    layout.itemSize = CGSizeMake(180, 180);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置开始和结尾的内边距
    CGFloat margin = (KScreenSize.width - 160) * 0.5;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = 30;

    return layout;
}
- (UICollectionView *)createCollectionView:(UICollectionViewFlowLayout *)layout
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
    return collectionView;
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
    [self addBigPhotoViewWithIndex:indexPath];
}

#pragma mark - Action

// 添加大图片
- (void)addBigPhotoViewWithIndex:(NSIndexPath *)indexPath
{
    // 背景scroll
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.frame;
    /* 子视图透明图不受影响
     1.用一张半透明的图片做背景。
     2.使用colorWithWhite：alpha：类方法
     3.使用colorWithRed:green:blue:alpha:类方法
     4.使用colorWithAlphaComponent:实例方法
     */
    scroll.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:scroll];
    
//    // 添加大的流水布局
//    UICollectionViewFlowLayout *lay = [self createLayout:[[QLPhotoLayout alloc] init]];
//    lay.itemSize = CGSizeMake(KScreenSize.width, KScreenSize.width);
//    UICollectionView *coll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lay];
//    [scroll addSubview:coll];
//    coll.dataSource = self;
//    coll.center = self.view.center;
//    coll.bounds = CGRectMake(0, 0, KScreenSize.width, KScreenSize.width);
//    [coll registerNib:[UINib nibWithNibName:NSStringFromClass([QLPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    // 图片显示img
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectZero];
    im.center = self.collectionView.center;
    im.bounds = CGRectMake(0, 0, KScreenSize.width, KScreenSize.width);
    NSString *imageName = [NSString stringWithFormat:@"%ld", indexPath.item];
    im.image = [UIImage imageNamed:imageName];
    [scroll addSubview:im];
//
//    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [scroll addGestureRecognizer:tap];
//    im.userInteractionEnabled = YES;
    [im sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>]
    self.collectionView.hidden = YES;
}
// 手势
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *view = (UIImageView *)tap.view;
    [view removeFromSuperview];
    
    self.collectionView.hidden = NO;
}
// 改变流水
- (void)switchLayoutStytle:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.sysLayoutStyle = btn.selected;
    if (self.sysLayoutStyle == YES) {
        self.layout = [self createLayout:[[UICollectionViewFlowLayout alloc] init]];
    } else {
        self.layout = [self createLayout:[[QLPhotoLayout alloc] init]];
    }
    
    [self.collectionView removeFromSuperview];

    [UIView animateWithDuration:0.5 animations:^{
        self.collectionView = [self createCollectionView:self.layout];
    }];
}


@end
