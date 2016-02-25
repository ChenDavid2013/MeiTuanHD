//
//  CDWDealCell.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWDealCell.h"

@implementation CDWDealCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [[UIImage imageNamed:@"placeholder_deal"] drawInRect:rect];
}

@end
