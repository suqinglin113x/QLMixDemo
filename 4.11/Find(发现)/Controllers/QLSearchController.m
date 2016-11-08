//
//  QLSearchController.m
//  4.11
//
//  Created by SU on 16/11/7.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLSearchController.h"
#import "QLCarGroup.h"
#import "QLCar.h"
#import "WXApi.h"


@interface QLSearchController ()

/*数据源*/
@property (nonatomic, strong) NSMutableArray *dataList;

/*搜索数据源*/
@property (nonatomic, strong) NSMutableArray *searchList;

/*搜索控制器*/
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation QLSearchController

#pragma mark --懒加载--
- (NSMutableArray *)dataList
{
    if (_dataList == nil) {
        //加载plist文件
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total" ofType:@"plist"];
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *groupArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            QLCarGroup *group = [QLCarGroup groupWithDict:dict];
            [groupArr addObject:group];
        }
        _dataList = groupArr;
    }
    return _dataList;
}

- (UISearchController *)searchController
{
    if (_searchController == nil) {
        //ios8.0以上
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        self.tableView.tableHeaderView = self.searchController.searchBar;
        
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    
    //移除分割线
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    self.tableView.separatorColor = [UIColor redColor];
    
}

// 导航栏编辑的点击
- (void)backItemClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark tableView代理---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QLCarGroup *group = self.dataList[section];
    return group.cars.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cellidentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    QLCarGroup *group = self.dataList[indexPath.section];
    QLCar *car = group.cars[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    //设置cell选中颜色
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //自定义
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:@"cellback.gif"]];
    
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    QLCarGroup *group = self.dataList[section];
    return group.title;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //索引文字颜色
    tableView.sectionIndexColor = [UIColor orangeColor];
    //索引背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor purpleColor];
    //点击索引颜色
    tableView.sectionIndexTrackingBackgroundColor = [UIColor greenColor];
    
    return [self.dataList valueForKeyPath:@"title"];
}

#pragma mark ---行编辑--
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QLCarGroup *group = self.dataList[indexPath.section];
    QLCar *car = group.cars[indexPath.row];
    
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [group.cars removeObjectAtIndex:indexPath.row];
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
        [group.cars exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        NSIndexPath *firstPath = [NSIndexPath indexPathForItem:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstPath];
        [self.tableView reloadData];
        [MBProgressHUD showMessage:@"已置顶" toView:self.view];
    }];
    
    //设置按钮的背景颜色
    topRowAction.backgroundColor = [UIColor blueColor];
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    //设置分享
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        if ([WXApi isWXAppInstalled]) {
            
            
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"车车";
            message.description = @"车简介😯";
            [message setThumbImage:[UIImage imageNamed:car.icon]];
            WXWebpageObject *webPageObject = [WXWebpageObject object];
            webPageObject.webpageUrl = @"https://darielchen.github.io/SwiftManual/";
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
@end
