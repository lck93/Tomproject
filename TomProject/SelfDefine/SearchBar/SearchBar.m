//
//  SearchBar.m
//  TomProject
//
//  Created by JDBeer on 2017/11/1.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = ImageNamed(@"icon_search_shouye");
        leftView.width = leftView.image.size.width+10;
        leftView.height = leftView.image.size.height;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.placeholder = @"请输入商家";
    }
    return self;
}

@end
