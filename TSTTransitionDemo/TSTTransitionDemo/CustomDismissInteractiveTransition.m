//
//  CustomDismissInteractiveTransition.m
//  
//
//  Created by pantosoft on 2018/11/15.
//

#import "CustomDismissInteractiveTransition.h"
@interface CustomDismissInteractiveTransition()
@property (nonatomic, weak) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation CustomDismissInteractiveTransition

- (void)setPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    [_panGestureRecognizer removeTarget:self action:@selector(excuteCustomDismissInteractiveTransition:)];
    _panGestureRecognizer = panGestureRecognizer;
    [panGestureRecognizer addTarget:self action:@selector(excuteCustomDismissInteractiveTransition:)];
}

- (void)excuteCustomDismissInteractiveTransition:(UIPanGestureRecognizer *)panGestureRecognizer {
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
    CGFloat percent = MAX(yTransition / height, 0);
    return fabs(percent);
}


#pragma mark UIViewControllerInteractiveTransitioning
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}
@end
