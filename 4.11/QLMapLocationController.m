//
//  QLMapLocationController.m
//  4.11
//
//  Created by SU on 16/10/27.
//  Copyright © 2016年 SU. All rights reserved.
//

#import "QLMapLocationController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "QLAnnotation.h"


@interface QLMapLocationController ()<CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UITextFieldDelegate>

//定位管理者
@property (nonatomic, strong) CLLocationManager *locationManage;

//地图
@property (nonatomic, strong) MKMapView *mapView;

//当前中心经纬度
@property (nonatomic) CLLocationCoordinate2D currentCoordinate;

@end

@implementation QLMapLocationController

/* 懒加载定位管理者对象 */
- (CLLocationManager *)locationManage
{
    if (!_locationManage) {
        _locationManage = [[CLLocationManager alloc] init];
    }
    return _locationManage;
}

/* 懒加载地图对象 */
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navigationItem.title = @"地图定位";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addMapLocation];
    
    [self createUI];
    
}

- (void)createUI
{
    UILabel *coordinateLabel = [QLViewCreateTool createLabelWithFrame:CGRectZero title:nil];
    coordinateLabel.tag = 100;
    [self.view addSubview:coordinateLabel];
    
    UILabel *addressLabel = [QLViewCreateTool createLabelWithFrame:CGRectZero title:nil];
    addressLabel.tag = 101;
    [self.view addSubview:addressLabel];
    
    //重置按钮
    UIButton *resetAddressBtn = [QLViewCreateTool createButtonWithFrame:CGRectMake(10, KScreenSize.height - 45, KScreenSize.width - 20, 44) title:@"重新定位" target:self sel:@selector(resetAddressInfo)];
    [self.view addSubview:resetAddressBtn];
    
    //搜索框🔍
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 130, KScreenSize.width - 20, 50)];
    searchBar.tag = 102;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.barTintColor = [UIColor greenColor];
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
}

- (void)addMapLocation
{
    //添加地图
    [self.view addSubview:self.mapView];
    self.mapView.frame = CGRectMake(5, KScreenSize.height - KScreenSize.width - 10 - 45, KScreenSize.width - 10, KScreenSize.width - 10);
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置代理
    self.mapView.delegate = self;
    
    //是否支持定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        QLLog(@"定位服务当前尚未打开，请设置中打开!");
        return;
    }
    //是否授权使用定位
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        
        [self.locationManage requestWhenInUseAuthorization];
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
        
        //设置代理
        self.locationManage.delegate = self;
        
        //notice：定位频率和定位精度并不应当越精确越好，需要视实际情况而定，因为越精确越耗性能，也就越费电。
        //设置定位精度
        self.locationManage.desiredAccuracy = kCLLocationAccuracyBest;
        
        //设置定位频率，多大范围内定位更新
        CLLocationDistance distance = 1.0f;
        self.locationManage.distanceFilter = distance;
        
        //启动定位
        [self.locationManage startUpdatingLocation];
        
    }
}

- (void)addAnnotation
{
    
    QLAnnotation *annotation = [[QLAnnotation alloc] init];
    [self.mapView addAnnotation:annotation];
}

- (void)resetAddressInfo
{
    self.locationManage = nil;
    [self addMapLocation];
}


#pragma mark ----CLLocationManagerDelegate----风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️------

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    self.currentCoordinate = location.coordinate;
    double latitude = _currentCoordinate.latitude;
    double longitude = _currentCoordinate.longitude;
    QLLog(@"latitude:%f, longitude:%f", latitude, longitude);
    
    UILabel *coordinateLabel = (UILabel *)[self.view viewWithTag:100];
    coordinateLabel.numberOfLines = 0;
    coordinateLabel.text = [NSString stringWithFormat:@"经度：%f，纬度：%f", latitude, longitude];
    coordinateLabel.frame = CGRectMake(10, 70, KScreenSize.width - 20, 30);
    
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    __block CLPlacemark * placeMark = nil;
    //反地理编码
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        placeMark = [placemarks firstObject];
        
        UILabel *adressLabel = (UILabel *)[self.view viewWithTag:101];
        adressLabel.numberOfLines = 0;
        adressLabel.text = [NSString stringWithFormat:@"%@", placeMark.name];
        CGSize textSize = [QLCommonMethod calculateStrRect:placeMark.name].size;
        adressLabel.frame = CGRectMake(10, 110, KScreenSize.width -20, textSize.height + 5);
        
        QLLog(@"name:%@",placeMark.name);
    }];
    
    
    //关闭定位
    [self.locationManage stopUpdatingLocation];
}


#pragma mark --MKMapViewDelegate----风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️---

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //iOS8后不需要进行中心点的指定，默认会将当前位置设置中心点并自动设置显示区域范围
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    self.mapView.region = MKCoordinateRegionMake(coordinate, span);

    
}

- (void)searchNeighborPlace:(NSString *)searchText
{
    //检索请求
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    //检索范围
    request.region = MKCoordinateRegionMakeWithDistance(self.currentCoordinate, 1000, 1000);
    //兴趣点
    request.naturalLanguageQuery = searchText;
    
    //初始化检索
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    //开始检索
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        //兴趣点数组
        NSArray *array = [NSArray arrayWithArray:response.mapItems];
        for (MKMapItem *item in array) {
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.title = item.name;
            point.subtitle = item.phoneNumber;
            point.coordinate = item.placemark.coordinate;
            
            [self.mapView addAnnotation:point];
        }
    }];
}

#pragma mark ---UISearchBarDelegate---风儿吹吹🍃🍃🍃🍃🍃🍃，雪儿飘飘❄️❄️❄️❄️❄️❄️---
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchNeighborPlace:searchBar.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    for (UIView *view in (UISearchBar *)[self.view viewWithTag:102].subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [(UITextField *)view resignFirstResponder];
        }
    }
    return YES;
}
@end
