//
//  TabbarController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/13.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "TabBarController.h"
#import "TestViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}


- (void)setupViewControllers {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[TestViewController new]];
    navigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
    
    UIViewController *testViewController = [TestViewController new];
    testViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    [self setViewControllers:@[navigationController, testViewController]];
}
@end
