//
//  TestViewAController.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TestAViewController.h"
#import "TestBViewController.h"
#import "UIViewController+Utils.h"
#import "TSTTransition.h"
#import "UIViewController+TSTTransition.h"
#import "FirstNavigationController.h"
#import "SecondNavigationController.h"
@interface TestAViewController ()
@property (nonatomic, strong) TSTTransition *custonTransition;
@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.custonTransition = [[TSTTransition alloc] init];
    [self randomBackgroundColor];
    [self addButton];
}

- (void)addButton {
    UIButton *pushButton = [self createAButtonWithTitle:@"Present" selector:@selector(pushAViewController:)];
    if (@available(iOS 9.0, *)) {
        [pushButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [pushButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    } else {
        [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    }
}


- (void)pushAViewController:(UIButton *)button {
    TestBViewController *viewController = [[TestBViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    if ([self.navigationController isKindOfClass:[FirstNavigationController class]]) {
        viewController.useTSTTransition = YES;
        [self tst_presentViewController:viewController animated:YES completion:^{
            NSLog(@"present a view controller");
        }];
    }else {
        viewController.useTSTTransition = NO;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
