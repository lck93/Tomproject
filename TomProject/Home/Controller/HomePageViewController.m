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


@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *adBannerArray;

@property(nonatomic,strong)NSArray *brandListArray;

@property(nonatomic,strong)HomeHeadView *headView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)CNavigationBar *cNavigationBar;


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
}

- (void)configNav
{
    [self.view addSubview:self.cNavigationBar];
    [self.cNavigationBar setBarAlpha:0.0];
}

- (void)requestData
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.label.text = @"加载数据中";
    hud.dimBackground = YES;
     hud.removeFromSuperViewOnHide = YES;
    [[HttpTool shareInstance] postWithURLString:Brand_List parameters:nil success:^(id response) {
        if ([response[@"status"] isEqualToString:@"1"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                hud.label.text = @"数据加载成功";
                
                [hud hideAnimated:YES afterDelay:2.0];
            });
            self.adBannerArray = [ADBannerModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"adbanner"]];
            
            self.brandListArray = [BrandListModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"brandList"]];
            
            [self.headView setModelWithBannerArray:self.adBannerArray];
            [self.tableView reloadData];
            
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                hud.label.text = @"数据加载失败";
                [hud hideAnimated:YES];
            });
           
        }
    } fail:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.label.text = @"网络错误";
            [hud hideAnimated:YES];
        });
       
    }];
}

- (HomeHeadView *)headView
{
    if (!_headView) {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptHeight(200)+140)];
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



@end
