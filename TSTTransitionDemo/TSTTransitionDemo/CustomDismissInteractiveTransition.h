//
//  CustomDismissInteractiveTransition.h
//  
//
//  Created by pantosoft on 2018/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomDismissInteractiveTransition : UIPercentDrivenInteractiveTransition
- (void)setPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;
@end

NS_ASSUME_NONNULL_END
