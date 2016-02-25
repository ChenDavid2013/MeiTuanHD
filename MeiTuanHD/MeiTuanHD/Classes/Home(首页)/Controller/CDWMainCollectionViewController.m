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
#import "CDWCityModel.h"
#import "CDWSortViewController.h"
#import "CDWSortModel.h"
#import "CDWCategoryModel.h"
#import "CDWDistrictModel.h"

@interface CDWMainCollectionViewController ()

@property (nonatomic, weak) UIBarButtonItem *categoryItem;
@property (nonatomic, weak) UIBarButtonItem *districtItem;
@property (nonatomic, weak) UIBarButtonItem *sortItem;

@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, copy) NSString *selectedCityName;

@property (nonatomic, strong) NSArray *dealArray;
@end

@implementation CDWMainCollectionViewController

- (NSArray *)cityArray {
    
    if (_cityArray == nil) {
        _cityArray = [CDWCityModel mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cityArray;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake(305, 305);
        
        self = [[CDWMainCollectionViewController  alloc] initWithCollectionViewLayout:flowLayout];
    }
    return self;
}

static NSString * const reuseIdentifier = @"homeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"CDWDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = CDWMainColor;
    
    [self setNavigationLeft];
    [self setNavigationRight];
    
    // Do any additional setup after loading the view.
    [CDWNotificationCenter addObserver:self selector:@selector(cityDidChangeNotification:) name:CDWCityDidChangeNotification object:nil];
    [CDWNotificationCenter addObserver:self selector:@selector(sortDidChangeNotification:) name:CDWSortNotification object:nil];
    [CDWNotificationCenter addObserver:self selector:@selector(categoryChoosedNotification:) name:CDWCategoryViewNotification object:nil];
    [CDWNotificationCenter addObserver:self selector:@selector(districtChoosedNotification:) name:CDWDistrictViewNotification object:nil];
    
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
}

// MARK: --横竖屏适配

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    NSInteger count = size.width > size.height ? 3 : 2;
    
    CGFloat margin = (size.width - flowLayout.itemSize.width * count) / (count + 1);
    
    flowLayout.minimumLineSpacing = margin;
    flowLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
}

// MARK: --通知的实现
#pragma mark --城市选择通知;
- (void)cityDidChangeNotification:(NSNotification *)notification {
    
    self.selectedCityName = notification.userInfo[CDWCityNamekey];
    
    CDWNavTopView *districtView = self.districtItem.customView;
    
    [districtView setTitle:[NSString stringWithFormat:@"%@-全部", self.selectedCityName]];
    [districtView setSubtitle:@""];
 
}
#pragma mark --排序通知
- (void)sortDidChangeNotification:(NSNotification *)notification {
    
    CDWSortModel *sortModel = notification.userInfo[CDWSortKey];
    
    CDWNavTopView *sortView = self.sortItem.customView;
    
    [sortView setSubtitle:sortModel.label];
    
    NSLog(@"%@",sortModel.value);
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --分类选取通知
- (void)categoryChoosedNotification:(NSNotification *)notification {
    
    CDWCategoryModel *categoryModel = notification.userInfo[CDWCategoryModelKey];
    CDWNavTopView *categoryView = self.categoryItem.customView;
    
    [categoryView setTitle:categoryModel.name];
    [categoryView setButtonWithIcon:categoryModel.icon andHLIcon:categoryModel.highlighted_icon];
    [categoryView setSubtitle:notification.userInfo[CDWCategorySubtitleKey]];
    NSLog(@"%@",notification.userInfo[CDWCategoryModelKey]);
    NSLog(@"%@",notification.userInfo[CDWCategorySubtitleKey]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -区域选取通知
- (void)districtChoosedNotification:(NSNotification *)notification {
    
    CDWDistrictModel *districtModel = notification.userInfo[CDWDistrictModelKey];
    CDWNavTopView *districtView = self.districtItem.customView;
    
    [districtView setTitle:[NSString stringWithFormat:@"%@-%@", self.selectedCityName, districtModel.name]];
    [districtView setSubtitle:notification.userInfo[CDWDistrictSubDistrictKey]];
    
    NSLog(@"%@",notification.userInfo[CDWDistrictModelKey]);
    NSLog(@"%@",notification.userInfo[CDWDistrictSubDistrictKey]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    
    [CDWNotificationCenter removeObserver:self];
}

// MARK: --导航栏的创建
#pragma mark --导航栏左边按钮的是创建
- (void)setNavigationLeft {
    UIBarButtonItem *meiTuanItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    meiTuanItem.enabled = NO;
    
    CDWNavTopView *categoryView = [CDWNavTopView navTopView];
    [categoryView setTitle:@"全部分类"];
    [categoryView setSubtitle:@""];
    [categoryView setButtonWithIcon:@"icon_category_-1" andHLIcon:@"icon_filter_category_highlighted_-1"];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    [categoryView addTarget:self andAction:@selector(categoryItemClick)];
    
    CDWNavTopView *districtView = [CDWNavTopView navTopView];
    [districtView setTitle:[NSString stringWithFormat:@"北京-全部"]];
    [districtView setButtonWithIcon:@"icon_district" andHLIcon:@"icon_district_highlighted"];
    [districtView setSubtitle:@""];
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    self.districtItem = districtItem;
    [districtView addTarget:self andAction:@selector(districtItemClick)];
    
    CDWNavTopView *sortView = [CDWNavTopView navTopView];
    [sortView setTitle:@"排序"];
    [sortView setSubtitle:@"默认排序"];
    [sortView setButtonWithIcon:@"icon_sort" andHLIcon:@"icon_sort_highlighted"];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortView];
    self.sortItem = sortItem;
    [sortView addTarget:self andAction:@selector(sortItemClick)];
    
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

// MARK: --导航栏item的事件点击
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
    
    CDWDistrictController *districtVc = [[CDWDistrictController alloc] init];
    
    for (CDWCityModel *cityModel in self.cityArray) {
        if ([cityModel.name isEqualToString:self.selectedCityName]) {
            
            districtVc.districts = cityModel.districts;
        }
    }

    UIPopoverController *districtPopoverC = [[UIPopoverController alloc] initWithContentViewController:districtVc];
    
    [districtPopoverC presentPopoverFromBarButtonItem:self.districtItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark --排序点击事件
- (void)sortItemClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CDWSortViewController *sortVC = [[CDWSortViewController alloc] init];
    
    UIPopoverController *sortPopoverVC = [[UIPopoverController alloc] initWithContentViewController:sortVC];
    
    [sortPopoverVC presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

// MARK: --网络请求数据
- (void)loadData {
    
    DPAPI *dpAPI = [[DPAPI alloc] init];
    
    [dpAPI requestWithURL:@"v1/deal/find_deals" params:@{@"city": @"北京"} delegate:self];
    NSLog (@"失败");
}

// MARK: --collectionView的数据源, 代理方法实现

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}
@end
