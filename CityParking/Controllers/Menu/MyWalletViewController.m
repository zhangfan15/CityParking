//
//  MyWalletViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/25.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MyWalletViewController.h"
#import "public.h"

@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * titleArr;
    NSArray * imageArr;
}

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleArr = @[@[@"充值",@"提现"],
                 @[@"充值记录"]];
    [self getUserInformation];
}

- (void)getUserInformation {
    UserInfo * user = UserInformation;
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/user/queryByPhonenum" AndParams:@{@"phonenum":user.phonenum} IfShowHUD:NO Success:^(NSDictionary *responseObject) {
        UserInfo * tempUser = [UserInfo modelObjectWithDictionary:responseObject[@"data"]];
        [NSKeyedArchiver archiveRootObject:tempUser toFile:USER_INFOR_PATH];
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f",tempUser.zhye];
    } Failure:^(NSString *errorInfo) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"连接失败" message:@"请检查网络后重试"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titleArr.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LXMenuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
//    NSString * imageName = imageArr[indexPath.section][indexPath.row];
//    cell.cellImage.image = [UIImage imageNamed:imageName];
    cell.cellSubTitle.hidden = YES;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArr[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 20.f;
    }
    return 0.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        if (!indexPath.row) {
            RechargeViewController * vc = [MainStoryboard instantiateViewControllerWithIdentifier:@"RechargeViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            
        }
    } else {
        RechargeListViewController * vc = [MainStoryboard instantiateViewControllerWithIdentifier:@"RechargeListViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
