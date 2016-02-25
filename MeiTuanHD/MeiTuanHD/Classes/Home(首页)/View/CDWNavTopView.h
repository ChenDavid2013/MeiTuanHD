//
//  CDWNavTopView.h
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDWNavTopView : UIView

+ (instancetype)navTopView;

- (void)addTarget:(id)target andAction:(SEL)action;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;
- (void)setButtonWithIcon:(NSString *)icon andHLIcon:(NSString *)HLIcon;

@end
