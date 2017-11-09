//
//  GYScrollCardView.h
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYScrollCardHeader.h"
#import "GYCollectionView.h"

@protocol GYScrollCardViewDelegate <NSObject>
@optional
-(void)scrollCard_scrollToSection:(NSInteger)section;

@end

@interface GYScrollCardView : UIView
@property (nonatomic ,strong) GYCollectionView *firstCollectionView;
@property (nonatomic ,strong) NSMutableArray *array;
@property (nonatomic, weak) id<GYScrollCardViewDelegate> delegate;
-(void)scrollToLeftWithSection:(NSInteger)section;
@end
