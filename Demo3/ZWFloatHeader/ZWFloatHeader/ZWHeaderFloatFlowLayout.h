//
//  ZWHeaderFloatFlowLayout.h
//  ZWTwoTableLinkage
//
//  Created by 郑亚伟 on 2017/3/14.
//  Copyright © 2017年 zhengyawei. All rights reserved.

//让collectionView实现浮动组头

#import <UIKit/UIKit.h>

@interface ZWHeaderFloatFlowLayout : UICollectionViewFlowLayout
/**
 *  导航栏高度，默认为0
 */
@property (nonatomic, assign) CGFloat navHeight;

@end
