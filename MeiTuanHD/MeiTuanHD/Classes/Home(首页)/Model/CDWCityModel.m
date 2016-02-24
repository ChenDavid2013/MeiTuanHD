//
//  CDWCityModel.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWCityModel.h"
#import "CDWDistrictModel.h"

@implementation CDWCityModel

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"districts" : @"CDWDistrictModel"};
}

@end
