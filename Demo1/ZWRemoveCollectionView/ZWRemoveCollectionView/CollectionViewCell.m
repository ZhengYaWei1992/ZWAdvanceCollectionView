//
//  CollectionViewCell.m
//  ZWRemoveCollectionView
//
//  Created by 郑亚伟 on 2017/3/8.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        //btn
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _deleteButton.frame = CGRectMake(totalWidth-30, 0, 30, 30);
        _deleteButton.layer.cornerRadius = 15;
        _deleteButton.clipsToBounds = YES;
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"-" forState:UIControlStateNormal];
        [self addSubview:_deleteButton];
        
        //lable
        _lable = [[UILabel alloc] init];
        _lable.font = [UIFont systemFontOfSize:14];
        _lable.frame = CGRectMake(0, 0, totalWidth, totalHeight);
        _lable.layer.borderColor = [[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] CGColor];
        _lable.layer.borderWidth = 0.5f;
        _lable.tintColor = [UIColor redColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lable];
    }
    return self;
}

@end
