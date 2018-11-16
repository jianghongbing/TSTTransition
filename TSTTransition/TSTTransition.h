//
//  TSTTransition.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface TSTTransition : NSObject <UIViewControllerTransitioningDelegate>
//custom your own animator as TSTTTranstion presentation amimator,default is nil and use TSTTAnimator
@property (nullable, nonatomic, strong) id<UIViewControllerAnimatedTransitioning> presentAnimator;

//custom your own animator as TSTTTransition dismiss animator, default is nil and use TSTTAnimator
@property (nullable, nonatomic, strong) id<UIViewControllerAnimatedTransitioning> dismissAnimator;

//custom your own present interactive transition,default is nil.
@property (nullable, nonatomic, strong) id<UIViewControllerInteractiveTransitioning> presentInteractiveTransition;

//custom your own dismiss interactive transition,default is nil, if nil, an instance of TSTInteractiveTransition instead.
@property (nullable, nonatomic, strong) id<UIViewControllerInteractiveTransitioning> dismissInteractiveTransition;

//properties as below are effect for TSTAnimator and TSTDismissInteractiveTransition.

//use an instance of TSTAnimator as TSTTransition animator. default is YES.if NO and you don't provide custom present animator or custom dismiss animator, will use system default presntation and dismiss animator
@property (nonatomic, readonly, getter=isUsedTSTAnimatorAsDefault) BOOL usedTSTAnimatorAsDefault;
- (void)setUsedTSTAnimatorAsDefault:(BOOL)usedTSTAnimatorAsDefault;

//transion animation duration, default is 0.25
@property (nonatomic) NSTimeInterval duration;

//enable interactive dismiss transition or not,default is YES
@property (nonatomic, readonly, getter=isEnabledInteractiveDismissTransition) BOOL enabledInteractiveDismissTransition;

- (void)setEnabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition;

//The value of this property is in the range 0.0 to 1.0,trigger for dismiss view controller. default is 0.3.
@property (nonatomic) CGFloat triggerPercent;

//The value of this property is in the range 0.0 to 1.0,set the value to transition bottom view during the animation start, default is 0.9;
@property (nonatomic, readonly) CGFloat alpha;
- (void)setAlpha:(CGFloat)alpha;
/* Scale properties, if it is presentation, scale fromView, otherwise scale toView*/
//width scale,default is 1.0
@property (nonatomic, readonly) CGFloat widthScale;
- (void)setWidthScale:(CGFloat)widthScale;
//height scale, default is 0.9
@property (nonatomic, readonly) CGFloat heightScale;
- (void)setHeightScale:(CGFloat)heightScale;

/* Shadow properties, if it is presentation, a shadow will be add to toView, otherwise add to the fromView */

/* The color of the shadow. Defaults is nil */
@property (nullable, nonatomic, strong) UIColor *shadowColor;

/* The opacity of the shadow. Defaults to 0 */
@property (nonatomic) CGFloat shadowOpacity;
- (void)setShadowOpacity:(CGFloat)shadowOpacity;

/* The shadow offset. Defaults to CGSizeZero */
@property (nonatomic) CGSize shadowOffset;
- (void)setShadowOffset:(CGSize)shadowOffset;

/* The blur radius used to create the shadow. Defaults to 0 */
@property (nonatomic) CGFloat shadowRadius;
- (void)setShadowRadius:(CGFloat)shadowRadius;

/* The path of shadow. Default is nil */
@property (nullable, nonatomic, strong) UIBezierPath *shadowPath;
@end

NS_ASSUME_NONNULL_END
