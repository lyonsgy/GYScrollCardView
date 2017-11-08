//
//  ViewController.m
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "ViewController.h"
#import "GYScrollCardHeader.h"

@interface ViewController ()<GYScrollCardViewDelegate>
@property (nonatomic ,strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)NSMutableArray *cardArray;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _cardArray = [NSMutableArray arrayWithArray:@[@"第1张",@"第2张",@"第3张",@"第4张",@"第5张"]];
    _dataArray = [NSMutableArray new];
    [_dataArray addObject:@{@"cardList":_cardArray}];
    [_dataArray addObject:@{@"cardList":_cardArray}];
    [_dataArray addObject:@{@"cardList":_cardArray}];
    _scrollCardView.array = [NSMutableArray arrayWithArray:_dataArray];
    _scrollCardView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollToNextCard:(UICollectionView*)collection
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
}
@end
