//
//  CDWRightTableViewCell.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/23.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWRightTableViewCell.h"

@implementation CDWRightTableViewCell

+ (instancetype)rightTableViewCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
   CDWRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end
