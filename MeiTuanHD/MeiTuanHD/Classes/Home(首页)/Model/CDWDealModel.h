//
//  CDWDealModel.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/26.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDWDealModel : NSObject
/**团购单ID*/
@property (nonatomic, copy) NSString *deal_id;
/**团购标题*/
@property (nonatomic, copy) NSString *title;
/**团购描述, description是关键字所以要另起名字*/
@property (nonatomic, copy) NSString *desc;
/**团购包含商品原价值*/
@property (nonatomic, copy) NSString *list_price;
/**团购价格*/
@property (nonatomic, copy) NSString *current_price;
/**团购当前已购买数*/
@property (nonatomic, copy) NSString *purchase_count;
/**	小尺寸团购图片链接，最大图片尺寸160×100*/
@property (nonatomic, copy) NSString *s_image_url;
/** 团购图片链接，最大图片尺寸450×280*/
@property (nonatomic, copy) NSString *image_url;
/**团购HTML5页面链接，适用于移动应用和联网车载应用*/
@property (nonatomic, copy) NSString *deal_h5_url;
/**团购发布上线日期*/
@property (nonatomic, copy) NSString *publish_date;


@end
