//
//  MainTabBarController.m
//  TomProject
//
//  Created by JDBeer on 2017/10/19.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomePageViewController.h"
#import "ShopCartViewController.h"
#import "MineViewController.h"
#import "MerchantViewController.h"
#import "LCKTabBar.h"
#import "PlusViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChild];
    LCKTabBar *tabBar = [[LCKTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    __weak typeof(self) weakSelf = self;
    tabBar.plusBlock = ^{
        PlusViewController *control = [[PlusViewController alloc] init];
        [weakSelf presentViewController:control animated:YES completion:nil];
    };
    // Do any additional setup after loading the view.
}

+ (void)load
{
    
    [[UITabBarItem appearanceWhenContainedIn:[self class], nil]  setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [ [UITabBarItem appearanceWhenContainedIn:[self class], nil]  setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    
    
}

- (void)setUpChild
{
    
    HomePageViewController *home = [[HomePageViewController alloc] init];
    
    [self addChildVCWith:home normalImage:@"icon_gouwuche_unselected" selectedImage:@"icon_gouwuche_selected" titleName:@"首页"];
    
    MerchantViewController *merchant = [[MerchantViewController alloc] init];
     [self addChildVCWith:merchant normalImage:@"icon_shangjia_unselected" selectedImage:@"icon_shangjia_selected" titleName:@"商家"];
    ShopCartViewController *cart = [[ShopCartViewController alloc] init];
     [self addChildVCWith:cart normalImage:@"icon_gouwuche_unselected" selectedImage:@"icon_gouwuche_selected" titleName:@"购物车"];
   
    MineViewController *mine = [[MineViewController alloc] init];
    [self addChildVCWith:mine normalImage:@"icon_wode_unselected" selectedImage:@"icon_wode_selected" titleName:@"我的"];
    
    
   
    
}

- (void)addChildVCWith:(UIViewController *)vc normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage titleName:(NSString *)titleName
{
    LCKNavigationController *nav = [[LCKNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = titleName;
    nav.tabBarItem.image = [ImageNamed(normalImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [ImageNamed(selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
