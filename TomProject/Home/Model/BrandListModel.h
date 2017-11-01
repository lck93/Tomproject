//
//  BrandListModel.h
//  TomProject
//
//  Created by JDBeer on 2017/10/25.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandListModel : NSObject
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *appBrandDesc;
@property(nonatomic,copy)NSString *brandImg;
@property(nonatomic,copy)NSString *brandName;
@property(nonatomic,copy)NSString *brandLogo;
@property(nonatomic,copy)NSString *brandDesc;
@property(nonatomic,copy)NSString *siteUrl;

- (float)getHeight;
@end
