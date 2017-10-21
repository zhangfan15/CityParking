//
//  MenuViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "MenuViewController.h"
#import "public.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * titleArr;
    NSArray * imageArr;
}

@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud"]];
    self.table.backgroundColor = [UIColor clearColor];
    titleArr = @[@[@"订单中心",@"神州租车",@"用户中心"],
                 @[@"车位查找",@"共享车位",@"我的车位"],
                 @[@"快速支付"]];
    imageArr = @[@[@"menuOrder",@"markRent",@"menuUser"],
                 @[@"menuSearch",@"menuShare",@"menuMyPark"],
                 @[@"menuPay"]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    UITableView
}

#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"LXMenuCell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
    NSString * imageName = imageArr[indexPath.section][indexPath.row];
    cell.cellImage.image = [UIImage imageNamed:imageName];
    cell.cellSubTitle.hidden = YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4*3, 20.f)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        CGFloat cornerRadius = 10.f;
        
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        //颜色修改
        
        layer.fillColor = [UIColor whiteColor].CGColor;
        
//        layer.strokeColor=[UIColor blueColor].CGColor;
        
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{
                    UIViewController * rentVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"OrderCenterViewController"];
                    [self.mm_drawerController.navigationController pushViewController:rentVC animated:YES];
                    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
                }
                    break;
                case 1:{
                    UIViewController * rentVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"RentOrderListViewController"];
                    [self.mm_drawerController.navigationController pushViewController:rentVC animated:YES];
                    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
                }
                    break;
                case 2:{
                    UIViewController * rentVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"MyInformationViewController"];
                    [self.mm_drawerController.navigationController pushViewController:rentVC animated:YES];
                    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
                }
                    break;
            }
        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    FindCarViewController * rentVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"FindCarViewController"];
                    [self.mm_drawerController.navigationController pushViewController:rentVC animated:YES];
                    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
                }
                    break;
                case 1:{
                }
                    break;
                case 2:{
                    MyParkingViewController * vc = [MainStoryboard instantiateViewControllerWithIdentifier:@"MyParkingViewController"];
                    [self.mm_drawerController.navigationController pushViewController:vc animated:YES];
                    self.mm_drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
                }
                    break;
            }
        }
            break;
        case 2:{
            
        }
            break;
    }
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
