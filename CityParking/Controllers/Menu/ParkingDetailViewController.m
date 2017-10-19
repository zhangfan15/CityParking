//
//  ParkingDetailViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/10/16.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "ParkingDetailViewController.h"

@interface ParkingDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray * dataArr;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *parkName;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *parkNumber;
@property (weak, nonatomic) IBOutlet UILabel *parkPrice;
@property (weak, nonatomic) IBOutlet UILabel *parkAddress;

@end

@implementation ParkingDetailViewController

@synthesize markModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr = [NSMutableArray array];
    [self initSubViews];
    [self getParkingDataToRefreshTable];
}

- (void)getParkingDataToRefreshTable {
    [[NetworkTool shareNetworkTool] PostDataWithURL:@"mobile/InformationReport/realTimeVehicleState" AndParams:@{@"ckid":@"16121317253526"}  IfJSONType:NO Success:^(NSDictionary *responseObject) {
        NSArray * arr = responseObject[@"data"];
        if (arr != nil && arr.count) {
            for (NSDictionary * tempDic in arr) {
                ParkDetailModel * model = [ParkDetailModel modelObjectWithDictionary:tempDic];
                [dataArr addObject:model];
            }
            [_collection reloadData];
        }
    } Failure:^(NSString *errorInfo) {
        
    }];
}

- (void)initSubViews {
    self.imageView.image = [UIImage imageNamed:markModel.tp];
    self.parkName.text = markModel.cname;
    self.parkAddress.text = markModel.dz;
    if (markModel.time != nil && [markModel.time isKindOfClass:[NSString class]]) {
        self.startTime.text = [NSString stringWithFormat:@"时间：%@",markModel.time];
    }else {
        self.startTime.text = @"时间：00:00-23:59";
    }
    
    self.parkNumber.text = [NSString stringWithFormat:@"车位：%@/%.lf",markModel.totalNumber,markModel.sycw];
    self.parkPrice.text = [NSString stringWithFormat:@"¥%@／h",markModel.charge];
    
    UICollectionViewFlowLayout * customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    [customLayout setItemSize:CGSizeMake(SCREEN_WIDTH/6, SCREEN_WIDTH/6)];
    [customLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    customLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
    customLayout.minimumInteritemSpacing=0;
    customLayout.minimumLineSpacing=0;
    [_collection setCollectionViewLayout:customLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClick:(UIButton *)sender {
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString * cellIdentifar = @"LXParkingCell";
    ParkingCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifar forIndexPath:indexPath];
    ParkDetailModel * model = dataArr[indexPath.item];
    if (indexPath.item%6 == 5) {
        cell.straitLine.hidden = YES;
    }else {
        cell.straitLine.hidden = NO;
    }
    if (model.flag.intValue != 1) {
        cell.cellImage.image = [UIImage imageNamed:@"parkingCarSelect"];
        cell.cellTitle.textColor = COLOR_WITH_HEX(0xdd5652);
    } else {
        cell.cellImage.image = [UIImage imageNamed:@"parkingCar"];
        cell.cellTitle.textColor = UIColor.lightGrayColor;
    }
    cell.cellTitle.text = model.code;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
