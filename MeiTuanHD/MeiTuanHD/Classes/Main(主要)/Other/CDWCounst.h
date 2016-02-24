//
//  CDWCounst.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <Foundation/Foundation.h>

/** NSLog 输出宏*/
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
/**颜色*/
#define CDWColor(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
/**主要显示颜色*/
#define CDWMainColor CDWColor(230, 230, 230)
/**通知中心*/
#define CDWNotificationCenter [NSNotificationCenter defaultCenter]

extern NSString *const CDWCityDidChangeNotification;
extern NSString *const CDWSortNotification;
extern NSString *const CDWCategoryViewNotification;
extern NSString *const CDWDistrictViewNotification;



extern NSString *const CDWCityNamekey;
extern NSString *const CDWSortKey;
extern NSString *const CDWCategoryModelKey;
extern NSString *const CDWCategorySubtitleKey;
extern NSString *const CDWDistrictModelKey;
extern NSString *const CDWDistrictSubDistrictKey;
