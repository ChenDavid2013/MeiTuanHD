//
//  CDWDropdownView.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWDropdownView.h"
#import "CDWCategoryModel.h"
#import "CDWLeftTableViewCell.h"
#import "CDWRightTableViewCell.h"
#import "CDWDistrictModel.h"

@interface CDWDropdownView ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic, strong) CDWCategoryModel *selectedCategoryModel;
@property (nonatomic, strong) CDWDistrictModel *selectedDistrictModel;
@end

//static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

@implementation CDWDropdownView

+ (instancetype)dropdownView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"CDWDropdownView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //    [self.leftTableView registerClass:[CDWLeftTableViewCell class] forCellReuseIdentifier:leftCell];
    [self.rightTableView registerClass:[CDWRightTableViewCell class] forCellReuseIdentifier:rightCell];
}
// MARK: --tableView的数据源代理方法的实现;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.categoryArray) {
        
        if (tableView == self.leftTableView) {
            return self.categoryArray.count;
        }else {
            
            return self.selectedCategoryModel.subcategories.count;
        }
    }else {
        
        if (tableView == self.leftTableView) {
            return self.districtArray.count;
        }else {
            
            return self.selectedDistrictModel.subdistricts.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (self.categoryArray) {
        if (tableView == self.leftTableView) {
            
            //        cell = [CDWLeftTableViewCell leftTableViewCellWithTableView:tableView identifier:leftCell andIndexPath:indexPath];
            
            cell = [CDWLeftTableViewCell leftTableViewCellWithTableView:tableView];
            
            CDWCategoryModel *categoryModel = self.categoryArray[indexPath.row];
            
            cell.textLabel.text = categoryModel.name;
            cell.imageView.image = [UIImage imageNamed:categoryModel.icon];
            cell.imageView.highlightedImage = [UIImage imageNamed:categoryModel.highlighted_icon];
            
            if (categoryModel.subcategories) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
        }else {
            
            cell = [CDWRightTableViewCell rightTableViewCellWithTableView:tableView identifier:rightCell andIndexPath:indexPath];
            
            cell.textLabel.text = self.selectedCategoryModel.subcategories[indexPath.row];
            
        }
        
    }else {
        
        if (tableView == self.leftTableView) {
            
            cell = [CDWLeftTableViewCell leftTableViewCellWithTableView:tableView];
            
            CDWDistrictModel *districtModel = self.districtArray[indexPath.row];
            
            cell.textLabel.text = districtModel.name;
            
            if (districtModel.subdistricts) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else {
            
            cell = [CDWRightTableViewCell rightTableViewCellWithTableView:tableView identifier:rightCell andIndexPath:indexPath];
            
            cell.textLabel.text = self.selectedDistrictModel.subdistricts[indexPath.row];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.categoryArray) {
        
        if (tableView == self.leftTableView) {
            
            self.selectedCategoryModel = self.categoryArray[indexPath.row];
            
            if (!self.selectedCategoryModel.subcategories) {
                [CDWNotificationCenter postNotificationName:CDWCategoryViewNotification object:nil userInfo:@{CDWCategoryModelKey : self.selectedCategoryModel}];
            }
            
        }else {
            
//            NSLog(@"%@",self.selectedCategoryModel.subcategories[indexPath.row]);
            [CDWNotificationCenter postNotificationName:CDWCategoryViewNotification
                                                 object:nil
                                               userInfo:@{
                                                          CDWCategoryModelKey : self.selectedCategoryModel,
                                                          CDWCategorySubtitleKey : self.selectedCategoryModel.subcategories[indexPath.row]
                                                          }];
            
        }
        
    }else {
        
        if (tableView == self.leftTableView) {
            
            self.selectedDistrictModel = self.districtArray[indexPath.row];
            
            if (!self.selectedDistrictModel.subdistricts) {
                [CDWNotificationCenter postNotificationName:CDWDistrictViewNotification object:nil userInfo:@{CDWDistrictModelKey : self.selectedDistrictModel}];
            }
        }else {
            
//            NSLog(@"%@",self.selectedDistrictModel.subdistricts[indexPath.row]);
            [CDWNotificationCenter postNotificationName:CDWDistrictViewNotification
                                                 object:nil
                                               userInfo:@{
                                                          CDWDistrictModelKey : self.selectedDistrictModel,
                                                          CDWDistrictSubDistrictKey : self.selectedDistrictModel.subdistricts[indexPath.row]
                                                          }];
            
        }
    }
    
    [self.rightTableView reloadData];
}

@end


