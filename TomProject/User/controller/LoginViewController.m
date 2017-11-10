//
//  LoginViewController.m
//  TomProject
//
//  Created by JDBeer on 2017/11/10.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property(nonatomic,strong)LNavigationBar *lNavigationBar;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordBtn;
@end

@implementation LoginViewController
- (IBAction)loginClick:(id)sender {
    NSDictionary *dict = @{
                           @"phoneNum":self.phoneTextField.text
                           };
    [MBProgressHUD showMessageWithHUD:@"努力加载中。。。" toView:nil];
    [[HttpTool shareInstance] postWithURLString:@"user/activationUser" parameters:dict success:^(id response) {
        if ([response[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessage:@""];
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessage:@""];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@""];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self configNav];
    // Do any additional setup after loading the view from its nib.
}

- (void)initView
{
    UIImageView *phoneLeftImageView = [[UIImageView alloc] init];
    phoneLeftImageView.contentMode = UIViewContentModeCenter;
    phoneLeftImageView.image = ImageNamed(@"手机号");
    phoneLeftImageView.width = phoneLeftImageView.image.size.width;
    phoneLeftImageView.height = phoneLeftImageView.image.size.height;
    self.phoneTextField.leftView = phoneLeftImageView;
    self.phoneTextField.leftView.width = phoneLeftImageView.width+38;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.phoneTextField.tintColor = kColorGrayColor;
    self.phoneTextField.layer.borderWidth = 1.0;
    self.phoneTextField.layer.borderColor = [kColorBlackColor CGColor];
    self.phoneTextField.layer.cornerRadius = 5.0;
    self.phoneTextField.layer.masksToBounds = YES;
    
    UIImageView *passwordLeftImageView = [[UIImageView alloc] init];
    passwordLeftImageView.image = ImageNamed(@"验证码");
    passwordLeftImageView.contentMode = UIViewContentModeCenter;
    passwordLeftImageView.width = passwordLeftImageView.image.size.width;
    passwordLeftImageView.height = passwordLeftImageView.image.size.height;
    self.passwordTextField.leftView = passwordLeftImageView;
    self.passwordTextField.leftView.width = passwordLeftImageView.width+38;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView.x +=10;
    self.passwordTextField.tintColor = kColorGrayColor;
    self.passwordTextField.layer.borderWidth = 1.0;
    self.passwordTextField.layer.borderColor = [kColorBlackColor CGColor];
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.layer.masksToBounds = YES;
    
    [self.loginBtn setBackgroundColor:KColorCommonColor];
    [self.loginBtn setTitleColor:kColorWhiteColor forState:UIControlStateNormal];
    self.loginBtn.layer.cornerRadius = 5.0;
    self.loginBtn.layer.masksToBounds = YES;
    
    [self.registerBtn setTitleColor:kColorGrayColor forState:UIControlStateNormal];
    [self.forgetPasswordBtn setTitleColor:kColorGrayColor forState:UIControlStateNormal];
    
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
        [_lNavigationBar setTitleWithString:@"登录" Font:[UIFont systemFontOfSize:16.0] titleColor:[UIColor whiteColor]];
        [_lNavigationBar setViewBgColor:KColorCommonColor];
    }
    return _lNavigationBar;
}

@end
