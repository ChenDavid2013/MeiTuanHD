//
//  CDWCityViewController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/23.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWCityViewController.h"

@interface CDWCityViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    self.searchBar.tintColor = CDWColor(28, 182, 165);
    
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

#pragma mark --searchBar的代理
// MARK: --开始编辑的时候的操作
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
 
    [UIView animateWithDuration:0.25 animations:^{
        
        self.navigationController.navigationBarHidden = YES;
        
        self.searchBar.showsCancelButton = YES;
        
        self.searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    }];
     
    for (UIView *view in searchBar.subviews.firstObject.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal];
            continue;
        }
    }
    
}
// MARK: --结束编辑的时候的操作
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.navigationController.navigationBarHidden = NO;
        
        self.searchBar.showsCancelButton = NO;
        
        self.searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];

    }];
    
}

// MARK: --当输入文本就开始查询
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%s",__func__);

    
}

// MARK: --点击取消按钮的操作
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"%s",__func__);
    [searchBar resignFirstResponder];
}

@end
