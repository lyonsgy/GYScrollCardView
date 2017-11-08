//
//  GYCardViewFlowLayout.m
//  GYScrollCardView
//
//  Created by lyons on 2017/11/7.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCardViewFlowLayout.h"

@implementation GYCardViewFlowLayout
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    return proposedContentOffset;
}
@end
