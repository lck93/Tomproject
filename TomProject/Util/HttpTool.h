//
//  HttpTool.h
//  TomProject
//
//  Created by JDBeer on 2017/10/23.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HttpTool : NSObject

+ (instancetype)shareInstance;

- (void)getWithURLString:(NSString *)string parameters:(id)parameters success:(void (^)(id response))successBlock fail:(void (^)(NSError *error))failBlock;

- (void)postWithURLString:(NSString *)string parameters:(id)parameters success:(void (^)(id response))successBlock fail:(void (^)(NSError *error))failBlock;

- (void)getSaltWithPhoneNum:(NSString *)phoneNum success:(void (^)(id response))successBlock fail:(void (^)(NSError *error))failBlock;


@end
