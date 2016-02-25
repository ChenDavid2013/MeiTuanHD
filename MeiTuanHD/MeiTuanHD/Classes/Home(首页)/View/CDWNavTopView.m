//
//  CDWNavTopView.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWNavTopView.h"

@interface CDWNavTopView ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation CDWNavTopView

+ (instancetype)navTopView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"CDWNavTopView" owner:nil options:nil].lastObject;
    
}

- (void)awakeFromNib {
    
    //如果使用AutoLayout, 那么里面的autoresizingMask就会默认勾选上(上边和左边)
    //如果我们在方向变化的时候, 不需要改变控件的大小, 那么就需要设置UIViewAutoresizingNone
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)addTarget:(id)target andAction:(SEL)action {
    
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitle:(NSString *)title {
    
    self.titleLabel.text = title;
}
- (void)setSubtitle:(NSString *)subtitle {

    self.subtitleLabel.text = subtitle;
}
- (void)setButtonWithIcon:(NSString *)icon andHLIcon:(NSString *)HLIcon {
    
    [self.button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:HLIcon] forState:UIControlStateHighlighted];
}

@end
