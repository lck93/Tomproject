//
//  GoodsViewController.m
//  TomProject
//
//  Created by JDBeer on 2017/11/2.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "GoodsViewController.h"
#import "LNavigationBar.h"
#import "JSDropDownMenu.h"

@interface GoodsViewController ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>
{
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    
    NSInteger _currentData1SelectedIndex;
    JSDropDownMenu *menu;
}

@property(nonatomic,strong)LNavigationBar *lNavigationBar;

@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorWhiteColor;
    [self configNav];
    
    [self configDrop];
    // Do any additional setup after loading the view.
}

- (void)configDrop
{
    _currentData1Index = 1;
    _currentData1SelectedIndex = 1;
    
   
    _data1 = [NSMutableArray arrayWithObjects:@"全部", @"居家生活", @"美食特产", @"玩具", @"家纺", @"数码产品", @"酒水饮料", @"家用电器", @"跨境商品", nil];
    _data2 = [NSMutableArray arrayWithObjects:@"全部", @"人民币", @"积分", @"U币", @"人民币+积分", @"人民币+U币", @"积分+U币",@"人民币+积分+U币", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"按销量降序", @"按销量升序", nil];
    
    menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
}

- (void)configNav
{
    [self.view addSubview:self.lNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-drop
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{

    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
            
        return _data1.count;
        
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return self.model.catName;
            break;
        case 1: return @"价格";
            break;
        case 2: return @"销量";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        return _data1[indexPath.row];
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentData1Index = indexPath.row;
            
            return;
        }
        
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
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
