//
//  TSTTransition.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTTransition.h"
#import "TSTAnimator.h"
#import "TSTDismissInteractiveTransition.h"
#import "TSTTransitionGlobalSetting.h"
@interface TSTTransition()
@property (nullable, nonatomic, strong) TSTDismissInteractiveTransition *interactiveTransition;
@property (nullable, nonatomic, strong) NSNumber *usedTSTAnimatorAsDefaultNumber;
@property (nullable, nonatomic, strong) NSNumber *enabledInteractiveDismissTransitionNumber;
@property (nullable, nonatomic, strong) NSNumber *alphaNumber;
@property (nullable, nonatomic, strong) NSNumber *widthScaleNumber;
@property (nullable, nonatomic, strong) NSNumber *heightScaleNumber;
@property (nullable, nonatomic, strong) NSNumber *shadowOpacityNumber;
@property (nullable, nonatomic, strong) NSValue *shadowOffsetValue;
@property (nullable, nonatomic, strong) NSNumber *shadowRadiusNumber;
@end
@implementation TSTTransition
#pragma mark initiazlier
- (void)dealloc {
    self.presentAnimator = nil;
    self.dismissAnimator = nil;
    self.presentInteractiveTransition = nil;
    self.dismissInteractiveTransition = nil;
    self.interactiveTransition = nil;
}

#pragma mark setter
- (void)setUsedTSTAnimatorAsDefault:(BOOL)usedTSTAnimatorAsDefault {
    _usedTSTAnimatorAsDefaultNumber = @(usedTSTAnimatorAsDefault);
}

- (void)setEnabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition {
    _enabledInteractiveDismissTransitionNumber = @(enabledInteractiveDismissTransition);
}

- (void)setAlpha:(CGFloat)alpha {
    _alphaNumber = @(alpha);
}

- (void)setWidthScale:(CGFloat)widthScale {
    _widthScaleNumber = @(widthScale);
}

- (void)setHeightScale:(CGFloat)heightScale {
    _heightScaleNumber = @(heightScale);
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    _shadowOpacityNumber = @(shadowOpacity);
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffsetValue = [NSValue valueWithCGSize:shadowOffset];
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadiusNumber = @(shadowRadius);
}

#pragma mark getter
- (CGFloat)alpha {
    if (self.alphaNumber) return self.alphaNumber.floatValue;
    return [TSTTransitionGlobalSetting globalSetting].alpha;
}

- (CGFloat)widthScale {
    if (self.widthScaleNumber) return self.widthScaleNumber.floatValue;
    return [TSTTransitionGlobalSetting globalSetting].widthScale;
}

- (CGFloat)heightScale {
    if (self.heightScaleNumber) return self.widthScaleNumber.floatValue;
    return [TSTTransitionGlobalSetting globalSetting].heightScale;
}

- (UIColor *)shadowColor {
    return _shadowColor ?: [TSTTransitionGlobalSetting globalSetting].shadowColor;
}

- (CGFloat)shadowOpacity {
    if (_shadowOpacityNumber) return self.shadowRadiusNumber.floatValue;
    return [TSTTransitionGlobalSetting globalSetting].shadowOpacity;
}

- (CGSize)shadowOffset {
    if (_shadowOffsetValue) return _shadowOffsetValue.CGSizeValue;
    return [TSTTransitionGlobalSetting globalSetting].shadowOffset;
}

- (CGFloat)shadowRadius {
    if (_shadowRadiusNumber) return _shadowRadiusNumber.floatValue;
    return [TSTTransitionGlobalSetting globalSetting].shadowRadius;
}

- (UIBezierPath *)shadowPath {
    return _shadowPath ?: [TSTTransitionGlobalSetting globalSetting].shadowPath;
}

#pragma mark getter
- (id<UIViewControllerAnimatedTransitioning>)presentAnimator {
    if (_presentAnimator) return _presentAnimator;
    return [TSTTransitionGlobalSetting globalSetting].presentAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)dismissAnimator {
    if (_dismissAnimator) return _dismissAnimator;
    return [TSTTransitionGlobalSetting globalSetting].dismissAnimator;
}

- (id<UIViewControllerInteractiveTransitioning>)presentInteractiveTransition {
    if (_presentInteractiveTransition) return _presentInteractiveTransition;
    return [TSTTransitionGlobalSetting globalSetting].presentInteractiveTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)dismissInteractiveTransition {
    if (_dismissInteractiveTransition) return _dismissInteractiveTransition;
    return [TSTTransitionGlobalSetting globalSetting].dismissInteractiveTransition;
}

- (BOOL)isUsedTSTAnimatorAsDefault {
    if (self.usedTSTAnimatorAsDefaultNumber)
        return [self.usedTSTAnimatorAsDefaultNumber boolValue];
    return [TSTTransitionGlobalSetting globalSetting].isUsedTSTAnimatorAsDefault;
}

- (NSTimeInterval)duration {
    if(_duration > 0) return _duration;
    return [TSTTransitionGlobalSetting globalSetting].duration;
}


- (BOOL)isEnabledInteractiveDismissTransition {
    if (self.enabledInteractiveDismissTransitionNumber)
        return [self.enabledInteractiveDismissTransitionNumber boolValue];
    return [TSTTransitionGlobalSetting globalSetting].isEnabledInteractiveDismissTransition;
}

- (CGFloat)triggerPercent {
    if (_triggerPercent > 0) return _triggerPercent;
    return [TSTTransitionGlobalSetting globalSetting].triggerPercent;
}

#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.enabledInteractiveDismissTransition && !self.presentAnimator && !self.dismissAnimator) {
        self.interactiveTransition = [[TSTDismissInteractiveTransition alloc] initWithViewController:presented triggerPercent:self.triggerPercent enabledInteractiveDismissTransition:self.enabledInteractiveDismissTransition];
    }
    if (self.presentAnimator) return self.presentAnimator;
    if (!self.isUsedTSTAnimatorAsDefault) return nil;
    return [[TSTAnimator alloc] initWithDuration:self.duration alpha:self.alpha widthScale:self.widthScale heightScale:self.heightScale shadowColor:self.shadowColor shadowOpacity:self.shadowOpacity shadowOffset:self.shadowOffset shadowRadius:self.shadowRadius shadowPath:self.shadowPath];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.dismissAnimator) return self.dismissAnimator;
    if (!self.isUsedTSTAnimatorAsDefault) return nil;
    return [[TSTAnimator alloc] initWithDuration:self.duration alpha:self.alpha widthScale:self.widthScale heightScale:self.heightScale shadowColor:self.shadowColor shadowOpacity:self.shadowOpacity shadowOffset:self.shadowOffset shadowRadius:self.shadowRadius shadowPath:self.shadowPath];
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
