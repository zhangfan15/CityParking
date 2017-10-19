//
//  MyParkingViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/17.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MyParkingViewController.h"
#import "public.h"

@interface MyParkingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * dataArr;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MyParkingViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataWithParams];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = [NSMutableArray array];
}

- (void)getDataWithParams {
    if (dataArr.count) {
        [dataArr removeAllObjects];
    }
    UserInfo * user = UserInformation;
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"pc/bind/queryShareData" AndParams:@{@"hyid":user.hyid} IfJSONType:NO Success:^(NSDictionary *responseObject) {
        NSArray * arr = responseObject[@"data"];
        if (arr != nil && arr.count) {
            for (NSDictionary * tempDic in arr) {
                MyParkingModel * model = [MyParkingModel modelObjectWithDictionary:tempDic];
                [dataArr addObject:model];
            }
            [_table reloadData];
        }
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightButtonClick:(UIButton *)sender {
}

- (IBAction)bottomButtonClick:(UIButton *)sender {
    AddParkingViewController * vc = [MainStoryboard instantiateViewControllerWithIdentifier:@"AddParkingViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
    NSString * CellIdentifier = @"MyParkingCell";
    MyParkingCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MyParkingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MyParkingModel * model = dataArr[indexPath.row];
    cell.parkingName.text = model.villagename;
    cell.parkingNum.text = model.parkingNumber;
    if (model.state == 0) {
        cell.parkingState.textColor = COLOR_WITH_HEX(0x417293);
        cell.parkingState.text = @"审核中";
    } else if (model.state == 1) {
        cell.parkingState.textColor = COLOR_WITH_HEX(0x24db43);
        cell.parkingState.text = @"已发布";
    } else {
        cell.parkingState.textColor = COLOR_WITH_HEX(0xdd5652);
        cell.parkingState.text = @"已退回";
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

@end
