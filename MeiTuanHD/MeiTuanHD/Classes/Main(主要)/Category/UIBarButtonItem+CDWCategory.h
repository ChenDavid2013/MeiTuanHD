//
//  UIBarButtonItem+CDWCategory.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CDWCategory)

+ (instancetype)barButtonItemAddTarget:(id)target action:(SEL)action icon:(NSString *)icon andHLIcon:(NSString *)HLIcon;

@end
