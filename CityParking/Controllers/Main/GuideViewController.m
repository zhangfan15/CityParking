//
//  GuideViewController.m
//  CityParking
//
//  Created by ZhangFan on 2017/9/18.
//  Copyright © 2017年 ZhangFan. All rights reserved.
//

#import "GuideViewController.h"
#import "public.h"

@interface GuideViewController (){
    MMDrawerController * drawerController;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDrawerRootViewController];
    // Do any additional setup after loading the view.
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:IS_FIRST_LAUNCH] isEqualToString:@"YES"]) {
        [self.navigationController pushViewController:drawerController animated:NO];
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:IS_FIRST_LAUNCH];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDrawerRootViewController {
    //1、初始化控制器
    UIViewController *centerVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    UIViewController *leftVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    //3、使用MMDrawerController
    drawerController = [[MMDrawerController alloc]initWithCenterViewController:centerVC leftDrawerViewController:leftVC];
    
    //4、设置打开/关闭抽屉的手势
    drawerController.openDrawerGestureModeMask  = MMOpenDrawerGestureModeNone;
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    //5、设置左右两边抽屉显示的多少
    drawerController.maximumLeftDrawerWidth = SCREEN_WIDTH/4*3;
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
