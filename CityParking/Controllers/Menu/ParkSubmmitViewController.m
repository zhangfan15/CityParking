//
//  ParkSubmmitViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "ParkSubmmitViewController.h"

@interface ParkSubmmitViewController (){
//    NSArray * tableTitles;
}

@property (weak, nonatomic) IBOutlet UILabel *parkName;
@property (weak, nonatomic) IBOutlet UILabel *lotNumber;
@property (weak, nonatomic) IBOutlet UILabel *parkAddress;
@property (weak, nonatomic) IBOutlet UILabel *userNumber;
@property (weak, nonatomic) IBOutlet UILabel *lotPrice;
@property (weak, nonatomic) IBOutlet UITextField *plateNumber;
@property (weak, nonatomic) IBOutlet UIButton *arrTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *livTimeButton;


@end

@implementation ParkSubmmitViewController

@synthesize detailmodel,markModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews {
    _parkName.text = markModel.cname;
    _lotNumber.text = detailmodel.code;
    _parkAddress.text = markModel.dz;
    _userNumber.text = detailmodel.accid;
    _lotPrice.text = [NSString stringWithFormat:@"%@元",markModel.charge];
}

- (IBAction)leftButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)bottomButtonClick:(UIButton *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)arrButtonClick:(UIButton *)sender {
}

- (IBAction)livButtonClick:(UIButton *)sender {
}

@end
