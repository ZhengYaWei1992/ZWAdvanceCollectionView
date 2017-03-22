//
//  ZWCollectionViewController.m
//  ZWTwoTableLinkage
//
//  Created by 郑亚伟 on 2017/3/10.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//
//屏幕尺寸
#define kDeviceWidth [[UIScreen mainScreen]bounds].size.width
#define kDeviceHight [[UIScreen mainScreen]bounds].size.height
#define kWindow  [[UIApplication sharedApplication].delegate window]
//颜色
#define ZWGlobaBg ZWRGBAColor(253, 212, 49, 1.0);
#define ZWRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define ZWRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ZWRandomColor          JGRGBColor(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255))

#import "ZWCollectionViewController.h"
#import "ZWLeftTableViewCell.h"
#import "ZWCollectionViewCell.h"
#import "ZWCollectionCategoryModel.h"
#import "ZWSubCategoryModel.h"
#import "JSONModel.h"
#import "ZWCollectionViewHeaderView.h"
#import "ZWHeaderFloatFlowLayout.h"

static NSString * const ZWCollectionTableCellId = @"ZWCollectionTableCellId";
static NSString * const ZWCollectionCellId = @"ZWCollectionCellId";
static NSString * const ZWCollectionViewHeaderId = @"ZWCollectionViewHeaderId";
@interface ZWCollectionViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,assign)BOOL isScrollDown;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
//tableView数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
//collectionView数据源
@property (nonatomic, strong) NSMutableArray *collectionDatas;

@end

@implementation ZWCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _selectIndex = 0;
    _isScrollDown = YES;
    [self loadData];
    [self createTable];
    
}
- (void)createTable{
    [self.view addSubview:self.tableView];
    //设置tableView默认选中第一行
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.view addSubview:self.collectionView];
}
- (void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    self.dataSource = [ZWCollectionCategoryModel arrayOfModelsFromDictionaries:categories error:nil];
    //NSLog(@"%@",self.dataSource);
    
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZWCollectionTableCellId forIndexPath:indexPath];
    //ZWCollectionCategoryModel *model = self.dataSource[indexPath.row];
    cell.nameLabel.text = [self.dataSource[indexPath.row] name];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark - collectionView的代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ZWCollectionCategoryModel *model = self.dataSource[section];
    return model.subcategories.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZWCollectionCellId forIndexPath:indexPath];
    //ZWCollectionCategoryModel *model1 = self.dataSource[indexPath.section];
    //ZWSubCategoryModel *model2 = model1.subcategories[indexPath.row];
    //cell.model2 = model2;
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kDeviceWidth - 80 - 4 - 4) / 3, (kDeviceWidth - 80 -4 - 4) / 3 + 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // header
        reuseIdentifier = ZWCollectionViewHeaderId;
    }
    ZWCollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZWCollectionCategoryModel *model1 = self.dataSource[indexPath.section];
        view.titleLabel.text = model1.name;
        view.headViewTapBlock = ^(UILabel *label){
            NSLog(@"%ld",indexPath.section);
        };
    }
    
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    //返回组头的高度
    return CGSizeMake(kDeviceWidth, 50);
}



// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging){
        [self selectRowAtIndexPath:indexPath.section];
    }
}
// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && collectionView.dragging){
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}


#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView){
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}



//自定义方法
// 选中TableView的特定cell
- (void)selectRowAtIndexPath:(NSInteger)index{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - 懒加载 -
- (NSMutableArray *)dataSource{
    if (!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas{
    if (!_collectionDatas){
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, 80, kDeviceHight-20)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[ZWLeftTableViewCell class] forCellReuseIdentifier:ZWCollectionTableCellId];
    }
    return _tableView;
}
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        //浮动组头线性布局
        ZWHeaderFloatFlowLayout *flowlayout = [[ZWHeaderFloatFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 2;
        //上下间距
        flowlayout.minimumLineSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 + 80, 2 + 20, kDeviceWidth - 80 - 4, kDeviceHight - 20 -4) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册cell
        [_collectionView registerClass:[ZWCollectionViewCell class] forCellWithReuseIdentifier:ZWCollectionCellId];
        //注册分区头标题
        [_collectionView registerClass:[ZWCollectionViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZWCollectionViewHeaderId];
        
    }
    return _collectionView;
}


@end
