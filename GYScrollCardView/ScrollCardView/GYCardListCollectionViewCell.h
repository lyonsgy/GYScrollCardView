//
//  GYCardListCollectionViewCell.h
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol GYCardListCollectionViewCellDelegate <NSObject>
//@optional
//-(void)cardList_scrollToEnd;
//
//@end

@interface GYCardListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (nonatomic, strong) NSMutableArray *array;
//@property (nonatomic, weak) id<GYCardListCollectionViewCellDelegate> delegate;
@end
