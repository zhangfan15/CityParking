//
//  DetailInfoViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/19.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "public.h"

@interface DetailInfoViewController (){
    NSArray * parkArr;
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerToBottomHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation DetailInfoViewController

- (IBAction)clickToCloseKeyBoard:(UITapGestureRecognizer *)sender {
    [_name resignFirstResponder];
    [_email resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUserInformation];
    parkArr = @[@"男",@"女"];
}

- (void)getUserInformation {
    UserInfo * user = UserInformation;
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/user/queryByPhonenum" AndParams:@{@"phonenum":user.phonenum} IfShowHUD:NO Success:^(NSDictionary *responseObject) {
        UserInfo * tempUser = [UserInfo modelObjectWithDictionary:responseObject[@"data"]];
        [NSKeyedArchiver archiveRootObject:tempUser toFile:USER_INFOR_PATH];
        _account.text = tempUser.phonenum;
        _name.text = tempUser.username;
        [_sexButton setTitle:tempUser.sex forState:UIControlStateNormal];
        _email.text = tempUser.email;
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

- (IBAction)leftButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonClick:(UIButton *)sender {
    NSString * str;
    if (!_name.text.length) {
        str = @"请输入姓名";
    }else if (!_email.text.length) {
        str = @"请输入邮箱";
    }
    TYAlertView *alertView = [TYAlertView alertViewWithTitle: str message:@""];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
    }]];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    return;
    UserInfo * user = UserInformation;
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"username":_name.text,
                             @"sex":_sexButton.titleLabel.text,
                             @"email":_email.text,
                             @"phonenum":user.phonenum
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/user/updateiOSUser" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        UserInfo * user = UserInformation;
        user.username = _name.text;
        user.sex = _sexButton.titleLabel.text;
        user.email = _email.text;
        [NSKeyedArchiver archiveRootObject:user toFile:USER_INFOR_PATH];
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"修改成功" message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    } Failure:^(NSString *errorInfo) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"连接失败" message:@"请检查网络后重试"];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 215);
    }];
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    NSInteger index = [_picker selectedRowInComponent:0];
    [_sexButton setTitle:parkArr[index] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 215);
    }];
}

- (IBAction)sexButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-215, SCREEN_WIDTH, 215);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return parkArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * str = parkArr[row];
    return str;
}

@end
