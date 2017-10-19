//
//  FindCarViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/16.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "FindCarViewController.h"
#import "public.h"

@interface FindCarViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger pageNum;
    NSInteger pageSize;
    NSMutableArray * tableDataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation FindCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableDataArr = [NSMutableArray array];
    pageNum = 1;
    pageSize = 10;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        pageNum=1;
        [self getDataWithParam];
        [self.table.mj_header endRefreshing];
    }];
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        pageNum++;
        [self getDataWithParam];
        [self.table.mj_footer endRefreshing];
    }];
    [self getDataWithParam];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getDataWithParam {
    NSDictionary * location = [[NSUserDefaults standardUserDefaults] objectForKey:USER_LOCATION];
    NSDictionary * params = @{@"lat":location[@"lat"],
                              @"lng":location[@"lng"],
                              @"pageNo":[NSString stringWithFormat:@"%ld",pageNum],
                              @"pageSize":[NSString stringWithFormat:@"%d",10]};
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/ratecod/findParking" AndParams:params  IfJSONType:NO Success:^(NSDictionary *responseObject) {
        if (pageNum == 1 && tableDataArr.count) {
            [tableDataArr removeAllObjects];
        }
        NSArray * arr = responseObject[@"data"][@"list"];
        if (arr != nil && arr.count) {
            for (NSDictionary * tempDic in arr) {
                MarkModel * model = [MarkModel modelObjectWithDictionary:tempDic];
                [tableDataArr addObject:model];
            }
        }
        [_table reloadData];
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"LXMapParkCell";
    MapParkCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MapParkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MarkModel * model = [tableDataArr objectAtIndex:indexPath.row];
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
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingDetailViewController * vc = [MainStoryboard instantiateViewControllerWithIdentifier:@"ParkingDetailViewController"];
    vc.markModel = [tableDataArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
