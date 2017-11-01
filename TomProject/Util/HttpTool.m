//
//  HttpTool.m
//  TomProject
//
//  Created by JDBeer on 2017/10/23.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "HttpTool.h"
#import <AFNetworking.h>
static HttpTool *_httpTool ;

@interface HttpTool()
@property (nonatomic,strong)AFHTTPSessionManager *manager;

@property(nonatomic,copy)NSString *lastURLString;

@property(nonatomic,strong)NSMutableDictionary *lastParameter;
@end

@implementation HttpTool

+ (instancetype)shareInstance
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpTool = [super allocWithZone:zone];
    });
    return _httpTool;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _httpTool;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _httpTool;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = 15;
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return _manager;
}

-(void)getWithURLString:(NSString *)string parameters:(id)parameters success:(void (^)(id response))successBlock fail:(void (^)(NSError *error))failBlock
{
    self.lastURLString = string;
    self.lastParameter = parameters;
    [self.manager GET:string parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
    
}

- (void)postWithURLString:(NSString *)string parameters:(id)parameters success:(void (^)(id response))successBlock fail:(void (^)(NSError *error))failBlock
{
    self.lastURLString = string;
    self.lastParameter = parameters;
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,string];
    [self.manager.requestSerializer setValue:[StoreManager getToken] forHTTPHeaderField:@"token"];
    [self.manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"403"]) {
            [self refreshTokenSuccess:successBlock fail:failBlock];
        }else{
            successBlock(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

- (void)refreshTokenSuccess:(void (^)(id))successBlock fail:(void (^)(id))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Base_Url,@"oauth/token"];
    [self.manager POST:url  parameters:self.lastParameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"403"]) {
            
        }else{
            [StoreManager saveToken:responseObject[@"data"][@"token"]];
            [self postWithURLString:self.lastURLString parameters:self.lastParameter success:^(id response) {
                successBlock(response);
            } fail:^(NSError *error) {
                failBlock(error);
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self refreshTokenSuccess:successBlock fail:failBlock];
    }];
    
}

@end
