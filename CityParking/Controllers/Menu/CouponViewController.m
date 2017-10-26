//
//  CouponViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/26.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "CouponViewController.h"
#import "public.h"

@interface CouponViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * currentData;
    NSArray * historyData;
    BOOL      IsSelectAtCurrentButton;
}

@property (weak, nonatomic) IBOutlet UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IsSelectAtCurrentButton = YES;
    // Do any additional setup after loading the view.
    [self getData];
}

- (void)getData {
    UserInfo * user = UserInformation;
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"couponType":[NSString stringWithFormat:@"%d",IsSelectAtCurrentButton?0:1],
                             @"pageNo":@"1",
                             @"pageSize":@"100"
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/member/couponListAjax" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        NSArray * arr = responseObject[@"data"][@"list"];
        NSData * data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        if (arr && arr.count) {
            if (IsSelectAtCurrentButton) {
                currentData = arr;
            } else {
                historyData = arr;
            }
            _emptyView.hidden = YES;
            [_table reloadData];
        } else {
            _emptyView.hidden = NO;
            [self.view bringSubviewToFront:_emptyView];
        }
    } Failure:^(NSString *errorInfo) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"网络连接失败" message:@"请检查网络后再试"];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)towbuttonClick:(UIButton *)sender {
    _currentButton.selected = NO;
    _historyButton.selected = NO;
    sender.selected = YES;
    CGRect rect = _line.frame;
    if (sender == _currentButton) {
        IsSelectAtCurrentButton = YES;
        if (!currentData.count) {
            [self getData];
        } else {
            [_table reloadData];
        }
        [UIView animateWithDuration:0.1 animations:^{
            _line.frame = CGRectMake(0, rect.origin.y, SCREEN_WIDTH/2, 2);
        }];
    } else {
        IsSelectAtCurrentButton = NO;
        if (!historyData.count) {
            [self getData];
        } else {
            [_table reloadData];
        }
        [UIView animateWithDuration:0.1 animations:^{
            _line.frame = CGRectMake(SCREEN_WIDTH/2, rect.origin.y, SCREEN_WIDTH/2, 2);
        }];
    }
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
    NSString * identifier = @"CouponCell";
    CouponCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary * tempDic;
    if (IsSelectAtCurrentButton) {
        tempDic = currentData[indexPath.section];
        cell.couponBack.backgroundColor = COLOR_WITH_HEX(0xdd5652);
    } else {
        tempDic = historyData[indexPath.section];
        cell.couponBack.backgroundColor = UIColor.lightGrayColor;
    }
    CouponModel * model = [CouponModel modelObjectWithDictionary:tempDic];
    cell.couponMoney.text = [NSString stringWithFormat:@"¥%@",model.money];
    cell.couponState.text = model.status;
    cell.couponName.text = model.title;
    cell.couponGetTime.text = model.hqsj;
    cell.couponUntilTime.text = model.yxqz;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (IsSelectAtCurrentButton) {
        return currentData.count;
    } else {
        return historyData.count;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 10)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

@end
