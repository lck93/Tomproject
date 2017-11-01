//
//  HomePageTableViewCell.m
//  TomProject
//
//  Created by JDBeer on 2017/10/25.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "HomePageTableViewCell.h"
@interface HomePageTableViewCell()


@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end
@implementation HomePageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(BrandListModel *)model
{
    NSString *str = [NSString stringWithFormat:@"%@%@",QINIU_Picture_Url,model.brandLogo];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:str]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
