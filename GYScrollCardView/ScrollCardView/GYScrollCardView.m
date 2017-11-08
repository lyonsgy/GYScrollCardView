//
//  GYScrollCardView.m
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYScrollCardView.h"
#import "GYCardListCollectionViewCell.h"
#import "GYLoadingCollectionReusableView.h"

#define CellReuseIdentifier @"GYCardListCollectionViewCell"
#define CellLoadingReuseIdentifier @"GYLoadingCollectionReusableView"

static NSInteger const kHspace = 0; //水平间距

@interface GYScrollCardView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat _lastContentOffset;
    NSInteger _section;
    NSInteger _index;
    BOOL _isLeft;
}
@end

@implementation GYScrollCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCustomView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setCustomView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_firstCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(0);
        make.left.mas_equalTo(self.mas_left).with.offset(0);
        make.right.mas_equalTo(self.mas_right).with.offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
    }];
}

- (void)setCustomView
{
    _section = 0;
    _index = 0;
    [self setCollectionView];
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
-(void)setCollectionView{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置footerReferenceSize的尺寸大小
    layout.footerReferenceSize = CGSizeMake(self.zj_width, self.zj_height);
    
    self.firstCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:_firstCollectionView];
    //2.初始化collectionView
    _firstCollectionView.pagingEnabled = YES;
    _firstCollectionView.collectionViewLayout = layout;
    _firstCollectionView.showsHorizontalScrollIndicator = NO;
    _firstCollectionView.backgroundColor = [UIColor blueColor];
    [_firstCollectionView registerNib:[UINib nibWithNibName:@"GYCardListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellReuseIdentifier];
    [_firstCollectionView registerNib:[UINib nibWithNibName:@"GYLoadingCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CellLoadingReuseIdentifier];
    //4.设置代理
    _firstCollectionView.delegate = self;
    _firstCollectionView.dataSource = self;
}
#pragma mark - collectionViewDelegate&collectionViewDataSource
// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter)
    {
        //        self.firstCollectionView.scrollEnabled = false;
        GYLoadingCollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CellLoadingReuseIdentifier forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor redColor];
        footerview.label.text = [NSString stringWithFormat:@"第 %ld 组",(long)indexPath.section+1];
        reusableView = footerview;
    }
    return reusableView;
}
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _array.count;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GYCardListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.cardCollectionView.backgroundColor = (indexPath.row%2==0)?[UIColor yellowColor]:[UIColor lightGrayColor];
    cell.array = _array[indexPath.row][@"cardList"];
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.zj_width, self.zj_height);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kHspace;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kHspace;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.x;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //松手
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滚动结束
    UICollectionView *collectionView = (UICollectionView*)scrollView;
    if (collectionView == _firstCollectionView) {
        NSInteger pageIndex = _firstCollectionView.contentOffset.x/_firstCollectionView.frame.size.width;
        NSLog(@"___%ld",(long)pageIndex);
        if (_firstCollectionView.contentOffset.x<_lastContentOffset)
        {
            //向右
            _isLeft = NO;
            if ((pageIndex+1)%2==0) {
                [self scrollToLeftWithSection:(pageIndex+1)/2];
            }
        }
        else if (_firstCollectionView.contentOffset.x>_lastContentOffset)
        {
            //向左
            _isLeft = YES;
            if ((pageIndex+1)%2==0) {
                if (pageIndex>=(_array.count-1)*2) {
                    //最后一页，加载更多
                    [_array addObject:@{@"cardList":@[@"第1张",@"第2张",@"第3张",@"第4张",@"第5张"]}];
                    [_firstCollectionView reloadData];
                }
                [self scrollToLeftWithSection:pageIndex/2];
            }
        }
    }
}
#pragma mark - GYCardListCollectionViewCellDelegate
-(void)cardList_scrollToEnd
{
    
}
#pragma mark - setter
-(void)setArray:(NSMutableArray *)array
{
    _array = array;
    [_firstCollectionView reloadData];
}

-(void)scrollToLeftWithSection:(NSInteger)section{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //翻页
        NSInteger nextSection = _isLeft?(section+1):(section-1);
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:0 inSection:nextSection];
        [self.firstCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:_isLeft?UICollectionViewScrollPositionLeft:UICollectionViewScrollPositionRight animated:YES];
        
    });}

@end
