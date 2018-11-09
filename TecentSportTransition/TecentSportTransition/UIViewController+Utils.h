//
//  UIViewController+Utils.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Utils)
- (void)randomBackgroundColor;

- (UIButton *)createAButtonWithTitle:(NSString *)title selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
