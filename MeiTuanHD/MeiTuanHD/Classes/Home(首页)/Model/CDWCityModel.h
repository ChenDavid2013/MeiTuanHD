//
//  CDWCityModel.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDWCityModel : NSObject
/**城市名*/
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pinYin;
@property (nonatomic, copy) NSString *pinYinHead;
/**区域数组*/
@property (nonatomic, strong) NSArray *districts;

@end
