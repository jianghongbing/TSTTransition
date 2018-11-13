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
@interface TableViewController()
@property (nonatomic, strong) NSArray *dataSource;
@end
@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.dataSource = @[@"presentAViewController", @"notEmbedInANavigationController", @"presentANavigationController", @"presentATabBarController"];
}
#pragma mark
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *selectorName = self.dataSource[indexPath.row];
    SEL selector = NSSelectorFromString(selectorName);
    [self performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];
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


- (void)customPresntAnimator {
    
}

- (void)customDismissAnimator {
    
}


- (void)customPresentInteractiveTransition {
    
}

- (void)customDismissInteractiveTransition {
    
}
@end
