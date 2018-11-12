//
//  TestBViewController.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TestBViewController.h"
#import "UIViewController+Utils.h"
#import "UIViewController+TSTTransition.h"
#import "FirstNavigationController.h"
#import "SecondNavigationController.h"
@interface TestBViewController ()

@end

@implementation TestBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self randomBackgroundColor];
    self.navigationItem.title = @"B";
    [self addButtons];
    NSLog(@"tabbarController:%@, navigationController:%@, parentControlelr:%@", self.tabBarController, self.navigationController, self.parentViewController);
}

- (void)addButtons {
    UIButton *pushButton = [self createAButtonWithTitle:@"Push" selector:@selector(pushViewController:)];
    UIButton *dismissButton = [self createAButtonWithTitle:@"Dimiss" selector:@selector(dismiss:)];
    
    if (@available(iOS 9.0, *)) {
        [pushButton.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-10].active = YES;
        [pushButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
        [dismissButton.leadingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:10].active = YES;
        [dismissButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
        
    } else {
        [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-10].active = YES;
        [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
        
        [NSLayoutConstraint constraintWithItem:dismissButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:10].active = YES;
        [NSLayoutConstraint constraintWithItem:dismissButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    }
    
}


- (void)pushViewController:(UIButton *)button {
    TestBViewController *viewController = [TestBViewController new];
    viewController.useTSTTransition = self.useTSTTransition;
    if (self.useTSTTransition) {
        [self tst_presentViewController:viewController animated:YES completion:^{
            NSLog(@"present a view controller");
        }];
    }else {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)dismiss:(UIButton *)button {
    if (self.useTSTTransition) {
        [self tst_dismissViewControllerAnimated:YES completion:^{
            NSLog(@"dismiss a view controller");
        }];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
