//
//  MyInformationViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/16.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MyInformationViewController.h"
#import "public.h"

@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * titles;
    NSArray * subTitles;
    NSArray * images;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UserInfo * user = UserInformation;
    _titleLabel.text = [NSString stringWithFormat:@"您好，%@!",user.username];
    titles = @[@[@"我的资料",@"钱包"],
               @[@"我的车辆",@"我的共享车位"],
               @[@"优惠券",@"会员积分",@"用户反馈"],
               @[@"退出"]];
    subTitles = @[@[@"我的详细资料",@"余额、充值、提现"],
                  @[@"我的车辆信息",@"共享车位列表"],
                  @[@"优惠券抵扣停车费",@"积分换优惠券",@"用户反馈信息"],
                  @[@""]];
    images = @[@[@"ziliaoyh",@"qianbaoyh"],
               @[@"wdclyh",@"gxcwyh"],
               @[@"yhqyh",@"jifenyh",@"yhplyh"],
               @[@"exityh"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClick:(UIButton *)sender {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = @"LXMenuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titleLabel.text = titles[indexPath.section][indexPath.row];
//    NSString * imageName = images[indexPath.section][indexPath.row];
    [cell.cellImage setImage:[UIImage imageNamed:images[indexPath.section][indexPath.row]]];
    cell.cellSubTitle.hidden = NO;
    cell.cellSubTitle.text = subTitles[indexPath.section][indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titles.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [titles[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section) {
        return 10;
    }
    return 0;
}

@end
