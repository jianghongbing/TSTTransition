//
//  TSTDismissInteractiveTransition.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class TSTDismissInteractiveTransition;
typedef void(^TSTDismissInteractiveTransitionCompletion)(BOOL finished);
@protocol TSTInteractiveDismissTransitionDelegate <NSObject>
@optional
- (void)interactiveDismissTransition:(TSTDismissInteractiveTransition *)interactiveDismissTransition didFinish:(BOOL)finished;

- (void)interactiveDismissTransition:(TSTDismissInteractiveTransition *)interactiveDismissTransition updateAnimationProgress:(float)animationProgress;


@end

@interface TSTDismissInteractiveTransition : UIPercentDrivenInteractiveTransition
- (instancetype)initWithViewController:(nonnull UIViewController *)viewController
                        triggerPercent:(CGFloat)triggerPercent
   enabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition;
@property (nullable, nonatomic, weak) id<TSTInteractiveDismissTransitionDelegate> delegate;
@property (nullable, nonatomic, copy) TSTDismissInteractiveTransitionCompletion completion;

@end

NS_ASSUME_NONNULL_END
