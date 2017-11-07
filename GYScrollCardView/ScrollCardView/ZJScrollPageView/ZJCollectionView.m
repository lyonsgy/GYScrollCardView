//
//  ZJScrollView.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/10/24.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJCollectionView.h"

@interface ZJCollectionView ()
@property (copy, nonatomic) ZJScrollViewShouldBeginPanGestureHandler gestureBeginHandler;
@end
@implementation ZJCollectionView
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UIPanGestureRecognizer* pan = (UIPanGestureRecognizer*)gestureRecognizer;
    if ([self panBack:gestureRecognizer]) {
        return NO;
    }
    return YES;
}
//location_X可自己定义,其代表的是滑动返回距左边的有效长度
- (BOOL)panBack:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer ==self.panGestureRecognizer) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self];
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state ||UIGestureRecognizerStatePossible == state) {
            if (point.x >0 &&self.contentOffset.x <=0) {
                return YES;
            }
        }
    }
    return NO;
    
}
- (void)setupScrollViewShouldBeginPanGestureHandler:(ZJScrollViewShouldBeginPanGestureHandler)gestureBeginHandler {
    _gestureBeginHandler = [gestureBeginHandler copy];
}

@end
