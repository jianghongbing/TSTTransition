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

//properties as below are effect for TSTAnimator and TSTInteractiveTransition.

//@property (nonatomic, weak) id<> delegate;
//use an instance of TSTAnimator as TSTTransition animator. default is YES.if NO and you don't provide custom present animator & custom dismiss animator, will use system default presntation & dismiss animator
@property (nonatomic, getter=isUsedTSTAnimatorAsDefault) BOOL usedTSTAnimatorAsDefault;

//transion animation duration, default is 0.25
@property (nonatomic) NSTimeInterval duration;

//enable interactive dismiss transition or not,default is YES
@property (nonatomic) BOOL enabledInteractiveDismissTransition;

//interactive dismiss transition completion handler
//@property (nullable, nonatomic, copy) TSTInteractiveDismissTransitionCompletion completion;

//The value of this property is in the range 0.0 to 1.0,trigger for dismiss view controller. default is 0.3.
@property (nonatomic) float triggerPercent;
@end

NS_ASSUME_NONNULL_END
