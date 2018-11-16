//
//  TSTAnimator.h
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TSTAnimator : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithDuration:(NSTimeInterval)duration
                           alpha:(CGFloat)alpha
                      widthScale:(CGFloat)widthScale
                     heightScale:(CGFloat)heightScale
                     shadowColor:(UIColor *)shadowColor
                   shadowOpacity:(CGFloat)shadowOpacity
                    shadowOffset:(CGSize)shadowOffset
                    shadowRadius:(CGFloat)shadowRadius
                      shadowPath:(UIBezierPath *)shadowPath;
@end

NS_ASSUME_NONNULL_END
