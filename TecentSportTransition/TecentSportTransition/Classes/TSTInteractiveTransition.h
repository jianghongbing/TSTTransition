//
//  TSTInteractiveTransition.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TSTInteractiveTransition : UIPercentDrivenInteractiveTransition
- (instancetype)initWithNavigationController:(nonnull UINavigationController *)navigationController;
- (instancetype)initWithViewController:(nonnull UIViewController *)viewController
                        triggerPercent:(CGFloat)triggerPercent
   enabledInteractiveDismissTransition:(BOOL)enabledInteractiveDismissTransition;
@end

NS_ASSUME_NONNULL_END
