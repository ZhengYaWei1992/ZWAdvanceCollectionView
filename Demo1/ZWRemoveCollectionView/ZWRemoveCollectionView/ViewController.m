//
//  ViewController.m
//  ZWRemoveCollectionView
//
//  Created by 郑亚伟 on 2017/3/8.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "CollectionViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
static NSString *cellId = @"cellId";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property(nonatomic,strong)UITapGestureRecognizer *tap;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"手机充值", @"亲民金融", @"就业招聘", @"乡间旅游",@"乡村医疗", @"违章查询", @"生活服务", @"乡村名宿",@"新农头条"];
//    NSArray *arr = @[@"1", @"2", @"3", @"4",@"5", @"6", @"7", @"8",@"9"];
    self.array = [NSMutableArray arrayWithArray:arr];
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.collectionView addGestureRecognizer:_longPress];
//    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    [self.collectionView addGestureRecognizer:self.tap];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Action
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:{//开始
            {
                //获取长按的cell
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
                CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
                //显示cell上的删除按钮
                [cell.deleteButton setHidden:NO];
                cell.deleteButton.tag = selectIndexPath.item;
                //给当前cell上的删除按钮添加点击事件
                [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                //设置collectionView开始移动
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{//拖动中
             [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded:{//结束
            
             [self.collectionView endInteractiveMovement];
            break;
        }
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}
- (void)deleteButtonClick:(UIButton *)deleteBtn{
    //cell的隐藏删除设置
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
    // 找到当前的cell
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
    cell.deleteButton.hidden = NO;
    //取出源item数据
    id objc = [self.array objectAtIndex:deleteBtn.tag];
    //从资源数组中移除该数据
    [self.array removeObject:objc];
    [self.collectionView reloadData];
}
//- (void)tapAction:(UITapGestureRecognizer *)tap{
//    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
//    // 找到当前的cell
//    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
//    if (cell.deleteButton.isHidden == NO) {
//        NSLog(@"aaaaaaaa");
//        [cell.deleteButton setHidden:YES];
//        [self.collectionView reloadData];
//    }else{
//        NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_tap locationInView:self.collectionView]];
//        // 找到当前的cell
//        CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
//    }
//
//}


#pragma mark- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.lable.text = self.array[indexPath.item];
    cell.deleteButton.hidden = YES;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
//    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
//    // 找到当前的cell
//    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
//    if (cell.deleteButton.isHidden == NO) {
//        NSLog(@"aaaaaaaa");
//        [cell.deleteButton setHidden:YES];
//        [self.collectionView reloadData];
////        ViewController2 *vc = [[ViewController2 alloc]init];
////        [self.navigationController pushViewController:vc animated:YES];
//        
//    }else{
//        NSLog(@"bbbbbbbbb");
//        [cell.deleteButton setHidden:YES];
//        [self.collectionView reloadData];
////        ViewController2 *vc = [[ViewController2 alloc]init];
////        [self.navigationController pushViewController:vc animated:YES];
//    }
    ViewController2 *vc = [[ViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
   
}
//交换collectionView必须要实现的代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath{
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
    // 找到当前的cell
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
    cell.deleteButton.hidden = YES;
    
    /*1.存在的问题,移动是二个一个移动的效果*/
    //	[collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    /*2.存在的问题：只是交换而不是移动的效果*/
    //    [self.array exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    /*3.完整的解决效果*/
    //取出源item数据
    id objc = [self.array objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.array removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.array insertObject:objc atIndex:destinationIndexPath.item];

    [self.collectionView reloadData];
}


#pragma mark - 懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);//分区内边距
        CGFloat totalWidth = kWidth-50;
        CGFloat itemWidth = (totalWidth)/4.0;
        CGFloat itemHeght = (totalWidth)/4.0;
        //注意：item的宽高必须要提前算好
        _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeght);
        //创建collectionView对象，并赋值布局
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kWidth, kHeight - 20) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        _collectionView.delegate = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellId];
    }
    return _collectionView;
}


@end
