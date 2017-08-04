//
//  TestVC.m
//  collectionView单双路珠
//
//  Created by IMAC on 2017/3/2.
//  Copyright © 2017年 小四. All rights reserved.
//
//获取屏幕宽度  高度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define kNavigationBarHeight 64 //导航栏高度
#define kTabBarHeight        49 //tabbar高度
#define itemWidth  30        //每个item的宽度

#import "TestVC.h"
#import "CollectionViewCell.h"

@interface TestVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIScrollView     *scroll;
@property (nonatomic, strong) NSMutableArray   *cellHeightArr;
@property (nonatomic, strong) NSMutableArray   *dataArr;
@property (nonatomic, assign) CGFloat scrollWidth;// scrollView的宽度

@end

@implementation TestVC
#pragma mark - 懒加载
- (UIScrollView *)scroll{
    if(!_scroll){
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.bounces = NO;//控制滚动视图是否反弹
        _scroll.alwaysBounceVertical = YES;
        _scroll.alwaysBounceHorizontal = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.contentSize = CGSizeMake(self.scrollWidth,SCREEN_HEIGHT - kNavigationBarHeight);
        [_scroll setContentOffset:CGPointMake(self.scrollWidth * 0.5, 0)animated:NO];
        [self.view addSubview:_scroll];
    }
    return _scroll;
    
}

- (UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat lineSpacing = 0;// 每一行的最小间距
        CGFloat interitemSpacing = 0;// 每一列的最小间距
        layout.minimumInteritemSpacing = interitemSpacing;
        layout.minimumLineSpacing = lineSpacing;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 设置cell与CollectionView边缘的间距
        layout.sectionInset = UIEdgeInsetsMake(lineSpacing, interitemSpacing, lineSpacing, interitemSpacing);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.scrollWidth, SCREEN_HEIGHT - kNavigationBarHeight) collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.dataSource = self;
        _collection.delegate = self;
        [self.scroll addSubview:_collection];
        
        //注册复用ID
        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [_collection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return _collection;
}

- (NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)cellHeightArr{
    if(!_cellHeightArr){
        _cellHeightArr = [NSMutableArray array];
    }
    return _cellHeightArr;
}

#pragma mark - 初始化和生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"collection单双路珠";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getDatas];
    [self collection];
    NSLog(@"分支2的提交");
}

#pragma mark - 自定义方法

#pragma mark - Target方法

#pragma mark - HTTP请求
- (void)getDatas{
    
    for (NSInteger i = 0; i < 20; i++) {
        if (i % 2 == 0) {
            [self.dataArr addObject:@[@"单双单双单双", @"单双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双",@"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双"]];
        }else{
            [self.dataArr addObject:@[@"双", @"单双", @"双双", @"单双单双单", @"单双", @"单双", @"单双", @"双", @"双", @"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双",@"双", @"双", @"单双", @"单双", @"单双", @"单双", @"双", @"双", @"双"]];
        }
    }
    
    NSArray *item0 = self.dataArr[0];
    self.scrollWidth = item0.count * itemWidth;
    
    CGFloat cellHeight = 0;
    
    for(NSInteger i = 0; i < self.dataArr.count; i++){
        for (NSInteger j = 0; j < [self.dataArr[i] count]; j++) {
            
            NSString *tempStr = self.dataArr[i][j];
            CGSize size = [tempStr boundingRectWithSize:CGSizeMake(itemWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} context:nil].size;
            
            cellHeight = cellHeight < size.height? size.height: cellHeight;
            
        }
        
        [self.cellHeightArr addObject:[NSNumber numberWithFloat:cellHeight]];
        cellHeight = 0;
        
    }
    
}

#pragma mark - 代理和协议
#pragma mark ----UICollectionViewDelegate----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.scrollWidth / itemWidth;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *title = self.dataArr[indexPath.section][indexPath.row];
    CGFloat cellHeight = [self.cellHeightArr[indexPath.section] floatValue];
    [cell refresh:title andcellHeight:cellHeight direction:VerticalStyle];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(itemWidth, [self.cellHeightArr[indexPath.section] floatValue]);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *view = nil;
    //判断是创建 header
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        view.backgroundColor = [UIColor yellowColor];
        
        UILabel *label = [view viewWithTag:10];
        if (!label) {
            label = [[UILabel alloc]initWithFrame:view.bounds];
            label.tag = 10;
            label.textColor = [UIColor redColor];
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentLeft;
            [view addSubview:label];
            
        }
        label.text = [NSString stringWithFormat:@"\t\t\t\t\t\t这是标题----%ld",indexPath.section];
    
    }
    return view;
}

@end
