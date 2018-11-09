//
//  UIViewController+TecentSportTransition.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSTTransition.h"
NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (TSTTransition)
@property (nonatomic, strong, readonly) TSTTransition *tst_transition;

/**
 present a view controller

 @param viewController a view controller will be presented
 @param animated animated or not
 @param completion present complete handler
 */
- (void)tst_presentViewController:(UIViewController *)viewController
                         animated:(BOOL)animated
                       completion:(void(^ __nullable)(void))completion;


/**
 present a view controller

 @param viewController a view controller will be presneted
 @param embedInANavigationController view controller embed in a navigation controller,this parameter of "tst_presentViewController:animated:completion:" value is YES
 @param animated animated or not
 @param completion present complete handler
 */
- (void)tst_presentViewController:(UIViewController *)viewController
     embedInANavigationController:(BOOL)embedInANavigationController
                         animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;


/**
 dismiss a view controller

 @param animated animated or not
 @param completion dismiss complete handler
 */
- (void)tst_dismissViewControllerAnimated:(BOOL)animated
                               completion:(void(^ __nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
