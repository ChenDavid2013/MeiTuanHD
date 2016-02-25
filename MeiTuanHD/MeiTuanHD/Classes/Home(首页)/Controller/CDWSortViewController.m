//
//  CDWSortViewController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/24.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWSortViewController.h"
#import "CDWSortModel.h"

@interface CDWSortViewController ()

@property (nonatomic, strong) NSArray *sortArray;

@end

@implementation CDWSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = CDWMainColor;
    
    NSArray *sortArray = [CDWSortModel mj_objectArrayWithFilename:@"sorts.plist"];
    
    self.sortArray = sortArray;
    
    CGFloat width = 100;
    CGFloat height = 30;
    CGFloat margin = 15;
    
    [sortArray enumerateObjectsUsingBlock:^(CDWSortModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = idx + 100;
        
        [button setTitle:obj.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        
        [self.view addSubview:button];
        
        button.width = width;
        button.height = height;
        button.x = margin;
        button.y = margin + (margin + height) * idx;
        
        [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    self.preferredContentSize = CGSizeMake(2 * margin + width, margin + (margin + height) * sortArray.count);
}

- (void)sortButtonClick:(UIButton *)button {

    [CDWNotificationCenter postNotificationName:CDWSortNotification object:nil userInfo:@{CDWSortKey : self.sortArray[button.tag - 100]}];
}

@end
