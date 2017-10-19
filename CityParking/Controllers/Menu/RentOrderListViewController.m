//
//  RentOrderListViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/13.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "RentOrderListViewController.h"
#import "public.h"

@interface RentOrderListViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSInteger pageNum;
    NSMutableArray * dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *emptyView; 

@end

@implementation RentOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = [NSMutableArray array];
    [self getRentOrderList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getRentOrderList {
    UserInfo * user = UserInformation;
    NSDictionary * params = @{@"hyid":user.hyid,@"pageNo":[NSString stringWithFormat:@"%ld",pageNum],@"pageSize":@"10"};
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/member/queryZuChe" AndParams:params IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        NSArray * tempArr = responseObject[@"data"];
        if (tempArr != nil && tempArr.count) {
            for (NSDictionary * dic in tempArr) {
                ZuCheOrderModel * model = [ZuCheOrderModel modelObjectWithDictionary:dic];
                [dataArr addObject:model];
            }
            
            [_table reloadData];
        }
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"LXMenuRentCell";
    MenuRentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuRentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    ZuCheOrderModel * model = [dataArr objectAtIndex:indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
