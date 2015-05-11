//
//  SplitTransition.m
//  FieldTech
//
//  Created by fang on 15/5/11.
//  Copyright (c) 2015年 Jonathan Blocksom. All rights reserved.
//

#import "SplitTransition.h"

@implementation SplitTransition

#pragma mark - UIViewControllerAnimatedTransitioning

// 返回转场动画应该持续多长时间（以秒为单位）
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 2.0;
}

// 具体的转场动画实现代码在这里
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //  1.  拿到目标 viewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //  2.  创建一个目标 viewController 的截图，并让它先是全透明状态（即不可见）
    UIView *toViewSnapshot = [toVC.view snapshotViewAfterScreenUpdates:YES];
    toViewSnapshot.alpha = 0.0;
    
    //  3.  将这个截图放入动画的容器中，即 container view
    UIView *container = [transitionContext containerView];
    [container addSubview:toViewSnapshot];
    
    //  4.  开始动画，简单地渐隐渐现效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewSnapshot.alpha = 1.0;
    } completion:^(BOOL finished) {
        [toViewSnapshot removeFromSuperview];
        [container addSubview:toVC.view];
        [transitionContext completeTransition:YES];
    }];
}

@end
