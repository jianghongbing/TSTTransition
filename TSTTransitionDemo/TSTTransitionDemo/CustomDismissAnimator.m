//
//  CustomDismissAnimator.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/14.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "CustomDismissAnimator.h"

@implementation CustomDismissAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
//    CGRect toViewInitialFrame = CGRectOffset(toViewFinalFrame, CGRectGetWidth(toViewFinalFrame), 0);
    
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
    }];
    
    
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromView.alpha = 0.0;
        CGAffineTransform transform = fromView.transform;
        transform = CGAffineTransformScale(transform, 0.001, 0.001);
        transform = CGAffineTransformRotate(transform, 10 * M_PI * 2);
        fromView.transform = transform;
    } completion:^(BOOL finished) {
        BOOL transitionWasCancelled = [transitionContext transitionWasCancelled];
        if (transitionWasCancelled) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!transitionWasCancelled];
    }];
}
@end
