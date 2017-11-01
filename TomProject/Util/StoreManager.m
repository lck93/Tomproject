//
//  StoreManager.m
//  TomProject
//
//  Created by JDBeer on 2017/10/23.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "StoreManager.h"

@implementation StoreManager

+ (void)saveToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
}


@end
