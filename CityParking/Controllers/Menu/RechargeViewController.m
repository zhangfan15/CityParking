//
//  RechargeViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/25.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *ZFB_Button;
@property (weak, nonatomic) IBOutlet UIButton *weChatButton;
@property (weak, nonatomic) IBOutlet UITextField *moneyText;

@end

@implementation RechargeViewController

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

- (IBAction)TwoBtnClcik:(UIButton *)sender{
    _ZFB_Button.selected   = NO;
    _weChatButton.selected = NO;
    sender.selected        = YES;
}

- (IBAction)payButtonClick:(UIButton *)sender {
}

- (IBAction)clickToCloseKeyBoard:(UITapGestureRecognizer *)sender {
    [_moneyText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
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
