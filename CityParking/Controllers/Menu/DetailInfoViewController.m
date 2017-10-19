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
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerToBottomHeight;

@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    parkArr = @[@"男",@"女"];
    UserInfo * user = UserInformation;
    _name.text = user.username;
    [_sexButton setTitle:user.sex forState:UIControlStateNormal];
    _email.text = user.email;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonClick:(UIButton *)sender {
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _pickerToBottomHeight.constant = -215;
    }];
}

- (IBAction)sureButtonClick:(UIButton *)sender {
    NSInteger index = [_picker selectedRowInComponent:0];
    [_sexButton setTitle:parkArr[index] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 animations:^{
        _pickerToBottomHeight.constant = -215;
    }];
}

- (IBAction)sexButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        _pickerToBottomHeight.constant = 0;
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
