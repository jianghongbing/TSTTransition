//
//  TSTAnimator.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTAnimator.h"
#import "TSTTransitionGlobalSetting.h"
@interface TSTAnimator()
@property (nonatomic) NSTimeInterval duration;
@property (nullable, nonatomic) CGColorRef originalShadowColor;
@property (nonatomic) CGFloat originalShadowOpacity;
@property (nonatomic) CGSize originalShadowOffset;
@property (nonatomic) CGFloat originalShadowRadius;
@property (nullable, nonatomic) CGPathRef originalShadowPath;
@property (nonatomic) CGFloat alpha;
@property (nonatomic) CGFloat widthScale;
@property (nonatomic) CGFloat heightScale;
@property (nullable, nonatomic, strong) UIColor *shadowColor;
@property (nonatomic) CGFloat shadowOpacity;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) CGFloat shadowRadius;
@property (nullable, nonatomic, strong) UIBezierPath *shadowPath;
@end
@implementation TSTAnimator
#pragma mark initializer
- (instancetype)initWithDuration:(NSTimeInterval)duration
                           alpha:(CGFloat)alpha
                      widthScale:(CGFloat)widthScale
                     heightScale:(CGFloat)heightScale
                     shadowColor:(UIColor *)shadowColor
                   shadowOpacity:(CGFloat)shadowOpacity
                    shadowOffset:(CGSize)shadowOffset
                    shadowRadius:(CGFloat)shadowRadius
                      shadowPath:(UIBezierPath *)shadowPath {
    self = [super init];
    if (self) {
        _duration = duration;
        _alpha = alpha;
        _widthScale = widthScale;
        _heightScale = heightScale;
        _shadowColor = shadowColor;
        _shadowOpacity = shadowOpacity;
        _shadowOffset = shadowOffset;
        _shadowRadius = shadowRadius;
        _shadowPath = shadowPath;
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
    UIView *topView = isPresenting ? toView : fromView;
    UIView *bottomView = isPresenting ? fromView : toView;
    
    
    CGRect topViewInitialFrame = isPresenting ? toViewInitialFrame : fromViewInitialFrame;
    CGRect topViewFinalFrame = isPresenting ? toViewFinalFrame : fromViewFinalFrame;
    
    [self storeOriginalShadowForView:topView];
    
    [UIView performWithoutAnimation:^{
        if (isPresenting) {
            [containerView addSubview:toView];
        }else {
            [containerView insertSubview:toView belowSubview:fromView];
        }
        bottomView.transform = [self bottomViewTransformAtAmaitionStart:isPresenting];
        bottomView.alpha = self.alpha;
        topView.frame = topViewInitialFrame;
        [self addShadowToView:topView];
    }];
    
    UIViewAnimationOptions options = isPresenting ? UIViewAnimationOptionCurveEaseOut : UIViewAnimationOptionCurveEaseIn;

    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        topView.frame = topViewFinalFrame;
        bottomView.alpha = 1.0;
        bottomView.transform = [self bottomViewTransformDuringAnimation:isPresenting];
    } completion:^(BOOL finished) {
        [self restoreOriginalShadowToView:topView];
        bottomView.transform = CGAffineTransformIdentity;
        BOOL transitionWasCancelled = [transitionContext transitionWasCancelled];
        if (transitionWasCancelled) {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!transitionWasCancelled];
    }];
}


#pragma mark helper
- (CGAffineTransform)bottomViewTransformAtAmaitionStart:(BOOL)isPresenting {
    return isPresenting ? CGAffineTransformIdentity : CGAffineTransformMakeScale(self.widthScale, self.heightScale);
}

- (CGAffineTransform)bottomViewTransformDuringAnimation:(BOOL)isPresenting {
    return isPresenting ? CGAffineTransformMakeScale(self.widthScale, self.heightScale) : CGAffineTransformIdentity;
}

- (void)storeOriginalShadowForView:(UIView *)view {
    self.originalShadowColor = view.layer.shadowColor;
    self.originalShadowOpacity = view.layer.shadowOpacity;
    self.originalShadowOffset = view.layer.shadowOffset;
    self.originalShadowRadius = view.layer.shadowRadius;
    self.originalShadowPath = view.layer.shadowPath;
}

- (void)addShadowToView:(UIView *)view {
    view.layer.shadowColor = self.shadowColor.CGColor;
    view.layer.shadowOpacity = self.shadowOpacity;
    view.layer.shadowRadius = self.shadowRadius;
    view.layer.shadowOffset = self.shadowOffset;
    view.layer.shadowPath = self.shadowPath.CGPath;
}

- (void)restoreOriginalShadowToView:(UIView *)view {
    view.layer.shadowColor = self.originalShadowColor;
    view.layer.shadowOpacity = self.originalShadowOpacity;
    view.layer.shadowOffset = self.originalShadowOffset;
    view.layer.shadowRadius = self.originalShadowRadius;
    view.layer.shadowPath = self.originalShadowPath;
}
@end
