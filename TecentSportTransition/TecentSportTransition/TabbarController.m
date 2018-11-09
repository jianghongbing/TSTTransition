//
//  TabbarController.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TabbarController.h"
#import "FirstNavigationController.h"
#import "SecondNavigationController.h"
#import "TestAViewController.h"
@interface TabbarController ()

@end

@implementation TabbarController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupChildViewControllers];
    }
    return self;
}


- (void)setupChildViewControllers {
    UIViewController *oneViewController = [[TestAViewController alloc] init];
    oneViewController.title = @"First";
    UINavigationController *oneNavigationController = [[FirstNavigationController alloc] initWithRootViewController:oneViewController];
    oneNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    UIViewController *twoViewController = [[TestAViewController alloc] init];
    twoViewController.title = @"Second";
    UINavigationController *twoNavigationController = [[SecondNavigationController alloc] initWithRootViewController:twoViewController];
    twoNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
    [self setViewControllers:@[oneNavigationController, twoNavigationController]];
}



@end
