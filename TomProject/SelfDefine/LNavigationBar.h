//
//  LNavigationBar.h
//  ShangXiaApp
//
//  Created by JDBeer on 2017/10/7.
//  Copyright © 2017年 ShangXiaWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNavigationBar : UIView

@property (nonatomic,copy)void (^leftBlock)();

@property (nonatomic,copy)void (^rightBlock)();

- (void)setTitleWithString:(NSString *)name Font:(UIFont *)font titleColor:(UIColor *)color;
- (void)setViewAlpha:(float)alpha;

- (void)setTitleLabelAlpha:(float)alpha;

- (void)setViewBgColor:(UIColor *)color;

- (void)hideLeftBtn;

- (void)setBtnForRight:(UIButton *)btn;

//1为红色，其他都是白色
- (void)setBtnWithTag:(int )flag;

@end
