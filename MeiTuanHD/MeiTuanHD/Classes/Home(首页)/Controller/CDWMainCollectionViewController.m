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

@interface CDWMainCollectionViewController ()

@property (nonatomic, weak)UIBarButtonItem *categoryItem;

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


- (void)setNavigationLeft {
    UIBarButtonItem *meiTuanItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    meiTuanItem.enabled = NO;
    
    CDWNavTopView *categoryView = [CDWNavTopView navTopView];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    [categoryView addTarget:self andAction:@selector(categoryItemClick)];
    
    CDWNavTopView *districtView = [CDWNavTopView navTopView];
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    
    CDWNavTopView *sortView = [CDWNavTopView navTopView];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];

    
    self.navigationItem.leftBarButtonItems = @[meiTuanItem, categoryItem, districtItem, sortItem];
}

- (void)setNavigationRight {
    
    UIBarButtonItem *searchItem = [UIBarButtonItem barButtonItemAddTarget:self action:@selector(searchItemClick) icon:@"icon_search" andHLIcon:@"icon_search_highlighted"];
    UIBarButtonItem *mapItem = [UIBarButtonItem barButtonItemAddTarget:self action:@selector(mapItemClick) icon:@"icon_district" andHLIcon:@"icon_district_highlighted"];
    
    searchItem.customView.width = 60;
    mapItem.customView.width = 60;
    
    self.navigationItem.rightBarButtonItems = @[mapItem, searchItem];
    
}
#pragma mark navigationBar的item点击事件;
- (void)searchItemClick {
    
    NSLog(@"搜索");
}

- (void)mapItemClick {
    
    NSLog(@"地图");
}

- (void)categoryItemClick {
    
    UIPopoverController *categoryPopoverC = [[UIPopoverController alloc] initWithContentViewController:[[CDWCategoryController alloc] init]];
    
    [categoryPopoverC presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
