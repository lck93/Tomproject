//
//  LNavigationBar.m
//  ShangXiaApp
//
//  Created by JDBeer on 2017/10/7.
//  Copyright © 2017年 ShangXiaWang. All rights reserved.
//

#import "LNavigationBar.h"
@interface LNavigationBar ()

@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UILabel *titleLab;

@property (strong, nonatomic) UIButton *rightBtn;

@end
@implementation LNavigationBar



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftBtn];
        [self addSubview:self.titleLab];
        [self addSubview:_rightBtn];
        self.backgroundColor = KColorCommonColor;
    }
    return self;
}

- (void)setTitleLabelAlpha:(float)alpha
{
    self.titleLab.alpha = alpha;
}
- (void)setTitleWithString:(NSString *)name Font:(UIFont *)font titleColor:(UIColor *)color
{
    self.titleLab.text = name;
    self.titleLab.font = font;
    self.titleLab.textColor = color;
}

- (void)setViewAlpha:(float)alpha
{
    self.alpha = alpha;
}

- (void)setViewBgColor:(UIColor *)color
{
    self.backgroundColor = color;
}

- (void)hideLeftBtn
{
    self.leftBtn.hidden = YES;
}
- (void)setBtnForRight:(UIButton *)btn;
{
    if (self.rightBtn) {
        [self.rightBtn removeFromSuperview];
    }else{
        
    }
    self.rightBtn =btn;
    [self addSubview:btn];
    self.rightBtn.frame = CGRectMake(SCREEN_WIDTH-54, 20, 44, 44);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.centerX = self.centerX;
    self.leftBtn.x = 10;
    self.leftBtn.centerY = 42;
    self.rightBtn.right = SCREEN_WIDTH-10;
    self.rightBtn.centerY = 42;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 44, 44)];
        [_leftBtn addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_leftBtn setImage:ImageNamed(@"nav_back") forState:UIControlStateNormal];
        
    }
    return _leftBtn;
}

- (void)setBtnWithTag:(int)flag
{
    if (flag == 1) {
        [_leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:RGBA(227, 84, 23, 1) forState:UIControlStateNormal];
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_leftBtn setImage:ImageNamed(@"icon_back") forState:UIControlStateNormal];
        
    }else{
        [_leftBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
        [_leftBtn setImage:ImageNamed(@"nav_back") forState:UIControlStateNormal];
        _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-54, 20, 44, 44)];
        [_rightBtn addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (void)clickLeft:(UIButton *)sender
{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)clickRight:(UIButton *)sender
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.leftBtn.right, 20, SCREEN_WIDTH-128, 40)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = kColorWhiteColor;
    }
    return _titleLab;
}


@end
