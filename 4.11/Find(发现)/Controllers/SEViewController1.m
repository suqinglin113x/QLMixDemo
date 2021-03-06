//
//  SEViewController1.m
//  4.11
//
//  Created by SU on 16/9/13.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "SEViewController1.h"
#import "WXApi.h"


@interface SEViewController1 ()<WXApiDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

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




- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //修改占位符位置 待fix
    searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 0);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 10, 100, 30)];
    searchBar.placeholder = @"试试事实上";
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = self;
//    searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(-100, 1);
//        searchBar.searchTextPositionAdjustment = UIOffsetMake(100, 0);
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.tintColor = [UIColor orangeColor];
    
    //修改searchbar文字属性、光标
    for (UIView *view in searchBar.subviews){
        QLLog(@"%@", view.subviews);
        for (id subview in view.subviews){
            if ( [subview isKindOfClass:[UITextField class]] ){
                
                //文字大小
                [(UITextField *)subview setFont:[UIFont systemFontOfSize:20]];
                
                //placeholder颜色
                NSAttributedString *attri = [[NSAttributedString alloc] initWithString:searchBar.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor purpleColor], NSFontAttributeName: [UIFont systemFontOfSize:13]}];
                [(UITextField *)subview setAttributedPlaceholder:attri];
                
                //修改文本框文字内容颜色
                [(UITextField *)subview setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
                
                break;
            }
        }
    }

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:nil];
    rightItem.tintColor = [UIColor blackColor];
    [rightItem setTitleTextAttributes:@{
                                        NSForegroundColorAttributeName:[UIColor blackColor],
                                        NSFontAttributeName:[UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithObjects:@"谁念西风独自凉,萧萧黄叶闭疏窗,沉思往事立残阳",@"被酒莫惊春睡重,赌书消得泼茶香,当时只道是寻常",@"等闲变却故人心,却道故人心易变",@"谁念西风独自凉,萧萧黄叶闭疏窗,沉思往事立残阳",@"被酒莫惊春睡重,赌书消得泼茶香,当时只道是寻常",@"等闲变却故人心,却道故人心易变",nil];
    }
    return _dataSourceArray;
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
    _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
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
    return self.dataSourceArray.count;
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

#pragma mark ---行编辑--
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
    
    //设置分享
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if ([WXApi isWXAppInstalled]) {
            
           
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"我的简书";
            message.description = @"笔记and技术收藏";
            [message setThumbImage:[UIImage imageNamed:@"jianshu.png"]];
            WXWebpageObject *webPageObject = [WXWebpageObject object];
            webPageObject.webpageUrl = @"http://www.jianshu.com/";
            message.mediaObject = webPageObject;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req];
        }else{
            [MBProgressHUD showMessage:@"尚未安装微信"];
        }
        
    }];
    
    return @[deleteRowAction, collectRowAction, topRowAction, shareAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
