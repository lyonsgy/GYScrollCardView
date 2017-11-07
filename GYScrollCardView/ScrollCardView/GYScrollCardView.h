//
//  GYScrollCardView.h
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYScrollCardHeader.h"

@protocol GYScrollCardViewDelegate <NSObject>
@optional
-(void)scrollCard_scrollViewDidScroll:(UIScrollView *)scrollView index:(NSInteger)index isLeft:(BOOL)isleft;

@end

@interface GYScrollCardView : UIView
@property (nonatomic ,strong) UICollectionView *firstCollectionView;
@property (nonatomic ,strong) NSMutableArray *array;
@property (nonatomic, weak) id<GYScrollCardViewDelegate> delegate;

@end
