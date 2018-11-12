//
//  UIViewController+TecentSportTransition.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "UIViewController+TSTTransition.h"
#import <objc/runtime.h>
@implementation UIViewController (TSTTransition)
- (TSTTransition *)tst_transition {
    TSTTransition *transition = objc_getAssociatedObject(self, _cmd);
    if (transition == nil) {
        transition = [[TSTTransition alloc] init];
        objc_setAssociatedObject(self, _cmd, transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return transition;
}


- (void)tst_presentViewController:(UIViewController *)viewController
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion {
    [self tst_presentViewController:viewController embedInANavigationController:YES animated:animated completion:completion];
}


- (void)tst_presentViewController:(UIViewController *)viewController
     embedInANavigationController:(BOOL)embedInANavigationController
                         animated:(BOOL)animated
                       completion:(void (^)(void))completion {
    BOOL embedIn = embedInANavigationController;
    if ([viewController isKindOfClass:[UINavigationController class]] || viewController.navigationController) {
        embedIn = NO;
    }
    
    if (embedIn) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.transitioningDelegate = self.tst_transition;
        [self presentViewController:navigationController animated:animated completion:completion];
    }else {
        viewController.transitioningDelegate = self.tst_transition;
        [self presentViewController:viewController animated:animated completion:completion];
    }
}

- (void)tst_dismissViewControllerAnimated:(BOOL)animated
                               completion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:completion];
}
@end
