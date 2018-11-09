//
//  TSTTransitionGlobalSetting.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TSTTransitionGlobalSetting : NSObject

+ (instancetype)golbalSetting;

//an instance of TSTTAnimator as TSTTTransition animator. default is YES.if NO and you don't provide custom presentAnimator & custom dismiss Animator, will use system default presntation & dismiss Animator
@property (nonatomic) BOOL useTSTTAnimatorAsDefault;

//custom your own animator as TSTTTranstion presentation amimator,default is nil and use TSTTAnimator
@property (nullable, nonatomic, strong) id<UIViewControllerAnimatedTransitioning> presentAnimator;

//custom your own animator as TSTTTransition dismiss animator, default is nil and use TSTTAnimator
@property (nullable, nonatomic, strong) id<UIViewControllerAnimatedTransitioning>dismissAnimator;

//properties as below are effect for TSTTAnimator only.

//whether dismiss view controler by full screen gesture recognizer, defaut is YES, it is effect for TSTTAnimator.
@property (nonatomic) BOOL enabledFullScreenInteractiveTransition;

//whether dismiss view controler by screen edge gesture recognizer, defaut is YES, it is effect for TSTTAnimator.
@property (nonatomic) BOOL enabledScreenEdgeInteractiveTransition;

//The value of this property is in the range 0.0 to 1.0,trigger for dismiss view controller. default is 0.3. it is effect for TSTTAnimator.
@property (nonatomic) float triggerPercent;
@end

NS_ASSUME_NONNULL_END
