//
//  AddParkingViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "AddParkingViewController.h"
#import "public.h"

@interface AddParkingViewController ()<UITextFieldDelegate,AddressPickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    NSString * cityStr;
    NSString * areaStr;
    NSArray  * parkArr;
}

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIButton *parkButton;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *parkNumber;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *remark;
@property (nonatomic ,strong) AddressPickerView * pickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableToBottomDistance;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation AddParkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getParkDataWithArea {
    NSDictionary * param = @{@"city":cityStr,
                             @"area":areaStr
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"/mobile/ratecod/queryCnameList" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        parkArr = responseObject[@"data"];
        [_picker reloadAllComponents];
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)submmitDataToServer {
    UserInfo * user = UserInformation;
    NSDictionary * param = @{@"hyid":user.hyid,
                             @"cname":_name.text,
                             @"city":cityStr,
                             @"area":areaStr,
                             @"villagename":_parkButton.titleLabel.text,
                             @"street":_address.text,
                             @"parkingNumber":_parkNumber.text,
                             @"phonenum":_phoneNumber.text,
                             @"note":_remark.text
                             };
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"/mobile/ratecod/parkingSharePutIn" AndParams:param IfShowHUD:YES Success:^(NSDictionary *responseObject) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"添加成功" message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submmitButtonClick:(UIButton *)sender {
    NSString * title;
    if (!_name.text.length) {
        title = @"请输入姓名";
    } else if (!_cityButton.titleLabel.text.length || [_cityButton.titleLabel.text isEqualToString:@"选择所在城市区县"]) {
        title = @"请选择城市区域";
    } else if (!_parkButton.titleLabel.text.length || [_cityButton.titleLabel.text isEqualToString:@"选择停车场"]) {
        title = @"请选择停车场";
    } else if (!_address.text.length) {
        title = @"请输入详细地址";
    } else if (!_parkNumber.text.length) {
        title = @"请输入车位号";
    } else if (!_phoneNumber.text.length) {
        title = @"请输入手机号";
    } else {
        [self submmitDataToServer];
    }
    
    if (title.length) {
        TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:@""];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            
        }]];
        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)cityButtonClick:(UIButton *)sender {
    [self closeKeyBoard];
    [self.view addSubview:self.pickerView];
}

- (IBAction)parkButtonClick:(UIButton *)sender {
    [self closeKeyBoard];
    [UIView animateWithDuration:0.5 animations:^{
        _tableToBottomDistance.constant = 0;
    }];
}

- (IBAction)cancleButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _tableToBottomDistance.constant = -215;
    }];
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _tableToBottomDistance.constant = -215;
    }];
    NSInteger index = [self.picker selectedRowInComponent:0];
    NSDictionary * tempDic = parkArr[index];
    [_parkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_parkButton setTitle:tempDic[@"cname"] forState:UIControlStateNormal];
    [_parkButton setTitle:tempDic[@"cname"] forState:UIControlStateSelected];
}

- (IBAction)clickToCloseKeyboard:(UITapGestureRecognizer *)sender {
    [self closeKeyBoard];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self closeKeyBoard];
    return YES;
}

- (void)closeKeyBoard {
    [_name resignFirstResponder];
    [_address resignFirstResponder];
    [_parkNumber resignFirstResponder];
    [_phoneNumber resignFirstResponder];
    [_remark resignFirstResponder];
}

- (AddressPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-215+20 , SCREEN_WIDTH, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)cancelBtnClick {
    [_pickerView removeFromSuperview];
}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area {
    cityStr = city;
    areaStr = area;
    [_pickerView removeFromSuperview];
    [_cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cityButton setTitle:[NSString stringWithFormat:@"%@ %@",city,area] forState:UIControlStateNormal];
    [self getParkDataWithArea];
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return parkArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary * tempDic = parkArr[row];
    return tempDic[@"cname"];
}

@end
