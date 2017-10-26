//
//  OrderDetailViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/16.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * tableTitles;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableToBottomHeight;
@property (weak, nonatomic) IBOutlet UIView *BottomMenuView;

@end

@implementation OrderDetailViewController

@synthesize bookModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableTitles = @[@[@"订单信息",@"订单编号",@"下单时间",@"订单状态"],
                    @[@"车辆信息",@"车库名称",@"车库地址",@"车牌号码",@"消费金额",@"开始时间",@"结束时间"]];
    if ([bookModel.orderStatus isEqualToString:@"R"]
        || [bookModel.orderStatus isEqualToString:@"N"]
        || [bookModel.orderStatus isEqualToString:@"I"]) {
        _tableToBottomHeight.constant = 64;
        _BottomMenuView.hidden = NO;
    } else {
        _tableToBottomHeight.constant = 0;
        _BottomMenuView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonSelect:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * Identifier = @"OrderDetailCell";
    OrderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if (!indexPath.row) {
        cell.cellTitleLabel.textColor = [UIColor blackColor];
        cell.cellSubTitleLabel.hidden = YES;
    } else {
        cell.cellTitleLabel.textColor = [UIColor darkGrayColor];
        cell.cellSubTitleLabel.hidden = NO;
    }
    cell.cellTitleLabel.text = tableTitles[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:{
                cell.cellSubTitleLabel.text = bookModel.accid;
            }
                break;
            case 2:{
                cell.cellSubTitleLabel.text = bookModel.time;
            }
                break;
            case 3:{
                cell.cellSubTitleLabel.textColor = COLOR_WITH_HEX(0x24db43);
                if ([bookModel.orderStatus isEqualToString:@"R"]) {
                    cell.cellSubTitleLabel.text = @"预订";
                } else if ([bookModel.orderStatus isEqualToString:@"X"]) {
                    cell.cellSubTitleLabel.text = @"取消";
                } else if ([bookModel.orderStatus isEqualToString:@"N"]) {
                    cell.cellSubTitleLabel.text = @"未到";
                } else if ([bookModel.orderStatus isEqualToString:@"O"]) {
                    cell.cellSubTitleLabel.text = @"离开";
                } else{
                    cell.cellSubTitleLabel.text = @"在停车";
                }
            }
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 1:{
                cell.cellSubTitleLabel.text = bookModel.cname;
            }
                break;
            case 2:{
                cell.cellSubTitleLabel.text = bookModel.dz;
            }
                break;
            case 3:{
                cell.cellSubTitleLabel.text = bookModel.plateNumber;
            }
                break;
            case 4:{
                cell.cellSubTitleLabel.text = [NSString stringWithFormat:@"¥%.f",bookModel.price];
                cell.cellSubTitleLabel.textColor = COLOR_WITH_HEX(0xdd5652);
            }
                break;
            case 5:{
                cell.cellSubTitleLabel.text = bookModel.arrdate;
            }
                break;
            case 6:{
                cell.cellSubTitleLabel.text = bookModel.depdate;
            }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableTitles[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableTitles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 20.f;
    }
    return 0.f;
}

- (IBAction)navButtonClick:(UIButton *)sender {
    [self NavigationToDestinationWithLocationName:bookModel.cname AndLatitude:bookModel.lat.doubleValue AndLongitude:bookModel.lng.doubleValue];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self deletOrderWithParam:bookModel.accid];
}

- (void)deletOrderWithParam:(NSString *)param {
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/member/updateIOSBooking" AndParams:@{@"accid":param}   IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"订单已取消" message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    } Failure:^(NSString *errorInfo) {
        
    }];
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
