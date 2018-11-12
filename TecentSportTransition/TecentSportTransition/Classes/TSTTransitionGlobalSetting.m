//
//  TSTTransitionGlobalSetting.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTTransitionGlobalSetting.h"
@implementation TSTTransitionGlobalSetting

+ (instancetype)golbalSetting {
    static dispatch_once_t onceToken;
    static TSTTransitionGlobalSetting *golbalSetting;
    dispatch_once(&onceToken, ^{
        golbalSetting = [[TSTTransitionGlobalSetting alloc] init];
    });
    return golbalSetting;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _useTSTTAnimatorAsDefault = YES;
    _duration = 0.25;
    _enabledInteractiveDismissTransition = YES;
    _triggerPercent = 0.3;
}


@end
