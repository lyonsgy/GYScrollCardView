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
    [_dataArray addObject:@{@"cardList":_cardArray}];
    _scrollCardView.array = [NSMutableArray arrayWithArray:_dataArray];
    _scrollCardView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollCard_scrollViewDidScroll:(UIScrollView *)scrollView index:(NSInteger)index isLeft:(BOOL)isleft
{
//    UICollectionView *collectionView = (UICollectionView*)scrollView;
//    if (collectionView == _scrollCardView.firstCollectionView) {
//        NSLog(@"___第%ld组",(long)index+1);
//        if (!isleft)
//        {
//            //换组：向右
//            //往前翻到上一页的最后一页loading
//            NSLog(@"向右换组");
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                //向前翻组
//            });
//        }
//        else
//        {
//            //换组：向左
//            NSLog(@"向左换组");
//        }
//    }else{
//        NSLog(@"___第%ld个",(long)index+1);
//        if (!isleft)
//        {
//            //————向右
//            NSLog(@"向右滚动");
//        }else{
//            //————向左
//            NSLog(@"向左滚动");
//            if (index==7) {
//                //换组
//                NSLog(@"换组");
//                //向左滑动到最后一页loading页,requestData
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    //向后翻组
//
//                });
//            }
//        }
//    }
}

-(void)scrollToNextCard:(UICollectionView*)collection
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [collection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
}
@end
