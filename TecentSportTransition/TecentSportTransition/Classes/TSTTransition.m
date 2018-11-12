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
#import "TSTTransitionGlobalSetting.h"
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
    _duration = 0.25;
    _enabledInteractiveDismissTransition = YES;
    _triggerPercent = 0.3;
}

- (void)dealloc {
    self.presentAnimator = nil;
    self.dismissAnimator = nil;
    self.interactiveTransition = nil;
    self.completion = nil;
}

#pragma mark getter
- (id<UIViewControllerAnimatedTransitioning>)presentAnimator {
    if (_presentAnimator) return _presentAnimator;
    return [TSTTransitionGlobalSetting golbalSetting].presentAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)dismissAnimator {
    if (_dismissAnimator) return _dismissAnimator;
    return [TSTTransitionGlobalSetting golbalSetting].dismissAnimator;
}

- (id<UIViewControllerInteractiveTransitioning>)presentInteractiveTransition {
    if (_presentInteractiveTransition) return _presentInteractiveTransition;
    return [TSTTransitionGlobalSetting golbalSetting].presentInteractiveTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)dismissInteractiveTransition {
    if (_dismissInteractiveTransition) return _dismissInteractiveTransition;
    return [TSTTransitionGlobalSetting golbalSetting].dismissInteractiveTransition;
}

- (NSTimeInterval)duration {
    if(_duration > 0) return _duration;
    return [TSTTransitionGlobalSetting golbalSetting].duration;
}

- (float)triggerPercent {
    if (_triggerPercent > 0) return _triggerPercent;
    return [TSTTransitionGlobalSetting golbalSetting].triggerPercent;
}

#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.enabledInteractiveDismissTransition) {
        self.interactiveTransition = [[TSTInteractiveTransition alloc] initWithViewController:presented triggerPercent:self.triggerPercent enabledInteractiveDismissTransition:self.enabledInteractiveDismissTransition completion:self.completion];
    }
    return self.presentAnimator ?: self.useTSTTAnimatorAsDefault ? [[TSTAnimator alloc] initWithDuration:self.duration] : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimator ?: self.useTSTTAnimatorAsDefault ? [[TSTAnimator alloc] initWithDuration:self.duration] : nil;
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.presentInteractiveTransition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if (self.dismissInteractiveTransition) return self.dismissInteractiveTransition;
    if (![animator isMemberOfClass:[TSTAnimator class]]) return nil;
    return self.interactiveTransition;
}

@end
