//
//  ZWCoverFlowLayout.m
//  ZWCoverFlow
//
//  Created by 郑亚伟 on 2017/3/13.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWCoverFlowLayout.h"

@implementation ZWCoverFlowLayout

//系统方法   设置布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //1、获取cell对应的attributes对象   每个cell唯一对应一个attribute对象
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:rect];
    //计算整体的中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    //2、修改attributes对象
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        //计算每个cell和中心点的具体
        CGFloat distance = ABS(attr.center.x - centerX);
        //距离越大，缩放比越小，距离越小，缩放比越大
        //缩放因子
        CGFloat factor = 0.003;
        CGFloat scale = 1 / (1 + distance * factor);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arrayAttrs;
}

//当bounds发生变化的时候是否需要重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    //是否可以随着collectionView的滚动而变化
    return YES;
}

//这个方法主要是为了停止滚动的时候，让一个cell显示到正中间
//返回值:当停止滚动的时候，人为停止的位置
//参一：当停止滚动的时候，自然情况下根据“惯性”停留的位置
//参二：每秒滚动多少个点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    //计算整体的中心点的值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    //这里不能使用contentOffset.x 因为手指一抬起来，contentOffset.x就不会再变化，按照惯性滚动的不会被计算到其中
    //CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    //计算可视区域
    CGFloat visibleX = proposedContentOffset.x;
    CGFloat visibleY = proposedContentOffset.y;
    CGFloat visibleW = self.collectionView.bounds.size.width;
    CGFloat visibleH = self.collectionView.bounds.size.height;
    //获取可视区域cell对应的attributes对象   每个cell唯一对应一个attribute对象
    NSArray *arrayAttrs = [super layoutAttributesForElementsInRect:CGRectMake(visibleX, visibleY, visibleW, visibleH)];
    
    //比较出最小的偏移
    int minIdx = 0;//假设最小的下标是0
    UICollectionViewLayoutAttributes *minAttr = arrayAttrs[minIdx];
    //循环比较出最小的
    for(int i = 1; i < arrayAttrs.count; i++){
        //计算两个距离
        //1、minAttr和中心点的距离
        CGFloat distance1 = ABS(minAttr.center.x - centerX);
        //2、计算出当前循环的attr对象和centerX的距离
        UICollectionViewLayoutAttributes *obj = arrayAttrs[i];
        CGFloat distance2 = obj.center.x - centerX;
        //3、比较
        if (distance2 < distance1) {
            minIdx = i;
            minAttr = obj;
        }
    }
    
    //计算出最小的偏移值
    CGFloat offsetX = minAttr.center.x - centerX;
    return CGPointMake(offsetX + proposedContentOffset.x, proposedContentOffset.y);
}

@end
