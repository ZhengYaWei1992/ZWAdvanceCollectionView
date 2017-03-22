//
//  ViewController.m
//  ZWCoverFlow
//
//  Created by 郑亚伟 on 2017/3/13.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "ZWCoverFlowLayout.h"


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}
#pragma mark    UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 39;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark    UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 40)/1.8 ,(self.view.frame.size.width - 40)/3.0);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(3, 3, 3, 3);
//}


- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //自定义布局
        ZWCoverFlowLayout *layout = [[ZWCoverFlowLayout alloc] init];
        //水平方向，元素之间的最小距离
        layout.minimumInteritemSpacing = 0;
        //行之间的最小距离
        layout.minimumLineSpacing = 20;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置元素的大小
        //layout.itemSize = CGSizeMake(100, 120);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 150) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        //collectionView.pagingEnabled = YES;
        collectionView.bounces = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = YES;
        collectionView.backgroundColor = [UIColor blackColor];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
