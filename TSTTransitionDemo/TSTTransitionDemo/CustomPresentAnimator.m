//
//  CustonPresentAnimator.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/14.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "CustomPresentAnimator.h"

@implementation CustomPresentAnimator
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toViewInitialFrame = CGRectOffset(toViewFinalFrame, CGRectGetWidth(toViewFinalFrame), 0);
    
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
        [containerView addSubview:toView];
        toView.alpha = 0;
        toView.frame = toViewInitialFrame;
        toView.layer.shadowColor = [UIColor grayColor].CGColor;
        toView.layer.shadowOffset = CGSizeMake(0, -3);
        toView.layer.shadowOpacity = 0.8;
    }];
    

    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toView.frame = toViewFinalFrame;
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
