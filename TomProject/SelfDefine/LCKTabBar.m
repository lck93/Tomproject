//
//  LCKTabBar.m
//  TomProject
//
//  Created by JDBeer on 2017/10/20.
//  Copyright © 2017年 zhongHui. All rights reserved.
//

#import "LCKTabBar.h"
@interface LCKTabBar()

@property (nonatomic,strong)UIButton *plusBtn;

@property (nonatomic,strong)UILabel *label;

@end
@implementation LCKTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:ImageNamed(@"111")];
        [self addSubview:self.plusBtn];
        [self addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.plusBtn.centerX = self.centerX;
    self.plusBtn.centerY = self.height*0.5-20;
    self.label.centerX = self.plusBtn.centerX;
    self.label.centerY = self.plusBtn.bottom+10;
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
            view.width = self.width/5;
            view.x = btnIndex*self.width/5;
            btnIndex++;
            if (btnIndex ==2) {
                btnIndex++;
            }
        }
    }
}

- (void)clickPlus
{
    if (self.plusBlock) {
        self.plusBlock();
    }
}

-(UIButton *)plusBtn
{
    if (!_plusBtn) {
        UIImage *image = ImageNamed(@"post_normal");
        _plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [_plusBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_plusBtn addTarget:self action:@selector(clickPlus) forControlEvents:UIControlEventTouchUpInside];
//        [_plusBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    return _plusBtn;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"发布";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor grayColor];
        [_label sizeToFit];
        _label.font = [UIFont systemFontOfSize:11];
    }
    return _label;
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}




@end
