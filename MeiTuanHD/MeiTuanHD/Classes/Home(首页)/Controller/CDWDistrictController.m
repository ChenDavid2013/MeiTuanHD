//
//  CDWDistrictController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/23.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWDistrictController.h"
#import "CDWNavigationViewController.h"
#import "CDWCityViewController.h"

@interface CDWDistrictController ()

@end

@implementation CDWDistrictController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark --切换城市点击事件
- (IBAction)changeCityClick:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
 
    CDWCityViewController *cityViewController = [[CDWCityViewController alloc] init];
    
    CDWNavigationViewController *nav = [[CDWNavigationViewController alloc] initWithRootViewController:cityViewController];
    
       nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
#warning 这里不能这样设置,否则什么都会没有;
//    [self presentViewController:nav animated:YES completion:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
