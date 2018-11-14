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

- (TSTDismissInteractiveTransition *)tst_dismissInteractiveTransition {
    TSTDismissInteractiveTransition *dismissInteractiveTransition = objc_getAssociatedObject(self, _cmd) ?: objc_getAssociatedObject(self.navigationController, _cmd);
    NSLog(@"dismiss:%@", dismissInteractiveTransition);
    return objc_getAssociatedObject(self, _cmd) ?: objc_getAssociatedObject(self.navigationController, _cmd);
}

- (void)setTst_dismissInteractiveTransition:(TSTDismissInteractiveTransition *)dismissInteractiveTransition {
    objc_setAssociatedObject(self, @selector(tst_dismissInteractiveTransition), dismissInteractiveTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    UIViewController *presented = viewController;    
    if (![presented isKindOfClass:[UINavigationController class]]) {
        if (embedInANavigationController) {
            presented = [[UINavigationController alloc] initWithRootViewController:presented];
        }
    }
    presented.transitioningDelegate = self.tst_transition;
    [self presentViewController:presented animated:animated completion:completion];
}

- (void)tst_dismissViewControllerAnimated:(BOOL)animated
                               completion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:completion];
}
@end
