//
//  RechargeListViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/25.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "RechargeListViewController.h"
#import "public.h"

@interface RechargeListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * payData;
    NSMutableArray * rechargeData;
    NSInteger        pageNum;
    NSInteger        pageNum1;
    UserInfo       * user;
    BOOL             IsSelectAtFirstButton;
}

@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation RechargeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user = UserInformation;
    pageNum = 1;
    pageNum1 = 1;
    IsSelectAtFirstButton = YES;
    payData = [NSMutableArray array];
    rechargeData = [NSMutableArray array];
    [self getPayListData];
    [self getRechargeListData];
}

- (void)getPayListData {
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"pageNo":[NSString stringWithFormat:@"%ld",pageNum],
                             @"pageSize":@"10"
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"pc/collectfees/queryByList" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        NSArray * arr = responseObject[@"data"];
        if (arr && arr.count) {
            [payData addObjectsFromArray:arr];
            [_table reloadData];
        }
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)getRechargeListData {
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"pageNo":[NSString stringWithFormat:@"%ld",pageNum1],
                             @"pageSize":@"10"
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"pc/userrecharge/queryUserRechargeToAjax" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        NSArray * arr = responseObject[@"data"];
        if (arr && arr.count) {
            [rechargeData addObjectsFromArray:arr];
            [_table reloadData];
        }
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)towButtonClick:(UIButton *)sender {
    _payButton.selected = NO;
    _rechargeButton.selected = NO;
    sender.selected = YES;
    CGRect rect = _line.frame;
    if (sender == _payButton) {
        IsSelectAtFirstButton = YES;
        [UIView animateWithDuration:0.2 animations:^{
            _line.frame = CGRectMake(0, rect.origin.y, SCREEN_WIDTH/2, 2);
        }];
    } else {
        IsSelectAtFirstButton = NO;
        [UIView animateWithDuration:0.2 animations:^{
            _line.frame = CGRectMake(SCREEN_WIDTH/2, rect.origin.y, SCREEN_WIDTH/2, 2);
        }];
    }
    [_table reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    NSString * cellIdentifier = @"RechargeTableViewCell";
    RechargeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[RechargeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary * tempDic;
    NSString     * monetStr;
    if (IsSelectAtFirstButton) {
        tempDic = payData[indexPath.row];
        monetStr = [NSString stringWithFormat:@"-%.f",[tempDic[@"payment"] doubleValue]];
        cell.moneyLabel.textColor = COLOR_WITH_HEX(0xdd5652);
    } else {
        tempDic = rechargeData[indexPath.row];
        monetStr = [NSString stringWithFormat:@"+%.f",[tempDic[@"payment"] doubleValue]];
        cell.moneyLabel.textColor = COLOR_WITH_HEX(0x24db43);
    }
    NSString * type;
    if ([tempDic[@"zffs"] isEqualToString:@"X"]) {
        type = @"现金支付";
    } else if ([tempDic[@"zffs"] isEqualToString:@"W"]) {
        type = @"微信支付";
    } else if ([tempDic[@"zffs"] isEqualToString:@"Z"]) {
        type = @"支付宝支付";
    }
    else if ([tempDic[@"zffs"] isEqualToString:@"Q"]) {
        type = @"钱包支付";
    }
    else if ([tempDic[@"zffs"] isEqualToString:@"YHQ"]) {
        type = @"优惠券";
    }
    
    cell.timeLabel.text = tempDic[@"transdate"];
    cell.typeLabel.text = type;
    cell.moneyLabel.text = monetStr;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    if (IsSelectAtFirstButton) {
        return payData.count;
    } else {
        return rechargeData.count;
    }
}


@end
