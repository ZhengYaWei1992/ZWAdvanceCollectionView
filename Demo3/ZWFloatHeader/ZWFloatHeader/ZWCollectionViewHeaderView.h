//
//  ZWCollectionViewHeaderView.h
//  ZWTwoTableLinkage
//
//  Created by 郑亚伟 on 2017/3/10.
//  Copyright © 2017年 zhengyawei. All rights reserved.

//UICollectionView的复用组头

#import <UIKit/UIKit.h>

typedef void(^HeadViewTapBlock)(UILabel *);

@interface ZWCollectionViewHeaderView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic,copy)HeadViewTapBlock headViewTapBlock;
@end
