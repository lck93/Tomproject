//
//  BrandListModel.m
//  TomProject
//
//  Created by JDBeer on 2017/10/25.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "BrandListModel.h"
#define CellHeight 150

@implementation BrandListModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

- (float)getHeight
{
    return CellHeight;
}
@end
