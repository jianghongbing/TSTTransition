//
//  CustomPresentInteractiveTransition.h
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/14.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CustomPresentInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nullable, nonatomic, strong, readonly) UIPanGestureRecognizer *panGestureRecognizer;
- (instancetype)initWithViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
