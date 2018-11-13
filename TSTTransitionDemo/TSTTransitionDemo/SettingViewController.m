//
//  SettingViewController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/13.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "SettingViewController.h"
#import "TSTTransition.h"
@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *usedTSTAnimatorAsDefaultCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *durationCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *enabledInteractiveDismissTransitionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *triggerPercentCell;
@property (nonatomic, strong) UISwitch *usedTSTAnimatorAsDefaultSwitch;
@property (nonatomic, strong) UISlider *durationSlider;
@property (nonatomic, strong) UISwitch *enabledInteractiveDismissTransitionSwitch;
@property (nonatomic, strong) UISlider *triggerPercentSlider;
@end

@implementation SettingViewController
#pragma mark helper
- (UISwitch *)switchWithValue:(BOOL)isOn {
    UISwitch *aSwitch = [[UISwitch alloc] init];
    aSwitch.on = isOn;
    [aSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    return aSwitch;
}

- (void)switchValueChanged:(UISwitch *)aSwitch {
    BOOL isOn = aSwitch.isOn;
    if (aSwitch == self.usedTSTAnimatorAsDefaultSwitch) {
        self.transition.usedTSTAnimatorAsDefault = isOn;
//        [TSTTransitionGlobalSetting golbalSetting].usedTSTAnimatorAsDefault = isOn;
    }else if (aSwitch == self.enabledInteractiveDismissTransitionSwitch) {
//        [TSTTransitionGlobalSetting golbalSetting].enabledInteractiveDismissTransition = isOn;
        self.transition.enabledInteractiveDismissTransition = isOn;
    }
}


- (UISlider *)sliderWithValue:(float)value minValue:(float)minValue maxValue:(float)maxValue {
    UISlider *slider = [[UISlider alloc] init];
    slider.value = value;
    slider.minimumValue = minValue;
    slider.maximumValue = maxValue;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    return slider;
}

- (void)sliderValueChanged:(UISlider *)slider {
    float value = slider.value;
    if (slider == self.durationSlider) {
//        [TSTTransitionGlobalSetting golbalSetting].duration = value;
        self.transition.duration = value;
        [self updateDurationCell];
    }else if(slider == self.triggerPercentSlider) {
//        [TSTTransitionGlobalSetting golbalSetting].triggerPercent = value;
        self.transition.triggerPercent = value;
        [self updateTriggerPercentCell];
    }
}

#pragma makr life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCells];
}

- (void)setupCells {
//    TSTTransitionGlobalSetting *setting = [TSTTransitionGlobalSetting golbalSetting];
    self.usedTSTAnimatorAsDefaultSwitch = [self switchWithValue:self.transition.isUsedTSTAnimatorAsDefault];
    self.durationSlider = [self sliderWithValue:self.transition.duration minValue:0 maxValue:1.0];
    self.enabledInteractiveDismissTransitionSwitch = [self switchWithValue:self.transition.enabledInteractiveDismissTransition];
    self.triggerPercentSlider = [self sliderWithValue:self.transition.triggerPercent minValue:0 maxValue:1.0];
    
    self.usedTSTAnimatorAsDefaultCell.accessoryView = self.usedTSTAnimatorAsDefaultSwitch;
    self.durationCell.accessoryView = self.durationSlider;
    self.enabledInteractiveDismissTransitionCell.accessoryView = self.enabledInteractiveDismissTransitionSwitch;
    self.triggerPercentCell.accessoryView = self.triggerPercentSlider;
    [self updateDurationCell];
    [self updateTriggerPercentCell];
}


- (void)updateDurationCell {
    self.durationCell.textLabel.text = [NSString stringWithFormat:@"duration:%.2fs", self.durationSlider.value];
}

- (void)updateTriggerPercentCell {
    self.triggerPercentCell.textLabel.text = [NSString stringWithFormat:@"triggerPercent:%ld%%", (NSInteger)(self.triggerPercentSlider.value * 100)];
}



@end
