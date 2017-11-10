//
//  GYCardListCollectionViewCell.h
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYCollectionView.h"

@interface GYCardListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet GYCollectionView *cardCollectionView;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic) BOOL isLeft;

@end
