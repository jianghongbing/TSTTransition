//
//  TableViewController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/13.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "TableViewController.h"
#import "UIViewController+TSTTransition.h"
#import "TestViewController.h"
#import "SettingViewController.h"
#import "TabBarController.h"
#import "CustomPresentAnimator.h"
#import "CustomDismissAnimator.h"
#import "CustomPresentInteractiveTransition.h"
#import "TestAViewController.h"
#import "CustomPresentAnimator1.h"
@interface TableViewController()
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIViewController *willPersentViewController;
@property (nonatomic, strong) UILabel *tipsLabel;
@end
@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.dataSource = @[@"presentAViewController",
                        @"notEmbedInANavigationController",
                        @"presentANavigationController",
                        @"presentATabBarController",
                        @"customPresentAnimator",
                        @"customDismissAnimator",
                        @"customPresentInteractiveTransition"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tst_transition.presentAnimator = nil;
    self.tst_transition.dismissAnimator = nil;
    self.tst_transition.presentInteractiveTransition = nil;
    self.tst_transition.dismissInteractiveTransition = nil;
    [self hiddenTipsLabel];
}


#pragma mark
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"self.tstTransition:%@, interactiveTransition:%@", self.tst_transition, self.tst_transition.presentInteractiveTransition);

    if ([segue.destinationViewController isKindOfClass: [SettingViewController class]]) {
        [(SettingViewController *)segue.destinationViewController setTransition:self.tst_transition];
    }
}


#pragma mark UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSTTransitionCellId" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectorName = self.dataSource[indexPath.row];
    SEL selector = NSSelectorFromString(selectorName);
    [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenTipsLabel];
}

#pragma mark
- (void)presentAViewController {
    [self tst_presentViewController:[TestViewController new] animated:YES completion:nil];
}

- (void)notEmbedInANavigationController {
    [self tst_presentViewController:[TestViewController new] embedInANavigationController:NO animated:YES completion:nil];
}

- (void)presentANavigationController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[TestViewController new]];
    [self tst_presentViewController:navigationController animated:YES completion:nil];
}

- (void)presentATabBarController {
    [self tst_presentViewController:[TabBarController new] embedInANavigationController:NO animated:YES completion:nil];
}


- (void)customPresentAnimator {
    self.tst_transition.presentAnimator = [CustomPresentAnimator new];
    [self tst_presentViewController:[TestViewController new] embedInANavigationController:YES animated:YES completion:nil];
}

- (void)customDismissAnimator {
    self.tst_transition.dismissAnimator = [CustomDismissAnimator new];
    [self tst_presentViewController:[TestViewController new] embedInANavigationController:YES animated:YES completion:nil];
}


- (void)customPresentInteractiveTransition {
    NSLog(@"self.tstTransition:%@, interactiveTransition:%@", self.tst_transition, self.tst_transition.presentInteractiveTransition);
    
    self.willPersentViewController = [TestAViewController new];
    CustomPresentInteractiveTransition *presentInteractiveTransition = [[CustomPresentInteractiveTransition alloc] initWithViewController:self];
    [presentInteractiveTransition.panGestureRecognizer addTarget:self action:@selector(excuteCustomPresentInteractiveTransition:)];
    self.tst_transition.presentInteractiveTransition = presentInteractiveTransition;
    self.tst_transition.presentAnimator = [CustomPresentAnimator1 new];
    [self addTipsLabel];
}

- (void)addTipsLabel {
    if (self.tipsLabel == nil) {
        self.tipsLabel = [[UILabel alloc] init];
        self.tipsLabel.textColor = [UIColor whiteColor];
        self.tipsLabel.backgroundColor = [UIColor orangeColor];
        self.tipsLabel.alpha = 0.5;
        self.tipsLabel.frame = CGRectMake(100, 30, 100, 40);
        self.tipsLabel.text = @"pan to top";
        [self.view addSubview:self.tipsLabel];
    }
    self.tipsLabel.hidden = NO;
}

- (void)hiddenTipsLabel {
    self.tipsLabel.hidden = YES;
}


- (void)excuteCustomPresentInteractiveTransition:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (self.willPersentViewController == nil) return;
    UIGestureRecognizerState state = panGestureRecognizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            [self tst_presentViewController:self.willPersentViewController embedInANavigationController:YES animated:YES completion:nil];
        default:
            break;
    }
}


- (void)customDismissInteractiveTransition {
    
}
@end
