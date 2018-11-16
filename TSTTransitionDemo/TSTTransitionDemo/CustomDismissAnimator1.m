//
//  CustomDismissAnimator1.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/15.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "CustomDismissAnimator1.h"

@implementation CustomDismissAnimator1
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toViewInitialFrame = CGRectOffset(toViewFinalFrame, 0, CGRectGetHeight(toViewFinalFrame) * 0.1);
    
    CGRect fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromViewFinalFrame = CGRectOffset(fromViewInitialFrame, 0, CGRectGetHeight(toViewFinalFrame));
    
    UIView *toView;
    UIView *fromView;
    if (@available(iOS 8.0, *)) {
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    } else {
        toView = toViewController.view;
        fromView = fromViewController.view;
    }
    
    
    [UIView performWithoutAnimation:^{
        [containerView insertSubview:toView belowSubview:fromView];
        toView.alpha = 0.5;
        toView.frame = toViewInitialFrame;
    }];
    
    
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toView.frame = toViewFinalFrame;
        fromView.frame = fromViewFinalFrame;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        BOOL transitionWasCancelled = [transitionContext transitionWasCancelled];
        if (transitionWasCancelled) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!transitionWasCancelled];
    }];
}
@end
