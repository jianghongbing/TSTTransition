//
//  SettingViewController.h
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/13.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TSTTransition;
@interface SettingViewController : UITableViewController
@property (nonatomic, strong)TSTTransition *transition;
@end

NS_ASSUME_NONNULL_END
