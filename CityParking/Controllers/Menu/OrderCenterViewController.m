//
//  OrderCenterViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/14.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "OrderCenterViewController.h"
#import "public.h"

@interface OrderCenterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL headerBtnSelect;
    NSMutableArray * currentBookingData;
    NSMutableArray * historyBookingData;
    NSMutableArray * currentShareData;
    NSMutableArray * historyShareData;
    NSMutableArray * currentZucheData;
    NSMutableArray * historyZucheData;
    BOOL isCurrentBtnClick;
    NSInteger menuBtnClickIndex;
    NSInteger pageNum;
    NSInteger pageNum1;
    NSInteger pageNum2;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lvseLineConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHeight;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn1;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn2;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn3;
@property (weak, nonatomic) IBOutlet UIView *emptyView;

@end

@implementation OrderCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    currentBookingData  = [NSMutableArray array];
    historyBookingData  = [NSMutableArray array];
    currentShareData    = [NSMutableArray array];
    historyShareData    = [NSMutableArray array];
    currentZucheData    = [NSMutableArray array];
    historyZucheData    = [NSMutableArray array];
    isCurrentBtnClick = YES;
    pageNum=1;
    pageNum1=1;
    pageNum2=1;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        if (menuBtnClickIndex == 0) {
            pageNum=1;
        } else if (menuBtnClickIndex == 1) {
            pageNum1=1;
        } else {
            pageNum2=1;
        }
        
        [self getDataRefreshTable];
        [self.table.mj_header endRefreshing];
    }];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (menuBtnClickIndex == 0) {
            pageNum++;
        } else if (menuBtnClickIndex == 1) {
            pageNum1++;
        } else {
            pageNum2++;
        }
        [self getDataRefreshTable];
        [self.table.mj_footer endRefreshing];
    }];
    [self getDataRefreshTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deletOrderWithParam:(NSString *)param {
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/member/updateBooking" AndParams:@{@"accid":param}   IfJSONType:NO Success:^(NSDictionary *responseObject) {
        
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)getDataRefreshTable {
    NSString * URLStr;
    NSDictionary * params;
    if (menuBtnClickIndex == 0) {
        URLStr = @"mobile/member/querybooking";
        UserInfo * user = UserInformation;
        NSDictionary * userLocation = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOCATION];
        params = @{@"hyid":user.hyid,
                   @"pageNo":[NSString stringWithFormat:@"%ld",pageNum],
                   @"lat":[userLocation objectForKey:@"lat"],
                   @"lng":[userLocation objectForKey:@"lng"],
                   @"pageSize":@"10"};
    } else if (menuBtnClickIndex == 1) {
        URLStr = @"mobile/ratecod/queryShareInfoList";
        UserInfo * user = UserInformation;
        params = @{@"hyid":user.hyid,@"pageNo":[NSString stringWithFormat:@"%ld",pageNum1],@"pageSize":@"10"};
    } else {
        URLStr = @"mobile/member/queryZuChe";
        UserInfo * user = UserInformation;
        params = @{@"hyid":user.hyid,@"pageNo":[NSString stringWithFormat:@"%ld",pageNum2],@"pageSize":@"10"};
    }
    
    [[NetworkTool shareNetworkTool] PostDataWithURL:URLStr AndParams:params IfJSONType:NO Success:^(NSDictionary *responseObject) {
        if (menuBtnClickIndex == 0 && pageNum == 1) {
            [currentBookingData removeAllObjects];
            [historyBookingData removeAllObjects];
        } else if (menuBtnClickIndex == 1 && pageNum1 == 1) {
            [currentShareData removeAllObjects];
            [historyShareData removeAllObjects];
        } else if (pageNum2 == 1){
            [currentZucheData removeAllObjects];
            [historyZucheData removeAllObjects];
        }
        
        NSArray * arr = responseObject[@"data"];
        if (arr != nil && arr.count) {
            for (NSDictionary * tempDic in arr) {
                if (menuBtnClickIndex == 0) {
                    BookingOrderModel * model = [BookingOrderModel modelObjectWithDictionary:tempDic];
                    if ([model.orderStatus isEqualToString:@"R"]
                        || [model.orderStatus isEqualToString:@"N"]
                        || [model.orderStatus isEqualToString:@"I"]) {
                        [currentBookingData addObject:model];
                    } else {
                        [historyBookingData addObject:model];
                    }
                } else if (menuBtnClickIndex == 1) {
                    ShareOrderModel * model = [ShareOrderModel modelObjectWithDictionary:tempDic];
                    if (model.acczt == 0) {
                        [currentShareData addObject:model];
                    } else {
                        [historyShareData addObject:model];
                    }
                    
                } else {
                    ZuCheOrderModel * model = [ZuCheOrderModel modelObjectWithDictionary:tempDic];
                    if (model.state == 0) {
                        [currentZucheData addObject:model];
                    }else {
                        [historyZucheData addObject:model];
                    }
                }
            }
        }
        [self reloadTableViewWithData];
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)reloadTableViewWithData {
    if (isCurrentBtnClick) {
        if (menuBtnClickIndex == 0) {
            if (currentBookingData.count) {
                _emptyView.hidden = YES;
                [_table reloadData];
            } else {
                _emptyView.hidden = NO;
                [self.view bringSubviewToFront:_emptyView];
            }
        } else if (menuBtnClickIndex == 1) {
            if (currentShareData.count) {
                _emptyView.hidden = YES;
                [_table reloadData];
            } else {
                _emptyView.hidden = NO;
                [self.view bringSubviewToFront:_emptyView];
            }
        } else {
            if (currentZucheData.count) {
                _emptyView.hidden = YES;
                [_table reloadData];
            } else {
                _emptyView.hidden = NO;
                [self.view bringSubviewToFront:_emptyView];
            }
        }
    } else {
        if (menuBtnClickIndex == 0) {
            if (historyBookingData.count) {
                _emptyView.hidden = YES;
                [_table reloadData];
            } else {
                _emptyView.hidden = NO;
                [self.view bringSubviewToFront:_emptyView];
            }
        } else if (menuBtnClickIndex == 1) {
            if (historyShareData.count) {
                _emptyView.hidden = YES;
                [_table reloadData];
            } else {
                _emptyView.hidden = NO;
                [self.view bringSubviewToFront:_emptyView];
            }
        } else {
            if (historyZucheData.count) {
                _emptyView.hidden = YES;
                [_table reloadData];
            } else {
                _emptyView.hidden = NO;
                [self.view bringSubviewToFront:_emptyView];
            }
        }
    }
    
}

- (IBAction)headerButtonClick:(UIButton *)sender {
    _headerButton.selected = !_headerButton.selected;
    headerBtnSelect = !headerBtnSelect;
    if (headerBtnSelect) {
        [UIView animateWithDuration:5 animations:^{
            _menuHeight.constant = 40.f;
            _menuView.hidden = NO;
        }];
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            _menuHeight.constant = 0.f;
            _menuView.hidden = YES;
        }];
    }
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)towButtonClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    _currentButton.selected = NO;
    _historyButton.selected = NO;
    sender.selected = YES;
    isCurrentBtnClick = !isCurrentBtnClick;
    
    if (_currentButton == sender){
        [UIView animateWithDuration:0.2f animations:^{
            _lvseLineConstraint.constant=0;
        }];
        [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
    }else{
        [UIView animateWithDuration:0.2f animations:^{
            _lvseLineConstraint.constant=SCREEN_WIDTH/2;
        }];
        [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (IBAction)threeButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _menuHeight.constant = 0.f;
        _menuView.hidden = YES;
    }];
    headerBtnSelect = NO;
    _headerButton.selected = NO;
    if (_menuBtn1 == sender){
        menuBtnClickIndex = 0;
        [_headerButton setTitle:@"预约订单" forState:UIControlStateNormal];
        [_headerButton setTitle:@"预约订单" forState:UIControlStateSelected];
    } else if (_menuBtn2 == sender){
        menuBtnClickIndex = 1;
        [_headerButton setTitle:@"共享订单" forState:UIControlStateNormal];
        [_headerButton setTitle:@"共享订单" forState:UIControlStateSelected];
    } else {
        menuBtnClickIndex = 2;
        [_headerButton setTitle:@"神州租车" forState:UIControlStateNormal];
        [_headerButton setTitle:@"神州租车" forState:UIControlStateSelected];
    }
    [self getDataRefreshTable];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (menuBtnClickIndex == 2) {
        return 54.f;
    } else if (menuBtnClickIndex == 1) {
        return 66.f;
    } else {
        return 86.f;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (menuBtnClickIndex == 0) {
        if (isCurrentBtnClick) {
            return currentBookingData.count;
        } else {
            return historyBookingData.count;
        }
    } else if (menuBtnClickIndex == 1) {
        if (isCurrentBtnClick) {
            return currentShareData.count;
        } else {
            return historyShareData.count;
        }
    } else {
        if (isCurrentBtnClick) {
            return currentZucheData.count;
        } else {
            return historyZucheData.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (menuBtnClickIndex == 0){
        NSString *CellIdentifier = @"BookingOrderCell";
        BookingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[BookingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        BookingOrderModel * model;
        if (isCurrentBtnClick) {
            model = [currentBookingData objectAtIndex:indexPath.row];
        } else {
            model = [historyBookingData objectAtIndex:indexPath.row];
        }
        if ([model.yylx isEqualToString:@"0"]) {
            cell.carnumber.text = @"普通预约";
        } else {
            cell.carnumber.text = @"担保预约";
        }
        cell.parkImage.image = [UIImage imageNamed:model.tp];
        cell.parkName.text = model.cname;
        cell.startTime.text = model.arrdate;
        cell.endTime.text = model.depdate;
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%.f",model.price];
        cell.parkDistance.text = [NSString stringWithFormat:@"%@米",model.juli];
        if ([model.orderStatus isEqualToString:@"R"]) {
            cell.stateLabel.text = @"预订";
            cell.stateLabel.textColor = COLOR_WITH_HEX(0x24db43);
        } else if ([model.orderStatus isEqualToString:@"X"]) {
            cell.stateLabel.text = @"取消";
            cell.stateLabel.textColor = COLOR_WITH_HEX(0x9eadc0);
        } else if ([model.orderStatus isEqualToString:@"N"]) {
            cell.stateLabel.text = @"未到";
            cell.stateLabel.textColor = COLOR_WITH_HEX(0x24db43);
        } else if ([model.orderStatus isEqualToString:@"O"]) {
            cell.stateLabel.text = @"离开";
            cell.stateLabel.textColor = COLOR_WITH_HEX(0x9eadc0);
        } else{
            cell.stateLabel.text = @"在停车";
            cell.stateLabel.textColor = COLOR_WITH_HEX(0x24db43);
        }
        return cell;
    } else if (menuBtnClickIndex == 1) {
        NSString *CellIdentifier = @"ShareOrderCell";
        ShareOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[ShareOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ShareOrderModel * model;
        if (isCurrentBtnClick) {
            model = [currentShareData objectAtIndex:indexPath.row];
        } else {
            model = [historyShareData objectAtIndex:indexPath.row];
        }
        cell.plateNumber.text = model.plateNumber;
        cell.parkName.text = model.cname;
        cell.startTime.text = model.startTime;
        cell.endTime.text = model.endTime;
        return cell;
    } else {
        NSString *CellIdentifier = @"LXMenuRentCell";
        MenuRentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuRentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ZuCheOrderModel * model;
        if (isCurrentBtnClick) {
            model = [currentZucheData objectAtIndex:indexPath.row];
        } else {
            model = [historyZucheData objectAtIndex:indexPath.row];
        }
        cell.carNumberLabel.text = model.plateNumber;
        cell.startTimeLabel.text = model.startTime;
        NSString * state;
        if (model.state == 1) {
            state = @"已完成";
            cell.orderStatus.textColor = [UIColor darkGrayColor];
        }else {
            state = @"未支付";
            cell.orderStatus.textColor = COLOR_WITH_HEX(0xfc7823);
        }
        cell.orderStatus.text    = state;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (menuBtnClickIndex == 0){
        if (isCurrentBtnClick) {
            BookingOrderModel * model = currentBookingData[indexPath.row];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:model.cname message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"开始导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self NavigationToDestinationWithLocationName:model.cname AndLatitude:model.lat.doubleValue AndLongitude:model.lng.doubleValue];
            }];
            [alert addAction:action1];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消订单" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self deletOrderWithParam:model.accid];
            }];
            [alert addAction:action2];
            UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action3];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            OrderDetailViewController * VC = [MainStoryboard instantiateViewControllerWithIdentifier:@"OrderDetailViewController"];
            VC.bookModel = historyBookingData[indexPath.row];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

-(void) NavigationToDestinationWithLocationName:(NSString *)name AndLatitude:(double)lat AndLongitude:(double)lng
{
    CLLocationCoordinate2D destinnation = CLLocationCoordinate2DMake(lat, lng);
    //当前的位置
    MKMapItem * currentLocation              = [MKMapItem mapItemForCurrentLocation];
    //目的地的位置
    MKMapItem * toLocation              = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:destinnation addressDictionary:nil]];
    
    toLocation.name                     = name;
    
    NSArray *items                      = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    NSDictionary *options               = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

@end
