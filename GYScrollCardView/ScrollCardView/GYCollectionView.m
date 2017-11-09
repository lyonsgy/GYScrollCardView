//
//  GYCollectionView.m
//  GYScrollCardView
//
//  Created by lyons on 2017/11/8.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "GYCollectionView.h"

@interface GYCollectionView ()

@end

@implementation GYCollectionView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCustomView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setCustomView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setCustomView
{
    
    
}

//返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}
@end
