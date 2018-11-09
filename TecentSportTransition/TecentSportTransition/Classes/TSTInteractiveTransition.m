//
//  TSTInteractiveTransition.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTInteractiveTransition.h"
@interface TSTInteractiveTransition()
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGFloat triggerPercent;
@property (nonatomic, getter=isEnabledInteractiveDismissTransition) BOOL enabledInteractiveDismissTransition;
@end
@implementation TSTInteractiveTransition
#pragma mark initializer
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        _navigationController = navigationController;
        [self addGestureRecognizers];
    }
    return self;
}

- (instancetype)initWithViewController:(UIViewController *)viewController
                        triggerPercent:(CGFloat)triggerPercent
   enabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition {
    self = [super init];
    if (self) {
        _viewController = viewController;
        _triggerPercent = triggerPercent;
        _enabledInteractiveDismissTransition = enabledInteractiveDismissTransition;
    }
    return self;
}



- (UIView *)gestureRecognizersView {
    UIView *systemInteractivePopGestureRecognizerView = self.navigationController.interactivePopGestureRecognizer.view;
    UIView *view = systemInteractivePopGestureRecognizerView ?: self.navigationController.view;
    return view;
}


- (void)addGestureRecognizers {
    UIView *view = [self gestureRecognizersView];
    if (view == nil) return;
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizerEvent:)];
    [view addGestureRecognizer:self.panGestureRecognizer];
    [self.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

- (void)removeGestureRecognizers {
    UIView *view = [self gestureRecognizersView];
    if (view == nil) return;
    [view removeGestureRecognizer:self.panGestureRecognizer];
}


- (void)dealloc {
    [self removeGestureRecognizers];
    self.navigationController = nil;
}


- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState state = panGestureRecognizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:[self transitionPercentForGestureRecognizer:panGestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat percent = [self transitionPercentForGestureRecognizer:panGestureRecognizer];
            percent > 0.5 ? [self finishInteractiveTransition] : [self cancelInteractiveTransition];
        }
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}


- (CGFloat)transitionPercentForGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
//    UIGestureRecognizerState state = panGestureRecognizer.state;
    UIView *containerView = self.transitionContext.containerView;
    CGFloat width = CGRectGetWidth(containerView.bounds);
    CGFloat xTranslation = [panGestureRecognizer translationInView:containerView].x;
    CGFloat percent = MAX(xTranslation / width, 0);
//    CGFloat velocity = [panGestureRecognizer velocityInView:containerView].x;
//    if (state == UIGestureRecognizerStateEnded && velocity > 100) {
//        percent = 1;
//    }else {
//        CGFloat xTranslation = [panGestureRecognizer translationInView:containerView].x;
//        percent = MAX(xTranslation / width, 0);
//    }
    return percent;
}


#pragma mark UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)finishInteractiveTransition {
    [super finishInteractiveTransition];
//    self.popViewControllerByPanGestureRecognizer = NO;
}


- (void)cancelInteractiveTransition {
    [super cancelInteractiveTransition];
//    self.popViewControllerByPanGestureRecognizer = NO;
}

@end
