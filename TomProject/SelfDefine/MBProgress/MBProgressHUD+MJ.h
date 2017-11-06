//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;


//只显示文字
+ (MBProgressHUD *)showMessage:(NSString *)message;

//显示文字和进度层
+ (MBProgressHUD *)showMessageWithHUD:(NSString *)text toView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
