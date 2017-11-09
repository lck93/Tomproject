//
//  MineHeadView.m
//  TomProject
//
//  Created by JDBeer on 2017/11/9.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "MineHeadView.h"
@interface MineHeadView()
@property(nonatomic,strong)UIImageView *iconImageV;

@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UILabel *userNameLab;
@end
@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KColorCommonColor;
        [self addSubview:self.iconImageV];
        [self addSubview:self.loginBtn];
        [self addSubview:self.userNameLab];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImageV.x = 10;
    self.iconImageV.bottom = self.height-10;
    
    self.loginBtn.centerX = self.centerX;
    self.loginBtn.centerY = self.iconImageV.centerY;
    
    self.userNameLab.x = self.iconImageV.right;
    self.userNameLab.centerY = self.iconImageV.centerY;
    
    
    
}

- (UIImageView *)iconImageV
{
    if (!_iconImageV) {
        _iconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _iconImageV.image = ImageNamed(@"icon_touxiang_huidi");
    }
    return _iconImageV;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 15.0;
        _loginBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
        _loginBtn.layer.borderWidth = 1.0;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(clickToLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)clickToLogin
{
    if (self.loginBlock) {
        self.loginBlock();
    }
}

- (UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        _userNameLab.text = @"11111";
    }
    return _userNameLab;
}

- (void)hideUserNameLab
{
    self.userNameLab.hidden = YES;
}

- (void)hideLoginBtn
{
    self.loginBtn.hidden = YES;
}

- (void)setNameForNameLan:(NSString *)name
{
    self.userNameLab.hidden = NO;
    self.userNameLab.text = name;
}

- (void)setIconImageViewWithName:(NSString *)name
{
    NSURL *url = [NSURL URLWithString:name];
    [self.iconImageV sd_setImageWithURL:url];
}

@end
