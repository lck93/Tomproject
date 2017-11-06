//
//  HomePageViewController.m
//  TomProject
//
//  Created by JDBeer on 2017/10/19.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "HomePageViewController.h"
#import "GoodKindModel.h"
#import "ADBannerModel.h"
#import "BrandListModel.h"
#import "HomeHeadView.h"
#import "HomePageTableViewCell.h"
#import "CNavigationBar.h"
#import "SearchBar.h"
#import "GoodsViewController.h"


@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *adBannerArray;

@property(nonatomic,strong)NSArray *brandListArray;

@property(nonatomic,strong)HomeHeadView *headView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)CNavigationBar *cNavigationBar;

@property(nonatomic,strong)SearchBar *searchBar;

@end

@implementation HomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self configNav];
    
    [self requestData];
    
   
    // Do any additional setup after loading the view.
}

- (void)initView
{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    self.view.backgroundColor = [UIColor yellowColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        KWeakSelf;
        [weakSelf.tableView.mj_header beginRefreshing];
        [weakSelf requestData];
        
    }];
}

- (void)configNav
{
    [self.view addSubview:self.cNavigationBar];
    self.cNavigationBar.backgroundColor = [UIColor clearColor];
    [self.cNavigationBar setCustomView:self.searchBar withFrame:CGRectMake(54, 20, SCREEN_WIDTH-108, 30)];
}

- (void)requestData
{
    
    [MBProgressHUD showMessageWithHUD:@"正在加载数据中" toView:self.view];
    [[HttpTool shareInstance] postWithURLString:Brand_List parameters:nil success:^(id response) {
        if ([response[@"status"] isEqualToString:@"1"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"加载成功"];
               
            });
             [self.tableView.mj_header endRefreshing];
            self.adBannerArray = [ADBannerModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"adbanner"]];
            
            self.brandListArray = [BrandListModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"brandList"]];
            
            [self.headView setModelWithBannerArray:self.adBannerArray];
            [self.tableView reloadData];
            
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.tableView.mj_header endRefreshing];
            });
           
        }
    } fail:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
       
    }];
}

- (HomeHeadView *)headView
{
    if (!_headView) {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptHeight(200)+140)];
        KWeakSelf;
        _headView.goodsViewBlock = ^(GoodKindModel *model) {
            GoodsViewController *control = [[GoodsViewController alloc] init];
            control.model = model;
            [weakSelf.navigationController pushViewController:control animated:YES];
        };
    }
    return _headView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerNib:[UINib nibWithNibName:@"HomePageTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomePageTableViewCell"];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandListModel *model = self.brandListArray[indexPath.row];
    
    return [model getHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.brandListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageTableViewCell"];
    [cell setModel:self.brandListArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CNavigationBar *)cNavigationBar
{
    if (!_cNavigationBar) {
        _cNavigationBar = [[CNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        [_cNavigationBar setBarBGColor:kColorWhiteColor];
        
    }
    return _cNavigationBar;
}

- (SearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-108, 30)];
    }
    return _searchBar;
}



@end
