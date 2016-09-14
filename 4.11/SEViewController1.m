//
//  SEViewController1.m
//  4.11
//
//  Created by SU on 16/9/13.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SEViewController1.h"

@interface SEViewController1 ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)UIImageView *headerBackView;
@property (nonatomic, strong)UIImageView *photoImageView;
@property (nonatomic, strong)UILabel *userNameLabel;
@property (nonatomic, strong)UILabel *introduceLabel;
@property (nonatomic, strong)UIView *tableViewHeaderView;
@property (nonatomic, assign)NSInteger imageHeight;
@end

@implementation SEViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _dataSourceArray = [NSMutableArray arrayWithObjects:@"谁念西风独自凉,萧萧黄叶闭疏窗,沉思往事立残阳",@"被酒莫惊春睡重,赌书消得泼茶香,当时只道是寻常",@"等闲变却故人心,却道故人心易变",@"谁念西风独自凉,萧萧黄叶闭疏窗,沉思往事立残阳",@"被酒莫惊春睡重,赌书消得泼茶香,当时只道是寻常",@"等闲变却故人心,却道故人心易变",nil];
    
}

- (void)loadView
{
    [super loadView];
    _imageHeight = 160;//背景图片的高度
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [self createTableViewHeaderView];
}

- (void)createTableViewHeaderView
{
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenSize.width, _imageHeight)];
    _headerBackView = [[UIImageView alloc] init];
    //背景图
    _headerBackView.frame = CGRectMake(0, 0, KScreenSize.width, _imageHeight);
    _headerBackView.image = [UIImage imageNamed:@"2"];
    [_tableViewHeaderView addSubview:_headerBackView];
    
    _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenSize.width - 62)/2, 15, 62, 62)];
    [_tableViewHeaderView addSubview:_photoImageView];
    
    _photoImageView.layer.cornerRadius = 31;
    _photoImageView.layer.masksToBounds = YES;
    _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    _photoImageView.autoresizesSubviews = YES;
    
    _photoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    _photoImageView.image = [[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _photoImageView.frame.origin.y + _photoImageView.frame.size.height + 8 , KScreenSize.width, 20 )];
    _userNameLabel.text = @"纳兰性德";
    
    _userNameLabel.textAlignment = 1;
    _userNameLabel.font = [UIFont systemFontOfSize:16  ];
    _userNameLabel.textColor = [UIColor whiteColor];
    [_tableViewHeaderView addSubview:_userNameLabel];
    
    
    
    _introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenSize.width - 229 )/2, _userNameLabel.frame.origin.y + _userNameLabel.frame.size.height + 10 , 229 , 16 )];
    _introduceLabel.alpha = .7;
    _introduceLabel.text = @"人生若只如初见，何事秋风悲画扇";
    _introduceLabel.textAlignment = 1;
    _introduceLabel.font = [UIFont systemFontOfSize:12 ];
    _introduceLabel.textColor = _userNameLabel.textColor;
    [_tableViewHeaderView addSubview:self.introduceLabel];
    
    self.tableView.tableHeaderView = _tableViewHeaderView;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        CGFloat totalOffset = _imageHeight + ABS(offsetY);
        CGFloat scale = totalOffset/_imageHeight;
        _headerBackView.frame = CGRectMake(- (width * scale - width)/2, offsetY, width*scale, totalOffset);//拉伸后的图片的frame应该是同比例缩放。
    }
}

#pragma mark 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSourceArray[indexPath.row];
    return cell;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_dataSourceArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        QLLog(@"已删除");
        [MBProgressHUD showMessage:@"已删除" toView:self.view];
        
    }];
    
    //设置收藏
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        collectRowAction.backgroundColor = [UIColor greenColor];
        [MBProgressHUD showMessage:@"已收藏" toView:self.view];
    }];
    
    //设置置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [_dataSourceArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        NSIndexPath *firstPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstPath];
        [_tableView reloadData];
        [MBProgressHUD showMessage:@"已置顶" toView:self.view];
    }];
    
    //设置按钮的背景颜色
    topRowAction.backgroundColor = [UIColor blueColor];
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    return @[deleteRowAction, collectRowAction, topRowAction];
}
@end
