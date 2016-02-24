//
//  CDWDistrictModel.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDWDistrictModel : NSObject
/**区域名*/
@property (nonatomic, copy) NSString *name;

/**子区域*/
@property (nonatomic, strong) NSArray *subdistricts;

@end
