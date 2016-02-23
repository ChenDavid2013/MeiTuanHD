//
//  CDWMainCollectionViewController.m
//  MeiTuanHD
//
//  Created by 有何不可 on 16/2/22.
//  Copyright © 2016年 有何不可. All rights reserved.
//

#import "CDWMainCollectionViewController.h"
#import "CDWNavTopView.h"
#import "CDWCategoryController.h"
#import "CDWDistrictController.h"

@interface CDWMainCollectionViewController ()

@property (nonatomic, weak) UIBarButtonItem *categoryItem;
@property (nonatomic, weak) UIBarButtonItem *districtItem;
@property (nonatomic, weak) UIBarButtonItem *sortItem;

@end

@implementation CDWMainCollectionViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        self = [[CDWMainCollectionViewController  alloc] initWithCollectionViewLayout:flowLayout];
    }
    return self;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = CDWMainColor;
    
    [self setNavigationLeft];
    [self setNavigationRight];
    
    // Do any additional setup after loading the view.
}

#pragma mark --导航栏左边按钮的是创建
- (void)setNavigationLeft {
    UIBarButtonItem *meiTuanItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    meiTuanItem.enabled = NO;
    
    CDWNavTopView *categoryView = [CDWNavTopView navTopView];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    [categoryView addTarget:self andAction:@selector(categoryItemClick)];
    
    CDWNavTopView *districtView = [CDWNavTopView navTopView];
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    self.districtItem = districtItem;
    [districtView addTarget:self andAction:@selector(districtItemClick)];
    
    CDWNavTopView *sortView = [CDWNavTopView navTopView];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];

    self.navigationItem.leftBarButtonItems = @[meiTuanItem, categoryItem, districtItem, sortItem];
}

#pragma mark --导航栏右边的创建
- (void)setNavigationRight {
    
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemAddTarget:self action:@selector(searchItemClick) icon:@"icon_search" andHLIcon:@"icon_search_highlighted"];
    UIBarButtonItem *mapItem = [UIBarButtonItem barButtonItemAddTarget:self action:@selector(mapItemClick) icon:@"icon_district" andHLIcon:@"icon_district_highlighted"];
    
    searchItem.customView.width = 60;
    mapItem.customView.width = 60;
    
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
    
}

#pragma mark --搜索item点击事件
- (void)searchItemClick {
    
    NSLog(@"搜索");
}
#pragma mark --地图item点击事件
- (void)mapItemClick {
    
    NSLog(@"地图");
}
#pragma mark --分类item点击事件
- (void)categoryItemClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIPopoverController *categoryPopoverC = [[UIPopoverController alloc] initWithContentViewController:[[CDWCategoryController alloc] init]];
    
    [categoryPopoverC presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
#pragma mark --区域item点击事件
- (void)districtItemClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIPopoverController *districtPopoverC = [[UIPopoverController alloc] initWithContentViewController:[[CDWDistrictController alloc] init]];
    
    [districtPopoverC presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
