//
//  CustomPresentInteractiveTransition.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/14.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "CustomPresentInteractiveTransition.h"
@interface CustomPresentInteractiveTransition()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation CustomPresentInteractiveTransition
#pragma mark initializer
- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
        [self addGestureRecognizers];
    }
    return self;
}

- (void)addGestureRecognizers {
    UIView *view = self.viewController.view;
    if (view == nil) return;
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizerEvent:)];
    self.panGestureRecognizer.delegate = self;
//    UITableView *tableView = (UITableView *)view;
//    tableView.scrollEnabled = NO;
    [view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)removeGestureRecognizer {
    UIView *view = self.viewController.view;
    if (view == nil) return;
    [view removeGestureRecognizer:self.panGestureRecognizer];
}


- (void)dealloc {
    [self removeGestureRecognizer];
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState state = panGestureRecognizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:[self transitionPercentForGestureRecognizer:panGestureRecognizer]];
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGFloat percent = [self transitionPercentForGestureRecognizer:panGestureRecognizer];
            percent >= 0.5 ? [self finishInteractiveTransition] : [self cancelInteractiveTransition];
        }
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}


- (CGFloat)transitionPercentForGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    UIView *containerView = self.transitionContext.containerView;
    CGFloat height = CGRectGetHeight(containerView.bounds);
    CGFloat yTransition = [panGestureRecognizer translationInView:containerView].y;
    CGFloat percent = MIN(yTransition / height, 0);
    return fabsf(percent);
}


#pragma mark UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

- (void)finishInteractiveTransition {
    [self removeGestureRecognizer];
    [super finishInteractiveTransition];
}


- (void)cancelInteractiveTransition {
    [self removeGestureRecognizer];
    [super cancelInteractiveTransition];
}



#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
