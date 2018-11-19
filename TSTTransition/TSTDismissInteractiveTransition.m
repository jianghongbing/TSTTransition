//
//  TSTDismissInteractiveTransition.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTDismissInteractiveTransition.h"
#import "UIViewController+TSTTransitionPrivate.h"
@interface TSTDismissInteractiveTransition()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIViewController *viewController;
@property (nullable, nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nullable, nonatomic, strong) UIPanGestureRecognizer *dismissInteractiveGestureRecognizer;
@property (nonatomic) CGFloat triggerPercent;
@property (nonatomic, getter=isEnabledInteractiveDismissTransition) BOOL enabledInteractiveDismissTransition;
@end
@implementation TSTDismissInteractiveTransition
#pragma mark initializer
- (instancetype)initWithViewController:(UIViewController *)viewController
                        triggerPercent:(CGFloat)triggerPercent
   enabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition {
    self = [super init];
    if (self) {
        _viewController = viewController;
        _viewController.tst_dismissInteractiveTransition = self;
        _triggerPercent = triggerPercent;
        _enabledInteractiveDismissTransition = enabledInteractiveDismissTransition;
        [self addGestureRecognizer];
    }
    return self;
}

- (void)addGestureRecognizer {
    if(!self.enabledInteractiveDismissTransition) return;
    UIView *view = self.viewController.view;
    if (view == nil) return;
    self.dismissInteractiveGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizerEvent:)];
    self.dismissInteractiveGestureRecognizer.delegate = self;
    [view addGestureRecognizer:self.dismissInteractiveGestureRecognizer];
}

- (void)removeGestureRecognizer {
    UIView *view = self.viewController.view;
    if (view == nil) return;
    [view removeGestureRecognizer:self.dismissInteractiveGestureRecognizer];
}


- (void)dealloc {
    [self removeGestureRecognizer];
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState state = panGestureRecognizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            [self.viewController dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:[self transitionPercentForGestureRecognizer:panGestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat percent = [self transitionPercentForGestureRecognizer:panGestureRecognizer];
            percent >= self.triggerPercent ? [self finishInteractiveTransition] : [self cancelInteractiveTransition];
        }
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}


- (CGFloat)transitionPercentForGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    UIGestureRecognizerState state = panGestureRecognizer.state;
    UIView *containerView = self.transitionContext.containerView;
    CGFloat width = CGRectGetWidth(containerView.bounds);
    CGFloat percent = 0.0;
    CGFloat velocity = [panGestureRecognizer velocityInView:containerView].x;
    if (state == UIGestureRecognizerStateEnded && velocity > 100) {
        percent = 1;
    }else {
        CGFloat xTranslation = [panGestureRecognizer translationInView:containerView].x;
        percent = MAX(xTranslation / width, 0);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissInteractiveTransition:updateAnimationProgress:)]) {
        [self.delegate dismissInteractiveTransition:self updateAnimationProgress:percent];
    }
    return percent;
}


#pragma mark UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)finishInteractiveTransition {
    [self updateTransitionFinishStateToDelegate:YES];
    [super finishInteractiveTransition];
}


- (void)cancelInteractiveTransition {
    [self updateTransitionFinishStateToDelegate:NO];
    [super cancelInteractiveTransition];
}

- (void)updateTransitionFinishStateToDelegate:(BOOL)finished {    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissInteractiveTransition:didFinish:)]) {
        [self.delegate dismissInteractiveTransition:self didFinish:finished];
    }
}


#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UIView *view = gestureRecognizer.view;
    CGFloat translationX = [self.dismissInteractiveGestureRecognizer translationInView:view].x;
    return translationX > 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([self.viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self.viewController;
        if (navigationController.viewControllers.count > 1) return NO;
    }
    return YES;
}
@end
