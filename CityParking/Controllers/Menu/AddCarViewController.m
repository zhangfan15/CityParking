//
//  AddCarViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/25.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "AddCarViewController.h"
#import "public.h"

@interface AddCarViewController ()

@property (weak, nonatomic) IBOutlet UILabel *plateNumber;

@end

@implementation AddCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)plateButtonClick:(UIButton *)sender {
    ChooseCarPlateView *v = [[ChooseCarPlateView alloc] init];
    //设置回调
    [v setDidChooseCarNumberBlock:^(NSString *str) {
        if (str.length != 0) {
            _plateNumber.text = str;
        }
    }];
    NSString *str = sender.currentTitle;
    v.strDefault = str;
    
    [v show];
}

- (IBAction)bottomButtonClick:(id)sender {
    if (!_plateNumber.text.length||[_plateNumber.text isEqualToString:@"请选择车牌号码"]) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"请选择车牌号码" message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    UserInfo * user = UserInformation;
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"plate_number":_plateNumber.text,
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"pc/platenumber/addPlatenumberAjax" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"绑定成功" message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    } Failure:^(NSString *errorInfo) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"网络连接失败" message:@"请检查网络后再试"];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
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
