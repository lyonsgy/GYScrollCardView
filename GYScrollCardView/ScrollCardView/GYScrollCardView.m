//
//  GYScrollCardView.m
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYScrollCardView.h"
#import "GYCardListCollectionViewCell.h"

#define CellReuseIdentifier @"GYCardListCollectionViewCell"

static NSInteger const kHspace = 0; //水平间距

@interface GYScrollCardView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat _lastContentOffset;
    NSInteger _section;
    NSInteger _index;
}
@end

@implementation GYScrollCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCustomView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToLeft) name:Notif_ScrollToLeft object:nil];
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
    
    self.firstCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:_firstCollectionView];
    //2.初始化collectionView
    _firstCollectionView.pagingEnabled = YES;
    _firstCollectionView.collectionViewLayout = layout;
    _firstCollectionView.showsHorizontalScrollIndicator = NO;
    _firstCollectionView.backgroundColor = [UIColor blueColor];
    [_firstCollectionView registerNib:[UINib nibWithNibName:@"GYCardListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellReuseIdentifier];
    //4.设置代理
    _firstCollectionView.delegate = self;
    _firstCollectionView.dataSource = self;
}
#pragma mark - collectionViewDelegate&collectionViewDataSource
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GYCardListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.cardCollectionView.delegate = self;
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
    UICollectionView *collectionView = (UICollectionView*)scrollView;
    if (collectionView == _firstCollectionView) {
        _section = scrollView.contentOffset.x/self.frame.size.width;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_delegate) {
        NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
        [_delegate scrollCard_scrollViewDidScroll:scrollView index:index isLeft:(scrollView.contentOffset.x>_lastContentOffset)];
    }
    UICollectionView *collectionView = (UICollectionView*)scrollView;
    if (collectionView == _firstCollectionView) {
        if (collectionView.contentOffset.x<_lastContentOffset)
        {
            //换组：向右
            //往前翻到上一页的最后一页loading
//            NSLog(@"向右换组");
        }
        else if (collectionView.contentOffset.x>_lastContentOffset)
        {
            //换组：向左
//            NSLog(@"向左换组");

        }
    }else{
        _index = scrollView.contentOffset.x/self.frame.size.width;
        if (collectionView.contentOffset.x<_lastContentOffset)
        {
            //————向右
//            NSLog(@"向右滚动");
            
        }else if (collectionView.contentOffset.x>_lastContentOffset){
            //————向左
//            NSLog(@"向左滚动");
            NSArray *cardArray = _array[_section][@"cardList"];
            if (_index==cardArray.count) {
                //换组
//                NSLog(@"换组");
                //向左滑动到最后一页loading页,requestData
            }
        }
    }
    NSLog(@"___第%ld组，第%ld个",(long)_section+1,(long)index+1);
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

-(void)scrollToLeftWithIndex:(NSInteger)index{
    NSLog(@"向前翻组");
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index-1 inSection:0];
    [self.firstCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

@end
