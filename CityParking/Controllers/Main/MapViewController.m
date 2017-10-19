//
//  MapViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/29.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MapViewController.h"
#import "public.h"

@interface MapViewController ()<UIGestureRecognizerDelegate,BMKPoiSearchDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,SecondViewControllerDelegate,RKDropdownAlertDelegate>{
    CLLocationCoordinate2D  mapCenter;
    CLLocation              * i_userLocation;
    BMKLocationService      * _locService;
    BMKPoiSearch            * _poisearch;
    BMKNearbySearchOption   * option1;
    BMKNearbySearchOption   * option2;
    BMKNearbySearchOption   * option3;
    NSMutableArray          * dataArr;
    NSMutableArray          * pointArr;
    NSInteger               collectionSelectIndex;
    NSInteger               callBackNumeber;
}

@property (nonatomic, strong) SecondViewController      *vc;

// 用来显示阴影的view，里面装的是self.vc.view
@property (nonatomic, strong) UIView                    *shadowView;

@property (nonatomic, strong) UISwipeGestureRecognizer  *swipe1;

@property (nonatomic, strong) UIPanGestureRecognizer    *pan;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnToBottomDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeight;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@end

@implementation MapViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString * logStatus = [[NSUserDefaults standardUserDefaults] objectForKey:IS_LOGINSUCCESS];
    if (logStatus == nil || ![logStatus isEqualToString:@"YES"]) {
        UIViewController * loginVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    _poisearch.delegate = self;
    //设置打开抽屉模式
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poisearch.delegate = nil;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    dataArr  = [NSMutableArray array];
    pointArr = [NSMutableArray array];
    [self addChildViewController:self.vc];
    [self.shadowView addSubview:self.vc.view];
    [self.view addSubview:self.shadowView];
    _mapViewHeight.constant = Y3;
    _btnToBottomDistance.constant = CollectionHeight + 30;
    [self.vc didClickTextField:^{
        
        //        NSLog(@"receive-----------");
        [UIView animateWithDuration:0.4 animations:^{
            
            self.shadowView.frame = CGRectMake(0, 50, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
        }completion:^(BOOL finished) {
            // 呼出键盘。  一定要在动画结束后调用，否则会出错
            [self.vc.search becomeFirstResponder];
        }];
        // 更新offsetY
        self.vc.offsetY = self.shadowView.frame.origin.y;
        
    }];
    [self initMapView];
}

#pragma mark RKDropdownAlertDelegate
-(BOOL)dropdownAlertWasDismissed {
    return YES;
}

-(BOOL)dropdownAlertWasTapped:(RKDropdownAlert*)alert {
    return YES;
}

// table可滑动时，swipe默认不再响应 所以要打开
- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    float stopY = 0;     // 停留的位置
    float animateY = 0;  // 做弹性动画的Y
    float margin = 10;   // 动画的幅度
    float offsetY = self.shadowView.frame.origin.y; // 这是上一次Y的位置
    //    NSLog(@"==== === %f == =====",self.vc.table.contentOffset.y);
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        //        NSLog(@"==== down =====");
        
        // 当vc.table滑到头 且是下滑时，让vc.table禁止滑动
        if (self.vc.table.contentOffset.y == 0) {
            self.vc.table.scrollEnabled = NO;
        }
        
        if (offsetY >= Y1 && offsetY < Y2) {
            // 停在y2的位置
            stopY = Y2;
        }else if (offsetY >= Y2 ){
            // 停在y3的位置
            stopY = Y3;
        }else{
            stopY = Y1;
        }
        animateY = stopY + margin;
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        //        NSLog(@"==== up =====");
        
        if (offsetY <= Y2) {
            // 停在y1的位置
            stopY = Y1;
            // 当停在Y1位置 且是上划时，让vc.table不再禁止滑动
            self.vc.table.scrollEnabled = YES;
        }else if (offsetY > Y2 && offsetY <= Y3 ){
            // 停在y2的位置
            stopY = Y2;
        }else{
            stopY = Y3;
        }
        animateY = stopY - margin;
    }
    [self.vc.search resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        
        self.shadowView.frame = CGRectMake(0, animateY, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
        
        _btnToBottomDistance.constant = SCREEN_HEIGHT - animateY+10;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.shadowView.frame = CGRectMake(0, stopY, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
            _btnToBottomDistance.constant = SCREEN_HEIGHT - stopY+10;
        }];
    }];
    // 记录shadowView在第一个视图中的位置
    self.vc.offsetY = stopY;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"-----------  ------------");
    // searchBar收起键盘
    UIButton *cancelBtn = [self.vc.search valueForKey:@"cancelButton"]; //首先取出cancelBtn
    // 代码触发Button的点击事件
    [cancelBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark SecondViewControllerDelegate
-(void)collectionDidSelectWithIndex:(NSInteger)index {
    collectionSelectIndex = index;
    [self getDataWithCollectSelectIndex:index ShowHUD:YES];
}

- (void)getDataWithCollectSelectIndex:(NSInteger)index ShowHUD:(BOOL)showHUD{
    switch (index) {//停车场 PMK、神州租车 SZZC、立体 LTK、慢行 MX
        case 0:{
            [self GetMapDataWithType:nil ShowHUD:showHUD];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTrainWithNotification) name:@"getTrainWithNotification" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTaxiWithNotification) name:@"getTaxiWithNotification" object:nil];
        }
            break;
        case 1:{
            [self GetMapDataWithType:@"PMK" ShowHUD:showHUD];
        }
            break;
        case 2:{
            [self GetMapDataWithType:@"SZZC" ShowHUD:showHUD];
        }
            break;
        case 3:{
            [self GetMapDataWithType:@"SZZC" ShowHUD:showHUD];
        }
            break;
        case 4:{
            [self GetMapDataWithType:@"LTK" ShowHUD:showHUD];
        }
            break;
        case 5:{
            [self GetMapDataWithType:@"MX" ShowHUD:showHUD];
        }
            break;
        case 6:{
            [dataArr removeAllObjects];
            [self getBusPOIInfo];
        }
            break;
        case 7:{
            [dataArr removeAllObjects];
            [self getTrainPOIInfo];
        }
            break;
        case 8:{
            [dataArr removeAllObjects];
            [self getTaxiPOIInfo];
        }
            break;
            
        default:
            break;
    }
}

-(void)GetMapDataWithType:(NSString *)type ShowHUD:(BOOL)showHUD{
    [dataArr removeAllObjects];
    NSDictionary * paramas = @{@"lat":[NSString stringWithFormat:@"%f",mapCenter.latitude],
                               @"lng":[NSString stringWithFormat:@"%f",mapCenter.longitude],
                               @"pageNo":@"1",
                               @"pageSize":@"20"};
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/ratecod/queryAllParking" AndParams:paramas IfShowHUD:showHUD Success:^(NSDictionary *responseObject) {
        NSArray * objectArr = responseObject[@"data"];
        if (objectArr != nil) {
            for (NSDictionary * tempObject in objectArr) {
                MarkModel * model = [MarkModel modelObjectWithDictionary:tempObject];
                if (type != nil) {
                    if ([model.ptype isEqualToString:type]) {
                        [dataArr addObject:model];
                    }
                }else {
                    [dataArr addObject:model];
                }
            }
            if (collectionSelectIndex == 1 || collectionSelectIndex == 3 || collectionSelectIndex == 4 || collectionSelectIndex == 5) {
                [[NSNotificationCenter defaultCenter] postNotificationName:GetMapDataSuccessed object:dataArr];
                [_menuBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
                [_menuBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateSelected];
            }
            [self addAnnotationToMapWithData:dataArr];
        } else {
            [RKDropdownAlert title:@"当前范围内未找到结果" message:@"" backgroundColor:COLOR_WITH_HEX(0x417293) textColor:nil time:1 delegate:self];
        }
        if (type == nil) {
            [self getBusPOIInfo];
        }
    } Failure:^(NSString *errorInfo) {
        if (type == nil) {
            [self getBusPOIInfo];
        }
    }];
}

- (void)getTrainWithNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getTrainWithNotification" object:nil];
    [self getTrainPOIInfo];
}

- (void)getTaxiWithNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getTaxiWithNotification" object:nil];
    [self getTaxiPOIInfo];
}

- (void)getBusPOIInfo {
    option1 = [[BMKNearbySearchOption alloc]init];
    option1.pageIndex = 0;
    option1.pageCapacity = 20;
    option1.radius = 3000;
    option1.location = _mapView.centerCoordinate;
    option1.keyword = @"公交";
    BOOL flag = [_poisearch poiSearchNearBy:option1];
    if(flag){
        NSLog(@"公交车检索发送成功");
    }
    else {
        NSLog(@"公交车检索发送失败");
    }
}

- (void)getTrainPOIInfo {
    option2 = [[BMKNearbySearchOption alloc]init];
    option2.pageIndex = 0;
    option2.pageCapacity = 20;
    option2.radius = 3000;
    option2.location = _mapView.centerCoordinate;
    option2.keyword = @"地铁";
    BOOL flag = [_poisearch poiSearchNearBy:option2];
    if(flag){
        NSLog(@"地铁检索发送成功");
    }
    else {
        NSLog(@"地铁检索发送失败");
    }
}

- (void)getTaxiPOIInfo {
    option3 = [[BMKNearbySearchOption alloc]init];
    option3.pageIndex = 0;
    option3.pageCapacity = 20;
    option3.radius = 3000;
    option3.location = _mapView.centerCoordinate;
    option3.keyword = @"出租车";
    BOOL flag = [_poisearch poiSearchNearBy:option3];
    if(flag){
        NSLog(@"出租车检索发送成功");
    }
    else {
        NSLog(@"出租车检索发送失败");
    }
}

- (void)addAnnotationToMapWithData:(NSArray *)arr {
    NSArray * annotationArr = _mapView.annotations;
    if (annotationArr.count) {
        [_mapView removeAnnotations:annotationArr];
    }
    annotationArr = nil;
    
    NSMutableArray * mutableArray = [NSMutableArray array];
    for (MarkModel * model in arr) {
        BMKPointAnnotation * newPoint = [[BMKPointAnnotation alloc] init];
        CLLocationCoordinate2D coor;
        coor.latitude = [model.lat doubleValue];
        coor.longitude = [model.lng doubleValue];
        newPoint.coordinate = coor;
        newPoint.title = model.cname;
        newPoint.subtitle = model.dz;
        [mutableArray addObject:newPoint];
    }
    
    [_mapView addAnnotations:mutableArray];
}

//                                                                                与手势同步地
/**
 返回值为NO  swipe不响应手势 table响应手势
 返回值为YES swipe、table也会响应手势, 但是把table的scrollEnabled为No就不会响应table了
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //    NSLog(@"----------- table =  %f ------------",self.vc.table.contentOffset.y);
    // 触摸事件，一响应 就把searchBar的键盘收起来
    // searchBar收起键盘
    UIButton *cancelBtn = [self.vc.search valueForKey:@"cancelButton"]; //首先取出cancelBtn
    // 代码触发Button的点击事件
    [cancelBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // 当table Enabled且offsetY不为0时，让swipe响应
    if (self.vc.table.scrollEnabled == YES && self.vc.table.contentOffset.y != 0) {
        return NO;
    }
    if (self.vc.table.scrollEnabled == YES) {
        return YES;
    }
    return NO;
}

-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [_startBtn setEnabled:NO];
    [_startBtn setAlpha:0.6];
}

- (IBAction)leftButtonClick:(UIButton *)sender {
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"leftArrow"]]) {
        self.vc.showParkTable = NO;
        [self.vc.table reloadData];
        collectionSelectIndex = 0;
        [self getDataWithCollectSelectIndex:0 ShowHUD:YES];
        [_menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [_menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateSelected];
    } else {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (IBAction)bigButtonClick:(UIButton *)sender {
    [_mapView zoomIn];
}

- (IBAction)smallButtonClick:(UIButton *)sender {
    [_mapView zoomOut];
}

#pragma mark - 懒加载
-(SecondViewController *)vc {
    if (!_vc) {
        _vc = [[SecondViewController alloc] init];
        
        
        // -------------- 添加手势 轻扫手势  -----------
        self.swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        self.swipe1.direction = UISwipeGestureRecognizerDirectionDown ; // 设置手势方向
        
        self.swipe1.delegate = self;
        [_vc.table addGestureRecognizer:self.swipe1];
        
        UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        swipe2.direction = UISwipeGestureRecognizerDirectionUp; // 设置手势方向
        swipe2.delegate = self;
        [_vc.table addGestureRecognizer:swipe2];
        _vc.delegate = self;
    }
    return _vc;
}


-(UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.frame = CGRectMake(0, Y3, self.view.frame.size.width, self.view.frame.size.height);
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(5, 5);
        _shadowView.layer.shadowOpacity = 0.8;                       //      不透明度
    }
    return _shadowView;
}

- (void)initMapView {
    _locService = [[BMKLocationService alloc]init];
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_COMMON]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    [_locService startUserLocationService];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showMapScaleBar = YES;
    _mapView.zoomLevel = 17;
    _mapView.isSelectedAnnotationViewFront = YES;
    //    [_mapView showMapPoi];
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    mapCenter = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    i_userLocation = userLocation.location;
    NSDictionary * location = @{@"lat":[NSString stringWithFormat:@"%.f",userLocation.location.coordinate.latitude],
                                @"lng":[NSString stringWithFormat:@"%.f",userLocation.location.coordinate.longitude]
                                };
    [[NSUserDefaults standardUserDefaults] setObject:location forKey:USER_LOCATION];
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [_locService stopUserLocationService];
    [_startBtn setEnabled:YES];
    [_startBtn setAlpha:1];
    [self getDataWithCollectSelectIndex:collectionSelectIndex ShowHUD:YES];
}

-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated lat %f,long %f zoomLevel %f",_mapView.centerCoordinate.latitude,_mapView.centerCoordinate.longitude,_mapView.zoomLevel);
    mapCenter = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
    [self getDataWithCollectSelectIndex:collectionSelectIndex ShowHUD:NO];
}

-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    [pointArr removeAllObjects];
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            MarkModel * model = [[MarkModel alloc] init];
            model.lat = [NSString stringWithFormat:@"%f",poi.pt.latitude];
            model.lng = [NSString stringWithFormat:@"%f",poi.pt.longitude];
            model.cname = poi.name;
            model.dz = poi.address;
            switch (poi.epoitype) {
                case 0:
                    model.ptype = @"出租车";
                    break;
                case 1:
                    model.ptype = @"公交";
                    break;
                case 3:
                    model.ptype = @"地铁";
                    break;
                default:
                    break;
            }
            [pointArr addObject:model];
        }
        if (!collectionSelectIndex) {
            NSMutableArray * mutableArray = [NSMutableArray array];
            for (MarkModel * model in pointArr) {
                BMKPointAnnotation * newPoint = [[BMKPointAnnotation alloc] init];
                CLLocationCoordinate2D coor;
                coor.latitude = [model.lat doubleValue];
                coor.longitude = [model.lng doubleValue];
                newPoint.coordinate = coor;
                newPoint.title = model.cname;
                newPoint.subtitle = model.dz;
                [mutableArray addObject:newPoint];
            }
            
            [_mapView addAnnotations:mutableArray];
        }else {
            [self addAnnotationToMapWithData:pointArr];
        }
    }
    
    else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD) {
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        if (collectionSelectIndex) {
            NSArray * annotationArr = _mapView.annotations;
            if (annotationArr.count) {
                [_mapView removeAnnotations:annotationArr];
            }
            annotationArr = nil;
            [RKDropdownAlert title:@"当前范围内未找到结果" message:@"" backgroundColor:COLOR_WITH_HEX(0x417293) textColor:nil time:1 delegate:self];
        }
        NSLog(@"起始点有歧义");
    } else {
        if (collectionSelectIndex) {
            NSArray * annotationArr = _mapView.annotations;
            if (annotationArr.count) {
                [_mapView removeAnnotations:annotationArr];
            }
            annotationArr = nil;
            [RKDropdownAlert title:@"当前范围内未找到结果" message:@"" backgroundColor:COLOR_WITH_HEX(0x417293) textColor:nil time:1 delegate:self];
        }
        NSLog(@"抱歉，未找到结果");
    }
    
    if (!collectionSelectIndex) {
        if (!callBackNumeber) {
            callBackNumeber ++;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getTrainWithNotification" object:nil];
        } else {
            callBackNumeber = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getTaxiWithNotification" object:nil];
            
        }
    }
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    NSString *AnnotationViewID = @"AnnotationViewID";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 从天上掉下效果
        //        annotationView.animatesDrop = YES;
    }
    
    if (dataArr.count) {
        for (MarkModel *model in dataArr) {
            if (model.lat.doubleValue  == annotation.coordinate.latitude &&
                model.lng.doubleValue == annotation.coordinate.longitude) {
                //停车场 PMK、神州租车 SZZC、立体 LTK、慢行 MX
                if ([model.ptype isEqualToString:@"PMK"]) {
                    annotationView.image = [UIImage imageNamed:@"mapPark"];
                }else if([model.ptype isEqualToString:@"SZZC"]){
                    annotationView.image = [UIImage imageNamed:@"markCar"];
                }else if([model.ptype isEqualToString:@"LTK"]){
                    annotationView.image = [UIImage imageNamed:@"mapBuilding"];
                }else if([model.ptype isEqualToString:@"MX"]){
                    annotationView.image = [UIImage imageNamed:@"mapBike"];
                }else if([model.ptype isEqualToString:@"出租车"]){
                    annotationView.image = [UIImage imageNamed:@"mapTaxi"];
                }else if([model.ptype isEqualToString:@"公交"]){
                    annotationView.image = [UIImage imageNamed:@"mapBus"];
                }else if([model.ptype isEqualToString:@"地铁"]){
                    annotationView.image = [UIImage imageNamed:@"mapTrain"];
                }
            }
        }
    }
    
    if (pointArr.count) {
        for (MarkModel *model in pointArr) {
            if (model.lat.doubleValue  == annotation.coordinate.latitude &&
                model.lng.doubleValue == annotation.coordinate.longitude) {
                if([model.ptype isEqualToString:@"出租车"]){
                    annotationView.image = [UIImage imageNamed:@"mapTaxi"];
                }else if([model.ptype isEqualToString:@"公交"]){
                    annotationView.image = [UIImage imageNamed:@"mapBus"];
                }else if([model.ptype isEqualToString:@"地铁"]){
                    annotationView.image = [UIImage imageNamed:@"mapTrain"];
                }
            }
        }
    }
    
    return annotationView;
}

@end
