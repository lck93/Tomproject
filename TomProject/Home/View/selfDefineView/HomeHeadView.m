//
//  HomeHeadView.m
//  TomProject
//
//  Created by JDBeer on 2017/10/24.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "HomeHeadView.h"
#import <SDCycleScrollView.h>
#import "HomePageGoodKindCollectionViewCell.h"
#import "ADBannerModel.h"
@interface HomeHeadView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)SDCycleScrollView *sdCycleScrollView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *goodKindArray;

@property(nonatomic,strong)NSArray *adBannerArray;

@property(nonatomic,strong)NSMutableArray *adBannerImageArray;

@end
@implementation HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.sdCycleScrollView];
        [self addSubview:self.collectionView];
        self.adBannerImageArray = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shangxiawangInfo" ofType:@"plist"]];
        self.goodKindArray = [GoodKindModel mj_objectArrayWithKeyValuesArray:dic[@"HomeHead"]] ;
        
    }
    return self;
}

- (SDCycleScrollView *)sdCycleScrollView
{
    if (!_sdCycleScrollView) {
        _sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptHeight(200)) delegate:self placeholderImage:ImageNamed(@"placeholderImage.png")];
        _sdCycleScrollView.contentMode = UIViewContentModeScaleAspectFit;
        _sdCycleScrollView.autoScrollTimeInterval = 2.0;
    }
    return _sdCycleScrollView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.width/5, 70);
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.sdCycleScrollView.bottom, SCREEN_WIDTH, 140) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomePageGoodKindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageGoodKindCollectionViewCell"];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (void)setModelWithBannerArray:(NSArray *)bannerArray;
{
    NSString *str = nil;
    for (ADBannerModel *model in bannerArray) {
        str = [NSString stringWithFormat:@"%@%@",QINIU_Picture_Url,model.imgUrl];
        [self.adBannerImageArray addObject:str];
    }
    self.sdCycleScrollView.imageURLStringsGroup = self.adBannerImageArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodKindArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageGoodKindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageGoodKindCollectionViewCell" forIndexPath:indexPath];
    [cell setModel:self.goodKindArray[indexPath.row]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}




@end
