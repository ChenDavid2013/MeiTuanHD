//
//  CDWLeftTableViewCell.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/23.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWLeftTableViewCell.h"

@implementation CDWLeftTableViewCell

+ (instancetype)leftTableViewCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier andIndexPath:(NSIndexPath *)indexPath {
    
   CDWLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    
    return cell;
}
@end
