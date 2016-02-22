//
//  CDWCategoryModel.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDWCategoryModel : NSObject

/**高亮状态下的图片*/
@property (nonatomic, copy) NSString *highlighted_icon;
/**normal下的图片*/
@property (nonatomic, copy) NSString *icon;
/**名称*/
@property (nonatomic, copy) NSString *name;
/** 小图标*/
@property (nonatomic, copy) NSString *small_icon;
/** 高亮小图标*/
@property (nonatomic, copy) NSString *small_highlighted_icon;
/** 地图图标*/
@property (nonatomic, copy) NSString *map_icon;
/** 子分类数据*/
@property (nonatomic, strong) NSArray *subcategories;

@end
