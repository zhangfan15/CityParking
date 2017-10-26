//
//  MyCarsViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/25.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MyCarsViewController.h"
#import "public.h"

@interface MyCarsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * dataArr;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MyCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDataWithParam];
}

- (void)getDataWithParam {
    UserInfo * user = UserInformation;
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"pageNo":@"1",
                             @"pageSize":@"100"
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"pc/platenumber/queryPlatenumberAjax" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        NSArray * arr = responseObject[@"data"];
        if (arr && arr.count) {
            dataArr =arr;
            [_table reloadData];
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

- (IBAction)BottomButtonClick:(id)sender {
    AddCarViewController * vc = [MainStoryboard instantiateViewControllerWithIdentifier:@"AddCarViewController"];
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
    NSString * Identifier = @"MyCarCell";
    MyCarCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[MyCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.plateLabel.text = dataArr[indexPath.section][@"plate_number"];
    cell.deleteButton.tag = indexPath.section;
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArr.count;
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

- (void)deleteButtonClick:(UIButton *)button {
    NSInteger index = button.tag;
    NSDictionary * tempDic = dataArr[index];
    NSDictionary * param = @{@"hyid":tempDic[@"hyid"],
                             @"plate_number":tempDic[@"plate_number"]
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"pc/platenumber/deletePlatenumberAjax" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"删除成功" message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            [self getDataWithParam];
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    } Failure:^(NSString *errorInfo) {
        
    }];
}
@end
