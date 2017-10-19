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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
