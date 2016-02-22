//
//  UIBarButtonItem+CDWCategory.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "UIBarButtonItem+CDWCategory.h"

@implementation UIBarButtonItem (CDWCategory)

+ (instancetype)barButtonItemAddTarget:(id)target action:(SEL)action icon:(NSString *)icon andHLIcon:(NSString *)HLIcon {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:HLIcon] forState:UIControlStateHighlighted];
    
    button.size = button.currentImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    return barButtonItem;
}


@end
