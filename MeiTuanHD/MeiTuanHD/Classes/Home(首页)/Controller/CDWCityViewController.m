//
//  CDWCityViewController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/23.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWCityViewController.h"

@interface CDWCityViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

static NSString *ID = @"city";

@implementation CDWCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"切换城市";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem
                                             barButtonItemAddTarget:self
                                             action:@selector(dismissButtonClick)
                                             icon:@"btn_navigation_close"
                                             andHLIcon:@"btn_navigation_close_hl"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CDWCityViewController" bundle:nil] forCellReuseIdentifier:ID];
    
}

- (void)dismissButtonClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --UITableView的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}



@end
