//
//  ParkSubmmitViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "ParkSubmmitViewController.h"

@interface ParkSubmmitViewController ()<THDatePickerViewDelegate>{
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
@property (strong, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) THDatePickerView *dateView1;


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
    
    _dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 245)];
    _dateView.delegate = self;
    _dateView.title = @"请选择时间";
    _dateView.tag = 108;
    [self.view addSubview:_dateView];
    
    _dateView1 = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 245)];
    _dateView1.delegate = self;
    _dateView1.title = @"请选择时间";
    _dateView1.tag = 109;
    [self.view addSubview:_dateView1];
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
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 245, self.view.frame.size.width, 245);
        [self.dateView show];
    }];
}

- (IBAction)livButtonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView1.frame = CGRectMake(0, self.view.frame.size.height - 245, self.view.frame.size.width, 245);
        [self.dateView1 show];
    }];
}

#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
-(void)datePickerView:(THDatePickerView *)pickerView SaveBtnClickDelegate:(NSString *)timer {
    if (pickerView.tag == 108) {
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 245);
        }];
        [_arrTimeButton setTitle:timer forState:UIControlStateNormal];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView1.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 245);
        }];
        [_livTimeButton setTitle:timer forState:UIControlStateNormal];
    }
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate:(THDatePickerView *)pickerView {
    if (pickerView.tag == 108) {
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 245);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView1.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 245);
        }];
    }
}

@end
