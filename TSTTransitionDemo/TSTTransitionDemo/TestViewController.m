//
//  TestViewController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/13.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "TestViewController.h"
#import "UIViewController+Utils.h"
#import "TSTTransitionHeader.h"
@interface TestViewController ()<TSTInteractiveDismissTransitionDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self randomBackgroundColor];
    self.navigationItem.title = [self randomTitle];
    [self addButtons];
    self.tst_dismissInteractiveTransition.delegate = self;
}

- (NSString *)randomTitle {
    NSArray *titles = @[@"A", @"B", @"C", @"D", @"E"];
    NSInteger randomIndex = arc4random_uniform(100) % titles.count;
    return titles[randomIndex];
}



- (void)addButtons {
    UIButton *pushButton = [self createAButtonWithTitle:@"Present" selector:@selector(pushViewController:)];
    UIButton *dismissButton = [self createAButtonWithTitle:@"Dismiss" selector:@selector(dismiss:)];
    
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
    TestViewController *viewController = [TestViewController new];
    [self tst_presentViewController:viewController animated:YES completion:^{
        NSLog(@"present a view controller");
    }];
}

- (void)dismiss:(UIButton *)button {
    [self tst_dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss a view controller");
    }];
}

#pragma mark TSTInteractiveDismissTransitionDelegate
- (void)dismissInteractiveTransition:(TSTDismissInteractiveTransition *)dismissInteractiveTransition didFinish:(BOOL)finished {
    NSLog(@"finished:%d", finished);
}

- (void)dismissInteractiveTransition:(TSTDismissInteractiveTransition *)dismissInteractiveTransition updateAnimationProgress:(float)animationProgress {
    NSLog(@"progress:%f", animationProgress);
}

@end
