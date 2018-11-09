//
//  TSTTransition.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTTransition.h"
#import "TSTAnimator.h"
#import "TSTInteractiveTransition.h"
@interface TSTTransition()
@property (nonatomic, strong) TSTInteractiveTransition *interactiveTransition;
@end
@implementation TSTTransition
#pragma mark initiazlier
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _useTSTTAnimatorAsDefault = YES;
//    _enabledFullScreenInteractiveTransition = YES;
//    _enabledScreenEdgeInteractiveTransition = YES;
    _enabledInteractiveDismissTransition = YES;
    _triggerPercent = 0.3;
}



#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    BOOL isNavigationController = [presented isKindOfClass:[UINavigationController class]];
    if (isNavigationController) {
        self.interactiveTransition = [[TSTInteractiveTransition alloc] initWithNavigationController:(UINavigationController *)presented];
    }
    return [[TSTAnimator alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[TSTAnimator alloc] init];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (![animator isKindOfClass:[TSTAnimator class]]) return nil;
    return self.interactiveTransition;
}

@end
