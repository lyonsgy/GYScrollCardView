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
    _scrollCardView.array = [NSMutableArray arrayWithArray:_dataArray];
    _scrollCardView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollCard_scrollToEndInSection:(NSInteger)section
{
//    [_dataArray addObject:@{@"cardList":_cardArray}];
    [_scrollCardView.array addObject:@{@"cardList":_cardArray}];
    [_scrollCardView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //翻页
        [self.scrollCardView scrollToLeftWithSection:section];
    });
}
@end
