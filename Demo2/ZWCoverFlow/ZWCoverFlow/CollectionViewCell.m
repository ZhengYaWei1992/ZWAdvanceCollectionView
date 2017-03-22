//
//  CollectionViewCell.m
//  ZWCoverFlow
//
//  Created by 郑亚伟 on 2017/3/13.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"人物写真10.jpg"]];
        imageView.frame = self.bounds;
        [self.contentView addSubview:imageView];
    }
    return self;
}

@end
