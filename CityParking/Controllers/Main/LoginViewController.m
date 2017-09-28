//
//  LoginViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/27.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,RKDropdownAlertDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮响应事件
//登录
- (IBAction)login:(UIButton *)sender {
    if (!_accountTxtField.text.length) {
        [RKDropdownAlert title:@"请输入账号" message:@"" backgroundColor:COLOR_WITH_HEX(0xe84c3b) textColor:nil time:1 delegate:self];
    } else if (!_passwordTextField.text.length) {
        [RKDropdownAlert title:@"请输入密码" message:@"" backgroundColor:COLOR_WITH_HEX(0xe84c3b) textColor:nil time:1 delegate:self];
    } else {
        NSDictionary * param = @{@"phonenum":_accountTxtField.text,
                                 @"password":_passwordTextField.text,
                                 @"logintype":@"1"
                                 };
        [[NetworkTool shareNetworkTool] GetDataWithURL:@"mobile/user/login" AndParams:param Success:^(NSDictionary *responseObject) {
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:IS_LOGINSUCCESS];
            [NSKeyedArchiver archiveRootObject:[UserInfo modelObjectWithDictionary:responseObject[@"data"]] toFile:USER_INFOR_PATH];
            [self dismissViewControllerAnimated:YES completion:nil];
        } Failure:^(NSString *errorInfo) {
            TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"登录失败" message:@"请检查您的账号密码，重新登录 "];
            [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
                NSLog(@"%@",action.title);
            }]];
            TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
}
//忘记密码
- (IBAction)forgetPassword:(UIButton *)sender {
}
//注册账号
- (IBAction)registerAccount:(id)sender {
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1000) {
        [_accountTxtField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else if (textField.tag == 1001) {
        [_passwordTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)packUpKeyBoard:(id)sender {
    [_accountTxtField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(BOOL)dropdownAlertWasTapped:(RKDropdownAlert*)alert {
    return YES;
}

-(BOOL)dropdownAlertWasDismissed {
    return YES;
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
