//
//  TestAViewController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/14.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "TestAViewController.h"
#import "UIViewController+Utils.h"
@interface TestAViewController ()
@property (nonatomic, strong) UIPanGestureRecognizer *pangestureRecognizer;
@end

@implementation TestAViewController

- (UIPanGestureRecognizer *)pangestureRecognizer {
    if (_pangestureRecognizer == nil) {
        _pangestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
        [self.view addGestureRecognizer:_pangestureRecognizer];
    }
    return _pangestureRecognizer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"A";
    [self randomBackgroundColor];
//    [self addLabel];
   UIButton *button = [self createAButtonWithTitle:@"pan to bottom" selector:@selector(dismiss:)];
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
}
//- (void)addLabel {
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor blueColor];
//    label.text = @"pan to bottom";
//    label.font = [UIFont boldSystemFontOfSize:20];
//    label.translatesAutoresizingMaskIntoConstraints = false;
//    [self.view addSubview:label];
//    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
//    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
//}

- (void)dismiss:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissSelf:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIGestureRecognizerState state = panGestureRecognizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}
@end
