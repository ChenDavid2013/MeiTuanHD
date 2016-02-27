//
//  CDWDealCell.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWDealCell.h"
#import "CDWDealModel.h"

@interface CDWDealCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgUrlView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *icDealNewImgView;

@end

@implementation CDWDealCell

- (void)setDealModel:(CDWDealModel *)dealModel {
    
    _dealModel = dealModel;
    
    [self.imgUrlView sd_setImageWithURL:[NSURL URLWithString:dealModel.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    self.titleLabel.text = dealModel.title;
    self.descLabel.text = dealModel.desc;
    self.currentPriceLabel.text = [self reversionDecimalsWithString:dealModel.current_price];
    self.listPriceLabel.text = [self reversionDecimalsWithString:dealModel.list_price];
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售出 %@", dealModel.purchase_count];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [formatter stringFromDate:[NSDate date]];
    
    self.icDealNewImgView.hidden = [dealModel.publish_date compare:nowStr] == NSOrderedAscending ? YES : NO;
}
//保留有效小数;
- (NSString *)reversionDecimalsWithString:(NSString *)str {
    
    NSRange range = [str rangeOfString:@"."];
    
    if (range.location != NSNotFound) {
        
        if (str.length - range.location > 3) {
         
            return [NSString stringWithFormat:@"¥ %.2f", [str floatValue]];
        }
    }
    return [NSString stringWithFormat:@"¥ %@", str];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [[UIImage imageNamed:@"placeholder_deal"] drawInRect:rect];
}

@end
