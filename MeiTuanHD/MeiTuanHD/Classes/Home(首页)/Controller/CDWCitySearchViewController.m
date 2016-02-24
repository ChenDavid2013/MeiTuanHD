//
//  CDWCitySearchViewController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWCitySearchViewController.h"
#import "CDWCityModel.h"

@interface CDWCitySearchViewController ()

@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSMutableArray *resultArray;
@end

static NSString *ID = @"searchCityCell";

@implementation CDWCitySearchViewController

- (NSMutableArray *)resultArray {
    
    if (_resultArray == nil) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;

}

- (NSArray *)cityArray {
    
    if (_cityArray == nil) {
        _cityArray = [CDWCityModel mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cityArray;
}

- (void)setSearchString:(NSString *)searchString {
    
    [self.resultArray removeAllObjects];
    
    _searchString = searchString.copy;
    
    _searchString = _searchString.lowercaseString;
    
    for (CDWCityModel *cityModel in self.cityArray) {
        
        if ([cityModel.pinYin containsString:_searchString] || [cityModel.pinYinHead containsString:_searchString] || [cityModel.name containsString:_searchString]) {
            
            [self.resultArray addObject:cityModel.name];
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

// MARK: --tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = self.resultArray[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"搜索到 %zd 结果",self.resultArray.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [CDWNotificationCenter postNotificationName:CDWCityDidChangeNotification object:nil userInfo:@{CDWcityNamekey : self.resultArray[indexPath.row]}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
