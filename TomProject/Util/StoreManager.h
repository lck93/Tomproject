//
//  StoreManager.h
//  TomProject
//
//  Created by JDBeer on 2017/10/23.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreManager : NSObject

#pragma mark set

+ (void)saveToken:(NSString *)token;




#pragma mark get
+(NSString *)getToken;

+(NSString *)getUserId;


@end
