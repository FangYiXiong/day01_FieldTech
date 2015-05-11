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
    
    //  1.  拿到各种 view
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    
    UIView *container = [transitionContext containerView];
    
    //  2.  创建各种切割截图，用来完成切割动画
    CGRect topHalf, bottomHalf;
    CGRectDivide(fromView.bounds, &topHalf, &bottomHalf, fromView.bounds.size.height / 2.0, CGRectMinYEdge);
    
    UIView *topHalfView = [fromView resizableSnapshotViewFromRect:topHalf
                                               afterScreenUpdates:NO
                                                    withCapInsets:UIEdgeInsetsZero];
    UIView *bottomHalfView = [fromView resizableSnapshotViewFromRect:bottomHalf
                                                  afterScreenUpdates:NO
                                                       withCapInsets:UIEdgeInsetsZero];
    bottomHalfView.frame = bottomHalf;// 重设这个frame，不然会和上面的view重叠
    
    //  3. 将各种截图和目标view加入动画容器中
    [container addSubview:toView];
    [container addSubview:topHalfView];
    [container addSubview:bottomHalfView];
    
    //  4. 开始动画，上下切割的转场效果，不知道怎么形容 :[
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        topHalfView.center = CGPointMake(-topHalfView.center.x, topHalfView.center.y);
        bottomHalfView.center = CGPointMake(bottomHalfView.center.x + bottomHalf.size.width, bottomHalfView.center.y);
    } completion:^(BOOL finished) {
        [topHalfView removeFromSuperview];
        [bottomHalfView removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    }];
}

@end
