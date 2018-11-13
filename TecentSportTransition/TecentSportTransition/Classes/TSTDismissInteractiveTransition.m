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
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
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
        [self addGestureRecognizers];
    }
    return self;
}

- (UIView *)gestureRecognizersView {
    return self.viewController.view;
}

- (void)addGestureRecognizers {
    if(!self.enabledInteractiveDismissTransition) return;
    UIView *view = [self gestureRecognizersView];
    if (view == nil) return;
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizerEvent:)];
    self.panGestureRecognizer.delegate = self;
    [view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)removeGestureRecognizers {
    UIView *view = [self gestureRecognizersView];
    if (view == nil) return;
    [view removeGestureRecognizer:self.panGestureRecognizer];
}


- (void)dealloc {
    [self removeGestureRecognizers];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(interactiveDismissTransition:updateAnimationProgress:)]) {
        [self.delegate interactiveDismissTransition:self updateAnimationProgress:percent];
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
    if (self.completion) {
        self.completion((finished));
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(interactiveDismissTransition:didFinish:)]) {
        [self.delegate interactiveDismissTransition:self didFinish:finished];
    }
}


#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UINavigationController *navigationController;
    if ([self.viewController isKindOfClass:[UINavigationController class]]) {
        navigationController = (UINavigationController *)self.viewController;
    }else if (self.viewController.navigationController) {
        navigationController = self.viewController.navigationController;
    }
    if (navigationController && navigationController.viewControllers.count > 1) return NO;
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

@end
