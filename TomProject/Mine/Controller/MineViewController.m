//
//  MineViewController.m
//  TomProject
//
//  Created by JDBeer on 2017/10/19.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "MineViewController.h"
#import "LNavigationBar.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSDictionary *unloginDic;

@property(nonatomic,strong)NSDictionary *loginDic;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)LNavigationBar *lNavigationBar;

@end

@implementation MineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [self configNav];
    
    // Do any additional setup after loading the view.
}

- (void)configNav
{
    [self.view addSubview:self.lNavigationBar];
}

- (void)initTableView
{
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-49)style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if ([StoreManager getUserId]) {
        
        return ((NSArray *)self.loginDic[[NSString stringWithFormat:@"section%ld",(long)section]]).count;
    }else{
        return ((NSArray *)self.unloginDic[[NSString stringWithFormat:@"section%ld",(long)section]]).count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([StoreManager getUserId]) {
        return self.loginDic.allKeys.count;
    }else{
        return self.unloginDic.allKeys.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([StoreManager getUserId]) {
        
    }else{
        NSDictionary *dic = self.unloginDic[[NSString stringWithFormat:@"section%ld",(long)indexPath.section]][indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.imageView.image = ImageNamed(dic[@"icon"]);
        cell.textLabel.text = dic[@"nameLab"];
        cell.detailTextLabel.text = dic[@"detailNameLab"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSDictionary *)unloginDic
{
    if (!_unloginDic) {
        _unloginDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shangxiawangInfo" ofType:@"plist"]][@"MineVC"][@"unlogin"];
    }
    return _unloginDic;
}

- (NSDictionary *)loginDic
{
    if (!_loginDic) {
        _loginDic =[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shangxiawangInfo" ofType:@"plist"]][@"MineVC"][@"login"];
    }
    return _loginDic;
}

- (LNavigationBar *)lNavigationBar
{
    if (!_lNavigationBar) {
        _lNavigationBar = [[LNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        [_lNavigationBar setTitleWithString:@"我的" Font:[UIFont systemFontOfSize:16.0] titleColor:[UIColor blackColor]];
        [_lNavigationBar hideLeftBtn];
    }
    return _lNavigationBar;
}

@end
