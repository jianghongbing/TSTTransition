//
//  TSTAnimator.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTAnimator.h"
@interface TSTAnimator()
@property (nonatomic) NSTimeInterval duration;
@end
@implementation TSTAnimator
#pragma mark initializer
- (instancetype)initWithDuration:(NSTimeInterval)duration {
    self = [super init];
    if (self) {
        _duration = duration;
    }
    return self;
}


#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration > 0 ? self.duration : 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGFloat duration = [self transitionDuration:transitionContext];
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect toViewInitialFrame = CGRectOffset(toViewFinalFrame, CGRectGetWidth(toViewFinalFrame), 0);
    CGRect fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromViewFinalFrame = CGRectOffset(fromViewInitialFrame, CGRectGetWidth(fromViewInitialFrame), 0);
    
    UIView *toView;
    UIView *fromView;
    if (@available(iOS 8.0, *)) {
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    } else {
        toView = toViewController.view;
        fromView = fromViewController.view;
    }
    
    BOOL isPresenting = toViewController.presentingViewController == fromViewController;

    [UIView performWithoutAnimation:^{
        if (isPresenting) {
            toView.frame = toViewInitialFrame;
            fromView.alpha = 0.9;
            [containerView addSubview:toView];
        }else {
            toView.alpha = 0.9;
            toView.transform = CGAffineTransformMakeScale(1, 0.9);
            [containerView insertSubview:toView belowSubview:fromView];
        }
    }];
    
    UIViewAnimationOptions options = isPresenting ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn;

    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        if (isPresenting) {
            fromView.transform = CGAffineTransformMakeScale(1, 0.9);
            fromView.alpha = 1.0;
            toView.frame = toViewFinalFrame;
        }else {
            toView.alpha = 1.0;
            fromView.frame = fromViewFinalFrame;
            toView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        BOOL transitionWasCancelled = [transitionContext transitionWasCancelled];
        if (transitionWasCancelled) {
            [toView removeFromSuperview];
        }
        if (isPresenting) {
            fromView.transform = CGAffineTransformIdentity;
        }else {
            toView.transform = CGAffineTransformIdentity;
        }
        [transitionContext completeTransition:!transitionWasCancelled];
    }];
}
//- (UIView *)addShadowTo:(UIView *)view {
//    CGFloat shadowWidth = [TSTTransitionGlobalSetting golbalSetting].shadowWidth;
//    UIColor *shadowColor = [TSTTransitionGlobalSetting golbalSetting].shadowColor;
//    CGFloat initialShadowAlpha = [TSTTransitionGlobalSetting golbalSetting].initialShadowOpcity;
//    CGFloat shadowHeight = CGRectGetHeight(view.bounds);
//    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(-shadowWidth, 0, shadowWidth, shadowHeight)];
//    shadowView.backgroundColor = [UIColor grayColor];
//    shadowView.alpha = 0.5;
//    [view addSubview:shadowView];
//    return shadowView;
//}
@end
