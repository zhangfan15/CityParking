//
//  MainViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    BMKMapView          * _mapView;
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
    NSInteger             collectionSelectIndex;
    NSMutableArray      * tableData;
    BOOL                  showParkTable;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIView *mapBackView;

@property (weak, nonatomic) IBOutlet UIView *headerView;

//
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapBackViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapBackViewHeight;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation MainViewController

/**
 *  加载控制器的时候设置打开抽屉模式  (因为在后面会关闭)
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    //设置打开抽屉模式
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poisearch.delegate = nil;
}

- (void)getDataWithCollectSelectIndex:(NSInteger)index {
    switch (index) {//停车场 PMK、神州租车 SZZC、立体 LTK、慢行 MX
        case 0:{
            [self GetMapDataWithType:nil];
            [self getPOIInfoWithType:@"公交"];
            [self getPOIInfoWithType:@"地铁"];
            [self getPOIInfoWithType:@"出租车"];
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
            [self GetMapDataWithType:@"LTK"];
        }
            break;
        case 4:{
            [self GetMapDataWithType:@"MX"];
        }
            break;
        case 5:{
            [dataArr removeAllObjects];
            [self getPOIInfoWithType:@"公交"];
        }
            break;
        case 6:{
            [dataArr removeAllObjects];
            [self getPOIInfoWithType:@"地铁"];
        }
            break;
        case 7:{
            [dataArr removeAllObjects];
            [self getPOIInfoWithType:@"出租车"];
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
    [netManager GetDataWithParams:paramas AndParamNumber:1 Success:^(NSDictionary *responseObject) {
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
                if (showParkTable) {
                    [tableData addObject:model];
                    if (tableData.count) {
                        CGRect tempRect = _headerView.frame;
                        tempRect.size.height = 0;
                        _headerView.frame = tempRect;
//                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//                        [_table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
                        [_table reloadData];
                    }
                }
            }
            [self addAnnotationToMapWithData:dataArr];
        }
        
    } Failure:^(NSString *errorInfo) {
    
    }];
}

- (void)getPOIInfoWithType:(NSString *)type {
    BMKNearbySearchOption * option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 20;
    option.radius = 1000;
    option.location = _mapView.centerCoordinate;
    option.keyword = type;
    BOOL flag = [_poisearch poiSearchNearBy:option];
    if(flag){
        NSLog(@"城市内检索发送成功");
    }
    else {
        NSLog(@"城市内检索发送失败");
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

- (IBAction)backToMenu:(UISwipeGestureRecognizer *)sender {
    [tableData removeAllObjects];
    showParkTable = NO;
    CGRect tempRect = _headerView.frame;
    tempRect.size.height = (SCREEN_WIDTH-40)/2+40;
    _headerView.frame = tempRect;
    [_table reloadData];
//    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = [NSMutableArray array];
    pointArr = [NSMutableArray array];
    tableData = [NSMutableArray array];
    netManager = [NetworkTool shareNetworkTool];
    _mapBackViewHeight.constant = SCREEN_HEIGHT-(SCREEN_WIDTH-40)/2-40;
    
    CGRect tempRect = _headerView.frame;
    tempRect.size.height = (SCREEN_WIDTH-40)/2+40;
    _headerView.frame = tempRect;
    _table.tableHeaderView = _headerView;//tableHeaderView的高度是根据headerView来的，前提最后一个view约束不能给定高度，必须要与headerView的bottom设置约束关系，在没有view的时候，可以设置tableHeaderView的高度，在有view的时候只能用view的高度，在设置tableHeaderview.height 不起作用
    [_table reloadData];

    titleArr = @[@"全部",@"停车",@"神州租车",@"立体",@"慢行",@"巴士",@"地铁",@"出租车"];
    imageNameArr = @[@"markAll",@"markPark",@"markRent",@"markBuilding",@"markBike",@"markBus",@"markTrain",@"markTaxi"];
    tableImageArr = @[@"markHome",@"markCompany"];
    tableTitleArr = @[@"带我回家",@"带我上班"];
    
    [self initMapView];

    //2、添加双击手势
//    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//    //2.1、双击
//    [doubleTap setNumberOfTapsRequired:2];
//    [self.view addGestureRecognizer:doubleTap];
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
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _mapBackViewHeight.constant)];
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
    [_mapView showMapPoi];
    [self.mapBackView insertSubview:_mapView atIndex:0];
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
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
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
    return 8;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"LXMarkCollectionViewCell";
    //重用cell
    MarkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = titleArr[indexPath.item];
    NSString *imageName = imageNameArr[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
    
}


//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCREEN_WIDTH-40)/4;
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
    if (showParkTable) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (showParkTable) {
        return tableData.count;
    }
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
    }
    return 1;
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
        if (indexPath.section == 0) {
            NSString *CellIdentifier = @"LXMapSearchCell";
            mapSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[mapSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            return cell;
        } else {
            NSString * CellIdentifier = @"LXMapEditCell";
            mapEditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[mapEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            NSString * imageName = tableImageArr[indexPath.row];
            cell.image.image = [UIImage imageNamed:imageName];
            cell.titleLabel.text = tableTitleArr[indexPath.row];
            
            return cell;
        }
    }
    
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
    if (section == 0) {
        return 0.f;
    } else {
        return 20.f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (showParkTable) {
        return 106;
    }
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
                
            } else if (indexPath.row == 0) {
                
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
