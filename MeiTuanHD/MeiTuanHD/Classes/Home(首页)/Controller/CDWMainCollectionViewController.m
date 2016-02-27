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
#import "CDWDealModel.h"
#import "CDWDealCell.h"

@interface CDWMainCollectionViewController ()<DPRequestDelegate>

@property (nonatomic, weak) UIBarButtonItem *categoryItem;
@property (nonatomic, weak) UIBarButtonItem *districtItem;
@property (nonatomic, weak) UIBarButtonItem *sortItem;
/**选中的城市*/
@property (nonatomic, copy) NSString *selectedCityName;
/**选中的排序方式*/
@property (nonatomic, strong) NSNumber *selectedSortValue;
/**选中的分类*/
@property (nonatomic, copy) NSString *selectedCategory;
/**选中的区域*/
@property (nonatomic, copy) NSString *selectedDistrict;
/**货单模型数组*/
@property (nonatomic, strong) NSMutableArray *dealArray;
/**城市模型数组*/
@property (nonatomic, strong) NSArray *cityArray;

@end

@implementation CDWMainCollectionViewController

- (NSMutableArray *)dealArray {
    if (_dealArray == nil) {
        _dealArray = [[NSMutableArray alloc] init];
    }
    return _dealArray;

}

- (NSArray *)cityArray {
    
    if (_cityArray == nil) {
        _cityArray = [CDWCityModel mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cityArray;

}

- (instancetype)init {
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
    
   
    [self loadData];
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
 
    [self loadData];
}
#pragma mark --排序通知
- (void)sortDidChangeNotification:(NSNotification *)notification {
    
    CDWSortModel *sortModel = notification.userInfo[CDWSortKey];
    
    CDWNavTopView *sortView = self.sortItem.customView;
    
    [sortView setSubtitle:sortModel.label];
    
    self.selectedSortValue = sortModel.value;
    
    NSLog(@"%@",sortModel.value);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadData];
}
#pragma mark --分类选取通知
- (void)categoryChoosedNotification:(NSNotification *)notification {
    
    CDWCategoryModel *categoryModel = notification.userInfo[CDWCategoryModelKey];
    CDWNavTopView *categoryView = self.categoryItem.customView;
    
    [categoryView setTitle:categoryModel.name];
    [categoryView setButtonWithIcon:categoryModel.icon andHLIcon:categoryModel.highlighted_icon];
    [categoryView setSubtitle:notification.userInfo[CDWCategorySubtitleKey]];
    //在给选中的分类赋值前  先判断是否右边的有值,和左边的是否等于"全部分类",  当判断完成后还要判断右边的是否是"全部"
    self.selectedCategory = [(categoryModel.subcategories == nil || [categoryModel.name isEqualToString: @"全部分类"] ? nil : notification.userInfo[CDWCategorySubtitleKey]) isEqualToString:@"全部"] ? categoryModel.name : notification.userInfo[CDWCategorySubtitleKey];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self loadData];
}
#pragma mark -区域选取通知
- (void)districtChoosedNotification:(NSNotification *)notification {
    
    CDWDistrictModel *districtModel = notification.userInfo[CDWDistrictModelKey];
    CDWNavTopView *districtView = self.districtItem.customView;
    
    [districtView setTitle:[NSString stringWithFormat:@"%@-%@", self.selectedCityName, districtModel.name]];
    [districtView setSubtitle:notification.userInfo[CDWDistrictSubDistrictKey]];
    //在给选中的区域赋值前  先判断是否右边的有值,和左边的是否等于"全部",  当判断完成后还要判断右边的是否是"全部"
    self.selectedDistrict = [(districtModel.subdistricts == nil || [districtModel.name isEqualToString:@"全部"] ? nil : notification.userInfo[CDWDistrictSubDistrictKey]) isEqualToString:@"全部"] ? districtModel.name : notification.userInfo[CDWDistrictSubDistrictKey];
    
    NSLog(@"%@- %@",districtModel.name, notification.userInfo[CDWDistrictSubDistrictKey]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self loadData];
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
    self.selectedCategory = nil;
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryView];
    self.categoryItem = categoryItem;
    [categoryView addTarget:self andAction:@selector(categoryItemClick)];
    
    CDWNavTopView *districtView = [CDWNavTopView navTopView];
    [districtView setTitle:[NSString stringWithFormat:@"北京-全部"]];
    [districtView setButtonWithIcon:@"icon_district" andHLIcon:@"icon_district_highlighted"];
    [districtView setSubtitle:@""];
    self.selectedCityName = @"北京";
    self.selectedDistrict = nil;
    UIBarButtonItem *districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtView];
    self.districtItem = districtItem;
    [districtView addTarget:self andAction:@selector(districtItemClick)];
    
    CDWNavTopView *sortView = [CDWNavTopView navTopView];
    [sortView setTitle:@"排序"];
    [sortView setSubtitle:@"默认排序"];
    [sortView setButtonWithIcon:@"icon_sort" andHLIcon:@"icon_sort_highlighted"];
    self.selectedSortValue = @(1);
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
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = self.selectedCityName;
    params[@"sort"] = self.selectedSortValue;
    params[@"category"] = self.selectedCategory;
    params[@"region"] = self.selectedDistrict;
    params[@"limit"] = @(10);
    [dpAPI requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
 
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    [self.dealArray removeAllObjects];
    
//    NSLog(@"result:%@",result[@"deals"]);
    [self.dealArray addObjectsFromArray:[CDWDealModel mj_objectArrayWithKeyValuesArray:result[@"deals"]]];
    [self.collectionView reloadData];
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"error:%@",error);
}
// MARK: --collectionView的数据源, 代理方法实现

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dealArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CDWDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.dealModel = self.dealArray[indexPath.item];
    
    return cell;
}
@end
