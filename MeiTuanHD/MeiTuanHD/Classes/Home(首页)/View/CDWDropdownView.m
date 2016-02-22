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

@interface CDWDropdownView ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property (nonatomic, strong) CDWCategoryModel *selectedCategoryModel;

@end

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

@implementation CDWDropdownView

+ (instancetype)dropdownView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"CDWDropdownView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self.leftTableView registerClass:[CDWLeftTableViewCell class] forCellReuseIdentifier:leftCell];
    [self.rightTableView registerClass:[CDWRightTableViewCell class] forCellReuseIdentifier:rightCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) {
        return self.categoryArray.count;
    }else {
        
        return self.selectedCategoryModel.subcategories.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (tableView == self.leftTableView) {
        
        cell = [CDWLeftTableViewCell leftTableViewCellWithTableView:tableView identifier:leftCell andIndexPath:indexPath];
        
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        self.selectedCategoryModel = self.categoryArray[indexPath.row];
        
        [self.rightTableView reloadData];
        
    }else {
        
        NSLog(@"%@",self.selectedCategoryModel.subcategories[indexPath.row]);
    }
}

@end


