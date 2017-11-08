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

@end

@implementation GYCardListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCollectionView];
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
    _cardCollectionView.backgroundColor = [UIColor lightGrayColor];
    [_cardCollectionView registerNib:[UINib nibWithNibName:@"GYCardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellReuseIdentifier];
    //4.设置代理
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

@end
