//
//  GoodsViewController.m
//  TomProject
//
//  Created by JDBeer on 2017/11/2.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "GoodsViewController.h"
#import "LNavigationBar.h"

@interface GoodsViewController ()

@property(nonatomic,strong)LNavigationBar *lNavigationBar;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;
    [self configNav];
    // Do any additional setup after loading the view.
}

- (void)configNav
{
    [self.view addSubview:self.lNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LNavigationBar *)lNavigationBar
{
    if (!_lNavigationBar) {
        _lNavigationBar = [[LNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        [_lNavigationBar setTitleWithString:@"goods" Font:[UIFont systemFontOfSize:16.0] titleColor:[UIColor blackColor]];
        KWeakSelf;
        _lNavigationBar.leftBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _lNavigationBar;
}



@end
