//
//  CDWCategoryController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWCategoryController.h"
#import "CDWDropdownView.h"
#import "CDWCategoryModel.h"

@interface CDWCategoryController ()

@end

@implementation CDWCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CDWDropdownView *dropdownView = [CDWDropdownView dropdownView];
    
    [self.view addSubview:dropdownView];
    
    self.preferredContentSize = dropdownView.size;
    
    dropdownView.categoryArray = [CDWCategoryModel mj_objectArrayWithFilename:@"categories.plist"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
