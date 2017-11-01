//
//  CNavigationBar.m
//  ShangXiaApp
//
//  Created by JDBeer on 2017/10/8.
//  Copyright © 2017年 ShangXiaWang. All rights reserved.
//

#import "CNavigationBar.h"


@interface CNavigationBar ()
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIView *centerV;
@property (strong, nonatomic) UIView *contentV;


@end
@implementation CNavigationBar



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.centerV];
        [self addSubview:self.contentV];
        self.centerV.backgroundColor = [UIColor clearColor];
        self.centerV.hidden = YES;
        self.contentV.backgroundColor = [UIColor clearColor];
        UIGestureRecognizer *gester = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickCernter)];
        [self.contentV addGestureRecognizer:gester];
    }
    return self;
}

- (void)setBtnForLeft:(UIButton *)btn
{
    if (_leftBtn) {
        [_leftBtn removeFromSuperview];
        _leftBtn = nil;
    }else{
        
    }
    self.leftBtn = btn;
    self.leftBtn.frame = CGRectMake(20, 20, 44, 44);
    [self addSubview:btn];
}

- (void)setBtnForRight:(UIButton *)btn
{
    if (_rightBtn) {
        [_rightBtn removeFromSuperview];
        _rightBtn = nil;
    }else{
        
    }
    self.rightBtn = btn;
    self.rightBtn.frame = CGRectMake(SCREEN_WIDTH-64, 20, 44, 44);
    [self addSubview:btn];
}

- (void)setCustomView:(UIView *)view withFrame:(CGRect)rect
{
    self.contentV = view;
    self.contentV.width = rect.size.width;
    [self addSubview:view];
}

- (void)setBarBGColor:(UIColor *)color
{
    self.backgroundColor = color;
}

- (void)setBarAlpha:(CGFloat)alpha
{
    self.alpha = alpha;
}

- (void)setLeftWithTitle:(NSString *)name
{
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(-1, -24, 0, 0);
    [self.leftBtn setTitle:name forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    self.leftBtn.frame = CGRectMake(10, 20, 44, 44);
    self.contentV.centerY = 42;
    self.contentV.centerX = self.centerX;
    self.leftBtn.centerY = 42;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
        [_leftBtn addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
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

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44-10, 20, 44, 44)];
        [_rightBtn addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
@end
