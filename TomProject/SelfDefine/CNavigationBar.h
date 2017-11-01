//
//  CNavigationBar.h
//  ShangXiaApp
//
//  Created by JDBeer on 2017/10/8.
//  Copyright © 2017年 ShangXiaWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNavigationBar : UIView


@property (nonatomic,copy)void (^leftBlock)();

@property (nonatomic,copy)void (^centerBlock)();

@property (nonatomic,copy)void (^rightBlock)();

- (void)setBtnForLeft:(UIButton *)btn;

- (void)setBtnForRight:(UIButton *)btn;

- (void)setCustomView:(UIView *)view withFrame:(CGRect)rect;

- (void)setBarBGColor:(UIColor *)color;

- (void)setBarAlpha:(CGFloat)alpha;

- (void)setLeftWithTitle:(NSString *)name;

@end
