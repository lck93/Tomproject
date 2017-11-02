//
//  HomeHeadView.h
//  TomProject
//
//  Created by JDBeer on 2017/10/24.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodKindModel.h"

@interface HomeHeadView : UIView

- (void)setModelWithBannerArray:(NSArray *)bannerArray;

@property(nonatomic,copy)void (^goodsViewBlock)(GoodKindModel *model);

@end
