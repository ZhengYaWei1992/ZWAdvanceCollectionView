//
//  ZWCollectionViewHeaderView.m
//  ZWTwoTableLinkage
//
//  Created by 郑亚伟 on 2017/3/10.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWCollectionViewHeaderView.h"
#define ZWRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@implementation ZWCollectionViewHeaderView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = ZWRGBAColor(240, 240, 240, 1.0);
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 80, 50)];
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self.titleLabel addGestureRecognizer:tap];
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void)tapClick:(UITapGestureRecognizer *)tap{
    if (self.headViewTapBlock) {
        self.headViewTapBlock((UILabel *)tap.view);
    }
}
@end
