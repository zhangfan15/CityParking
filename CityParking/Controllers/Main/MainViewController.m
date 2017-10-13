//
//  MainViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,RKDropdownAlertDelegate>{
    NSArray             * titleArr;
    NSArray             * imageNameArr;
    BMKLocationService  * _locService;
    NSArray             * tableImageArr;
    NSArray             * tableTitleArr;
    NetworkTool         * netManager;
    CLLocationCoordinate2D mapCenter;
    NSMutableArray      * dataArr;
    NSMutableArray      * pointArr;
    BMKPoiSearch        * _poisearch;
    BMKNearbySearchOption * option1;
    BMKNearbySearchOption * option2;
    BMKNearbySearchOption * option3;
    NSInteger             collectionSelectIndex;
    NSMutableArray      * tableData;
    BOOL                  showParkTable;
    NSInteger             callBackNumeber;
    CLLocation          * i_userLocation;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowToBottomDistance;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;


@end

@implementation MainViewController

/**
 *  加载控制器的时候设置打开抽屉模式  (因为在后面会关闭)
 */
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

#pragma mark RKDropdownAlertDelegate
-(BOOL)dropdownAlertWasDismissed {
    return YES;
}

-(BOOL)dropdownAlertWasTapped:(RKDropdownAlert*)alert {
    return YES;
}

- (void)getDataWithCollectSelectIndex:(NSInteger)index {
    switch (index) {//停车场 PMK、神州租车 SZZC、立体 LTK、慢行 MX
        case 0:{
            [self GetMapDataWithType:nil];
            [self getBusPOIInfo];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTrainWithNotification) name:@"getTrainWithNotification" object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTaxiWithNotification) name:@"getTaxiWithNotification" object:nil];
        }
            break;
        case 1:{
            [self GetMapDataWithType:@"PMK"];
        }
            break;
        case 2:{
            [self GetMapDataWithType:@"SZZC"];
        }
            break;
        case 3:{
            [self GetMapDataWithType:@"SZZC"];
        }
            break;
        case 4:{
            [self GetMapDataWithType:@"LTK"];
        }
            break;
        case 5:{
            [self GetMapDataWithType:@"MX"];
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

-(void)GetMapDataWithType:(NSString *)type {
    [dataArr removeAllObjects];
    NSDictionary * paramas = @{@"lat":[NSString stringWithFormat:@"%f",mapCenter.latitude],
                               @"lng":[NSString stringWithFormat:@"%f",mapCenter.longitude],
                               @"pageNo":@"1",
                               @"pageSize":@"20"};
    [netManager GetDataWithURL:@"mobile/ratecod/queryAllParking" AndParams:paramas Success:^(NSDictionary *responseObject) {
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
                [tableData addObject:model];
            }
            if (showParkTable) {
                if (tableData.count) {
                    CGRect tempRect = _headerView.frame;
                    tempRect.size.height = 0;
                    _headerView.frame = tempRect;
                    [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
                }
            }
            [self addAnnotationToMapWithData:dataArr];
        }else {
            [RKDropdownAlert title:@"当前范围内未找到结果" message:@"" backgroundColor:COLOR_WITH_HEX(0x417293) textColor:nil time:1 delegate:self];
        }
    } Failure:^(NSString *errorInfo) {
        
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

#pragma mark UISwipeGestureRecognizer响应方法

- (IBAction)clickMapViewToHideTable:(UITapGestureRecognizer *)sender {
    float stopY = 0;     // 停留的位置
    float animateY = 0;  // 做弹性动画的Y
    float margin = 10;   // 动画的幅度
    float offsetY = self.shadowView.frame.origin.y; // 这是上一次Y的位置
    if (self.table.contentOffset.y == 0) {
        self.table.scrollEnabled = NO;
    }
    
    if (offsetY == Y1) {
        stopY = Y3;
        
        animateY = stopY + margin;
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.shadowView.frame = CGRectMake(0, animateY, SCREEN_WIDTH, SCREEN_HEIGHT-animateY);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                self.shadowView.frame = CGRectMake(0, stopY, SCREEN_WIDTH, SCREEN_HEIGHT-stopY);
            }];
        }];
    }
}
- (IBAction)tableSwipUp:(UISwipeGestureRecognizer *)sender {
    float stopY = 0;     // 停留的位置
    float animateY = 0;  // 做弹性动画的Y
    float margin = 10;   // 动画的幅度
    float offsetY = self.shadowView.frame.origin.y; // 这是上一次Y的位置
    if (offsetY == Y3) {
        // 停在y1的位置
        stopY = Y1;
        // 当停在Y1位置 且是上划时，让vc.table不再禁止滑动
        self.table.scrollEnabled = YES;
    }else{
        stopY = Y3;
    }
    animateY = stopY - margin;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.shadowView.frame = CGRectMake(0, animateY, SCREEN_WIDTH, SCREEN_HEIGHT-animateY);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.shadowView.frame = CGRectMake(0, stopY, SCREEN_WIDTH, SCREEN_HEIGHT-stopY);
        }];
    }];
}

- (IBAction)tableSwipDown:(UISwipeGestureRecognizer *)sender {
    float stopY = 0;     // 停留的位置
    float animateY = 0;  // 做弹性动画的Y
    float margin = 10;   // 动画的幅度
    float offsetY = self.shadowView.frame.origin.y; // 这是上一次Y的位置
    if (self.table.contentOffset.y == 0) {
        self.table.scrollEnabled = NO;
    }
    
    if (offsetY == Y1) {
        stopY = Y3;
    }else{
        stopY = Y1;
    }
    animateY = stopY + margin;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.shadowView.frame = CGRectMake(0, animateY, SCREEN_WIDTH, SCREEN_HEIGHT-animateY);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.shadowView.frame = CGRectMake(0, stopY, SCREEN_WIDTH, SCREEN_HEIGHT-stopY);
        }];
    }];
    // 记录shadowView在第一个视图中的位置
//    self.vc.offsetY = stopY;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (IBAction)backToMenu:(UISwipeGestureRecognizer *)sender {
    [tableData removeAllObjects];
    showParkTable = NO;
    CGRect tempRect = _headerView.frame;
    tempRect.size.height = CollectionHeight+20;
    _headerView.frame = tempRect;
    [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
//    [_table reloadData];
//    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController * loginVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginVC animated:YES completion:nil];
    dataArr = [NSMutableArray array];
    pointArr = [NSMutableArray array];
    tableData = [NSMutableArray array];
    netManager = [NetworkTool shareNetworkTool];
    _mapViewHeight.constant = SCREEN_HEIGHT - CollectionHeight-20;
    _tableViewHeight.constant = SCREEN_HEIGHT - 50;
    _shadowToBottomDistance.constant = -(SCREEN_HEIGHT - CollectionHeight - 50 - 20);
    CGRect tempRect = _headerView.frame;
    tempRect.size.height = CollectionHeight+20;
    _headerView.frame = tempRect;
    _table.tableHeaderView = _headerView;
    
    titleArr = @[@"全部",@"停车",@"共享车位",@"神州租车",@"立体",@"慢行",@"巴士",@"地铁",@"出租车"];
    imageNameArr = @[@"markAll",@"markPark",@"markShare",@"markRent",@"markBuilding",@"markBike",@"markBus",@"markTrain",@"markTaxi"];
    tableImageArr = @[@"markHome",@"markCompany"];
    tableTitleArr = @[@"带我回家",@"带我上班"];
    
    [self initMapView];
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
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    mapCenter = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    i_userLocation = userLocation.location;
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [_locService stopUserLocationService];
    [_startBtn setEnabled:YES];
    [_startBtn setAlpha:1];
    [self getDataWithCollectSelectIndex:collectionSelectIndex];
}

-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated lat %f,long %f zoomLevel %f",_mapView.centerCoordinate.latitude,_mapView.centerCoordinate.longitude,_mapView.zoomLevel);
    mapCenter = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude, _mapView.centerCoordinate.longitude);
    [self getDataWithCollectSelectIndex:collectionSelectIndex];
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
    
    else if (errorCode == BMK_SEARCH_AMBIGUOUS_KEYWORD){
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

- (IBAction)plusMapButtonClick:(id)sender {
    [_mapView zoomIn];
}

- (IBAction)cutMapButtonClick:(id)sender {
    [_mapView zoomOut];
}

/**
 *  添加点击手势  一个手指双击
 */
-(void)doubleTap:(UITapGestureRecognizer*)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"LXMarkCollectionViewCell";
    //重用cell
    MarkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = titleArr[indexPath.item];
    NSString *imageName = imageNameArr[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:imageName];
    if (indexPath.item == 4) {
        cell.verticalLine.hidden = YES;
    } else {
        cell.verticalLine.hidden = NO;
    }
    
    if (indexPath.item == 5 || indexPath.item == 6 || indexPath.item ==7 || indexPath.item ==8) {
        cell.horizontalLine.hidden = YES;
    } else {
        cell.horizontalLine.hidden = NO;
    }
    
    return cell;
    
}


//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCREEN_WIDTH-20)/5;
    return CGSizeMake(width, width);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionSelectIndex = indexPath.item;
    if (collectionSelectIndex > 0 && collectionSelectIndex <5) {
        showParkTable = YES;
    }
    [self getDataWithCollectSelectIndex:collectionSelectIndex];
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (showParkTable) {
        return tableData.count;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (showParkTable && tableData.count) {
        NSString *CellIdentifier = @"LXMapParkCell";
        MapParkCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MapParkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        MarkModel * model = [tableData objectAtIndex:indexPath.row];
        cell.parkImage.image = [UIImage imageNamed:model.tp];
        cell.parkDistance.text = [NSString stringWithFormat:@"%@米",model.juli];
        cell.parkName.text = model.cname;
        cell.parkAdress.text = model.dz;
        if (model.time != nil && [model.time isKindOfClass:[NSString class]]) {
            cell.parkTime.text = [NSString stringWithFormat:@"时间：%@",model.time];
        }else {
            cell.parkTime.text = @"时间：00:00-23:59";
        }
        
        cell.parkNumber.text = [NSString stringWithFormat:@"车位：%@/%.lf",model.totalNumber,model.sycw];
        cell.parkPrice.text = [NSString stringWithFormat:@"¥%@／h",model.charge];
        
        return cell;
    }else {
        if (indexPath.row == 0) {
//            NSString *CellIdentifier = @"LXMapSearchCell";
//            mapSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (!cell) {
//                cell = [[mapSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            }
//
//            return cell;
        } else {
//            NSString * CellIdentifier = @"LXMapEditCell";
//            mapEditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (!cell) {
//                cell = [[mapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            }
//            NSString * imageName = tableImageArr[indexPath.row-1];
//            cell.image.image = [UIImage imageNamed:imageName];
//            cell.titleLabel.text = tableTitleArr[indexPath.row-1];
//
//            return cell;
        }
//        NSString * CellIdentifier = @"LXMapEditCell";
//        mapEditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {
//            cell = [[mapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        NSString * imageName = tableImageArr[indexPath.row-1];
//        cell.image.image = [UIImage imageNamed:imageName];
//        cell.titleLabel.text = tableTitleArr[indexPath.row-1];
//
//        return cell;
    }
        return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (showParkTable) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 20)];
        view.backgroundColor = UIColor.clearColor;
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
        lable.font = [UIFont systemFontOfSize:14.f];
        lable.backgroundColor = UIColor.clearColor;
        lable.textColor = UIColor.whiteColor;
        lable.text = @"最近停车场";
        [view addSubview:lable];
        return view;
    }
    return Nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (showParkTable) {
        return 30;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (showParkTable) {
        return 106;
    }
    
//    if (!indexPath.row) {
//        return 44;
//    }
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!showParkTable) {
        if ([cell respondsToSelector:@selector(tintColor)]) {
            
            CGFloat cornerRadius = 5.f;
            
            cell.backgroundColor = UIColor.clearColor;
            
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            
            CGMutablePathRef pathRef = CGPathCreateMutable();
            
            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
            
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {

                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);

            } else if (indexPath.row == 1) {
            
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                
                
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                
            } else {
                
                CGPathAddRect(pathRef, nil, bounds);
                
            }
            
            layer.path = pathRef;
            
            CFRelease(pathRef);
            
            //颜色修改
            
            layer.fillColor = [UIColor whiteColor].CGColor;
            
            //        layer.strokeColor=[UIColor blueColor].CGColor;
            
            
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            
            [testView.layer insertSublayer:layer atIndex:0];
            
            testView.backgroundColor = UIColor.clearColor;
            
            cell.backgroundView = testView;
        }
    }
}


@end
