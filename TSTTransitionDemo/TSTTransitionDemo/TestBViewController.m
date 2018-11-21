//
//  TestBViewController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/19.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "TestBViewController.h"
#import "UIViewController+Utils.h"
#import "TSTTransitionHeader.h"
@interface TestBViewController()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic) BOOL failedMyGesture;
@property (nonatomic) BOOL failedTransitionGesture;
@property (nonatomic) BOOL recognizeSimultaneously;
@end
@implementation TestBViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self randomBackgroundColor];
    self.navigationItem.title = @"TestB";
    [self addViews];
    [self addPanGestureRecognizer];
    [self resetStatus];
    [self updateButtonTitles];
}

- (void)addViews {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Move Me";
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    [self.view addSubview:label];
    self.label = label;
    
    UIButton *button1 = [self createAButtonWithTitle:@"Recognize Simultaneously" selector:@selector(enabledGestureRecognizers)];
    
    UIButton *button2 = [self createAButtonWithTitle:@"Failed My Gesture" selector:@selector(failMyGesture)];
    
    UIButton *button3 = [self createAButtonWithTitle:@"Failed Transition Gesture" selector:@selector(failTransitionGesture)];
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:80].active = YES;
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100].active = YES;
    NSDictionary *views = NSDictionaryOfVariableBindings(label, button1, button2, button3);
    NSDictionary *metrics = @{@"margin": @20, @"labelHeight": @100};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(==labelHeight)]-(margin)-[button1]-(margin)-[button2]-(margin)-[button3]" options:NSLayoutFormatAlignAllCenterX metrics:metrics views:views];
    [NSLayoutConstraint activateConstraints:constraints];
    self.button1 = button1;
    self.button2 = button2;
    self.button3 = button3;
}

- (void)resetStatus {
    self.failedMyGesture = NO;
    self.failedTransitionGesture = NO;
    self.recognizeSimultaneously = YES;
}


- (void)enabledGestureRecognizers {
    [self resetStatus];
    [self updateButtonTitles];
}

- (void)failMyGesture {
//    [self.panGestureRecognizer requireGestureRecognizerToFail:self.tst_dismissInteractiveTransition.dismissInteractiveGestureRecognizer];
    self.failedMyGesture = YES;
    self.failedTransitionGesture = NO;
    self.recognizeSimultaneously = NO;
    [self updateButtonTitles];
}

- (void)failTransitionGesture {
//    [self.tst_dismissInteractiveTransition.dismissInteractiveGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
    self.failedTransitionGesture = YES;
    self.failedMyGesture = NO;
    self.recognizeSimultaneously = NO;
    [self updateButtonTitles];
}

- (void)updateButtonTitles {
    [self.button1 setTitle:[NSString stringWithFormat:@"Recognize Simultaneously:%@", self.recognizeSimultaneously ? @"YES" : @"NO"] forState:UIControlStateNormal];
    [self.button2 setTitle:[NSString stringWithFormat:@"Failed My Gesture:%@", self.failedMyGesture ? @"YES" : @"NO"] forState:UIControlStateNormal];
    [self.button3 setTitle:[NSString stringWithFormat:@"Failed Transition Gesture:%@", self.failedTransitionGesture ? @"YES" : @"NO"] forState:UIControlStateNormal];
}


- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    self.panGestureRecognizer = panGestureRecognizer;
}

- (void)didPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    CGAffineTransform transform = CGAffineTransformTranslate(self.label.transform, translation.x, translation.y);
    self.label.transform = transform;
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
}

#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer == self.tst_dismissInteractiveTransition.dismissInteractiveGestureRecognizer && self.recognizeSimultaneously) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer == self.tst_dismissInteractiveTransition.dismissInteractiveGestureRecognizer && self.failedMyGesture) {
        return YES;
    }
    return NO;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer == self.tst_dismissInteractiveTransition.dismissInteractiveGestureRecognizer && self.failedTransitionGesture) {
        return YES;
    }
    return NO;
}

@end
