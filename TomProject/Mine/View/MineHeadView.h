//
//  MineHeadView.h
//  TomProject
//
//  Created by JDBeer on 2017/11/9.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeadView : UIView
@property(copy,nonatomic)void (^loginBlock)(void);

- (void)hideUserNameLab;

- (void)hideLoginBtn;

- (void)setNameForNameLan:(NSString *)name;

- (void)setIconImageViewWithName:(NSString *)name;




@end
