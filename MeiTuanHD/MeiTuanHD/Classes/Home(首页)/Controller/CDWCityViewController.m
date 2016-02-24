//
//  CDWCityViewController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/23.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWCityViewController.h"
#import "CDWCityGroupModel.h"
#import "CDWCitySearchViewController.h"

@interface CDWCityViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *coverButton;

@property (nonatomic, strong) NSArray *cityGroupArray;
@property (nonatomic, weak) CDWCitySearchViewController *citySearchViewController;

@end

static NSString *ID = @"city";

@implementation CDWCityViewController

- (CDWCitySearchViewController *)citySearchViewController {
    
    if (_citySearchViewController == nil) {
        CDWCitySearchViewController *citySearchViewController = [[CDWCitySearchViewController alloc] init];
        
        [self addChildViewController:citySearchViewController];
        
        [self.view addSubview:citySearchViewController.view];
        
        [citySearchViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.tableView);
        }];
        
        _citySearchViewController = citySearchViewController;
    }
    return _citySearchViewController;

}

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
    
    self.tableView.tintColor = CDWColor(28, 182, 165);
    
    self.cityGroupArray = [CDWCityGroupModel mj_objectArrayWithFilename:@"cityGroups.plist"];
    
}

- (void)dismissButtonClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --UITableView的数据源 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.cityGroupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cityGroupArray[section] cities].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = [self.cityGroupArray[indexPath.section] cities][indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.cityGroupArray[section] title];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [self.cityGroupArray valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [CDWNotificationCenter postNotificationName:CDWCityDidChangeNotification object:nil userInfo:@{CDWCityNamekey : [self.cityGroupArray[indexPath.section] cities][indexPath.row]}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --searchBar的代理
// MARK: --开始编辑的时候的操作
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
 
    [UIView animateWithDuration:0.25 animations:^{
        
        self.navigationController.navigationBarHidden = YES;
        
        self.searchBar.showsCancelButton = YES;
        
        self.searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
        
        self.coverButton.alpha = 0.5;
    }];
    
    for (UIView *view in searchBar.subviews.firstObject.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            [(UIButton *)view setTitle:@"取消" forState:UIControlStateNormal];
        }
    }

}
// MARK: --结束编辑的时候的操作
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.navigationController.navigationBarHidden = NO;
        
        self.searchBar.showsCancelButton = NO;
        
        self.searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
        
        self.coverButton.alpha = 0;
      
    }];
    
    searchBar.text = @"";
    
    self.citySearchViewController.view.hidden = YES;
    
}

// MARK: --当输入文本就开始查询
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length > 0) {
    
        self.citySearchViewController.view.hidden = NO;
      
    }else {
       
        self.citySearchViewController.view.hidden = YES;
        
    }
    
    self.citySearchViewController.searchString = searchText;
}

// MARK: --点击取消按钮的操作
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [searchBar resignFirstResponder];

}
// MARK: --蒙版点击事件
- (IBAction)coverButtonClick {
    
    [self.searchBar resignFirstResponder];
}
@end
