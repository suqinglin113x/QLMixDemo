//
//  SViewController2demo1.m
//  4.11
//
//  Created by SU on 16/9/19.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SViewController2demo1.h"
#import "Demo1Cell.h"

#define  Demo1CellID @"Demo1Cell"

@interface SViewController2demo1 ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic, strong)UICollectionView *collectionView;

@end

@implementation SViewController2demo1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"网格视图";
    [self initView];
}

- (void)initView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(KScreenSize.width/2-10, KScreenSize.width/2-10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
     
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor orangeColor];
    
    self.collectionView = collectionView;
    
    [self.view addSubview:collectionView];
    
    /*注意：regist放在最后完成*/
    [self.collectionView registerClass:[Demo1Cell class] forCellWithReuseIdentifier:Demo1CellID];
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 31;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Demo1Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Demo1CellID forIndexPath:indexPath];
    if(!cell){
        cell = [[Demo1Cell alloc] init];
    }
    [cell setImageWithName:@"2" content:[NSString stringWithFormat:@"{%zi,%zi}",indexPath.section,indexPath.row]];
    return cell;
}
@end
