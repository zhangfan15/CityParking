//
//  ParkingLotViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/19.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "ParkingLotViewController.h"

@interface ParkingLotViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lotName;
@property (weak, nonatomic) IBOutlet UILabel *lotNumber;
@property (weak, nonatomic) IBOutlet UILabel *lotAddress;
@property (weak, nonatomic) IBOutlet UILabel *shareTime;
@property (weak, nonatomic) IBOutlet UILabel *latStatus;

@end

@implementation ParkingLotViewController

@synthesize lotModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lotName.text = lotModel.villagename;
    _lotNumber.text = lotModel.parkingNumber;
    _lotAddress.text = lotModel.street;
    _shareTime.text = lotModel.time;
    if (lotModel.state == 0) {
        _latStatus.text = @"车位正在审核...";
    } else if (lotModel.state == 1) {
        _latStatus.text = @"车位已发布";
    } else {
        _latStatus.text = @"车位被退回，请联系客服!";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(UIButton *)sender {
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

@end
