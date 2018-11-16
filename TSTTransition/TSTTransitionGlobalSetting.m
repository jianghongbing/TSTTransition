//
//  TSTTransitionGlobalSetting.m
//  TecentSportTransition
//
//  Created by pantosoft on 2018/11/8.
//  Copyright © 2018年 jianghongbing. All rights reserved.
//

#import "TSTTransitionGlobalSetting.h"
@implementation TSTTransitionGlobalSetting

+ (instancetype)globalSetting {
    static dispatch_once_t onceToken;
    static TSTTransitionGlobalSetting *globalSetting;
    dispatch_once(&onceToken, ^{
        globalSetting = [[TSTTransitionGlobalSetting alloc] init];
    });
    return globalSetting;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _usedTSTAnimatorAsDefault = YES;
    _duration = 0.25;
    _enabledInteractiveDismissTransition = YES;
    _triggerPercent = 0.3;
    _alpha = 0.9;
    _widthScale = 1.0;
    _heightScale = 0.9;
}
@end
