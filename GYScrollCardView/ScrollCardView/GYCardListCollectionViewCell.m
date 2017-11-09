//
//  GYCardListCollectionViewCell.m
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCardListCollectionViewCell.h"
#import "GYScrollCardHeader.h"
#import "GYCardCollectionViewCell.h"
#import "GYLoadingCollectionReusableView.h"
#import "GYCardViewFlowLayout.h"

#define CellReuseIdentifier @"GYCardCollectionViewCell"
#define CellLoadingReuseIdentifier @"GYLoadingCollectionReusableView"

@interface GYCardListCollectionViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat _lastContentOffset;
    CGFloat _lastWidth;
}
@end

@implementation GYCardListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCollectionView];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blueColor];
    NSInteger pageIndex = _cardCollectionView.contentOffset.x/_cardCollectionView.bounds.size.width;
    self.titleLabel.text = [NSString stringWithFormat:@"第%ld个标题",(long)pageIndex+1];
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
-(void)setCollectionView{
    //1.初始化layout
    GYCardViewFlowLayout *layout = [[GYCardViewFlowLayout alloc]init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    //2.初始化collectionView
    _cardCollectionView.collectionViewLayout = layout;
    _cardCollectionView.showsHorizontalScrollIndicator = NO;
    _cardCollectionView.bounces = NO;
    [_cardCollectionView registerNib:[UINib nibWithNibName:@"GYCardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellReuseIdentifier];
    //3.设置代理
    _cardCollectionView.delegate = self;
    _cardCollectionView.dataSource = self;
    
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
    GYCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.label.text = _array[indexPath.row];
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
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - scrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.x;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滚动结束
    if ([scrollView isDragging]) {
        CGFloat endSectionScrollX = scrollView.contentOffset.x - _lastWidth;
        CGFloat tempProgress = endSectionScrollX/_cardCollectionView.bounds.size.width;
        CGFloat progress = tempProgress - floor(tempProgress);
        NSInteger tempIndex = tempProgress;
        UICollectionView *collectionView = (UICollectionView*)scrollView;
        if (collectionView == _cardCollectionView) {
            if (_cardCollectionView.contentOffset.x<_lastContentOffset)
            {
                //向右
                [self alphaWithUIProgress:progress isLeft:NO tempIndex:tempIndex endSectionScrollX:_lastWidth];
            }
            else if (_cardCollectionView.contentOffset.x>_lastContentOffset)
            {
                //向左
                [self alphaWithUIProgress:tempProgress isLeft:YES tempIndex:tempIndex endSectionScrollX:_lastWidth];
            }
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _lastWidth = scrollView.contentOffset.x;
    //TODO:通知刷新titleLabel
    NSInteger pageIndex = _cardCollectionView.contentOffset.x/_cardCollectionView.bounds.size.width;
    self.titleLabel.text = [NSString stringWithFormat:@"第%ld个标题",(long)pageIndex+1];
    
    [UIView animateWithDuration:.3 animations:^{
        self.titleLabel.zj_x = 20;
        self.titleLabel.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
- (void)alphaWithUIProgress:(CGFloat)UIProgress isLeft:(BOOL)isLeft tempIndex:(NSInteger)tempIndex endSectionScrollX:(CGFloat)endSectionScrollX{
    if (isLeft) {
        //向左
        _titleLabel.alpha = 1-UIProgress;
        _titleLabel.zj_x = 20+10*UIProgress;
    }else{
        //向右
        _titleLabel.alpha = UIProgress;
        _titleLabel.zj_x = 20+10*(1-UIProgress);
    }
}

@end
