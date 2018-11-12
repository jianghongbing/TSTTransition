//
//  TSTInteractiveTransition.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSTTransition.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSTInteractiveTransition : UIPercentDrivenInteractiveTransition
- (instancetype)initWithViewController:(nonnull UIViewController *)viewController
                        triggerPercent:(CGFloat)triggerPercent
   enabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition
                            completion:(__nullable
                                        TSTInteractiveDismissTransitionCompletion)completion;
@end

NS_ASSUME_NONNULL_END
