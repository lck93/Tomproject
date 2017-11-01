//
//  HomePageGoodKindCollectionViewCell.m
//  TomProject
//
//  Created by JDBeer on 2017/10/25.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "HomePageGoodKindCollectionViewCell.h"
@interface HomePageGoodKindCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
@implementation HomePageGoodKindCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GoodKindModel *)model;
{
    self.nameLab.text = model.catName;
    self.imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",model.imageName]];
}

@end
