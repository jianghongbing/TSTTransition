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

//custom your own dismiss interactive transition,default is nil, if nil, an instance of TSTInteractiveTransition instead.
@property (nullable, nonatomic, strong) id<UIViewControllerInteractiveTransitioning> dismissInteractiveTransition;
//properties as below are effect for TSTTAnimator and TSTTInteractiveTransition.
//transion animation duration, default is 0.25
@property (nonatomic) NSTimeInterval duration;
//an instance of TSTTAnimator as TSTTTransition animator. default is YES.if NO and you don't provide custom present animator & custom dismiss animator, will use system default presntation & dismiss animator
@property (nonatomic, getter=isUseTSTTAnimatorAsDefault) BOOL useTSTTAnimatorAsDefault;

//enable interactive dismiss transition or not,default is YES
@property (nonatomic) BOOL enabledInteractiveDismissTransition;

////whether dismiss view controler by full screen gesture recognizer or not, defaut is YES, it is effect for TSTTAnimator.
//@property (nonatomic, getter=isEnabledFullScreenInteractiveTransition) BOOL enabledFullScreenInteractiveTransition;
//
////whether dismiss view controler by screen left edge gesture recognizer or not, defaut is YES, it is effect for TSTTAnimator.
//@property (nonatomic, getter=isEnabledScreenEdgeInteractiveTransition) BOOL enabledScreenEdgeInteractiveTransition;

//The value of this property is in the range 0.0 to 1.0,trigger for dismiss view controller. default is 0.3.
@property (nonatomic) float triggerPercent;

////shadow is add to the top view in tansition
//@property (nonatomic) CGFloat tst_shadowWidth;
//@property (nonatomic, strong) UIColor *tst_shadowColor;
//@property (nonatomic) CGFloat tst_initialShadowOpcity; //default is 0.2
@end

NS_ASSUME_NONNULL_END
