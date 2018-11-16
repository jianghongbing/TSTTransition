//
//  SettingViewController.m
//  TSTTransitionDemo
//
//  Created by pantosoft on 2018/11/13.
//  Copyright © 2018 jianghongbing. All rights reserved.
//

#import "SettingViewController.h"
//#import "TSTTransition.h"
#import "TSTTransitionGlobalSetting.h"
@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *usedTSTAnimatorAsDefaultCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *durationCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *enabledInteractiveDismissTransitionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *triggerPercentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *alphaCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *widthScaleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *heightScaleCell;

@property (nonatomic, strong) UISwitch *usedTSTAnimatorAsDefaultSwitch;
@property (nonatomic, strong) UISlider *durationSlider;
@property (nonatomic, strong) UISwitch *enabledInteractiveDismissTransitionSwitch;
@property (nonatomic, strong) UISlider *triggerPercentSlider;
@property (nonatomic, strong) UISlider *alphaSlider;
@property (nonatomic, strong) UISlider *widthScaleSlider;
@property (nonatomic, strong) UISlider *heightScaleSlider;
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
        [TSTTransitionGlobalSetting globalSetting].usedTSTAnimatorAsDefault = isOn;
    }else if (aSwitch == self.enabledInteractiveDismissTransitionSwitch) {
        [TSTTransitionGlobalSetting globalSetting].enabledInteractiveDismissTransition = isOn;
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
        [TSTTransitionGlobalSetting globalSetting].duration = value;
//        self.transition.duration = value;
        [self updateDurationCell];
    }else if(slider == self.triggerPercentSlider) {
        [TSTTransitionGlobalSetting globalSetting].triggerPercent = value;
//        self.transition.triggerPercent = value;
        [self updateTriggerPercentCell];
    }else if(slider == self.alphaSlider) {
        [TSTTransitionGlobalSetting globalSetting].alpha = value;
        [self updateAlphaCell];
    }else if (slider == self.widthScaleSlider) {
        [TSTTransitionGlobalSetting globalSetting].widthScale = value;
        [self updateWidthScaleCell];
    }else if (slider == self.heightScaleSlider) {
        [TSTTransitionGlobalSetting globalSetting].heightScale = value;
        [self updateHeightScaleCell];
    }
}

#pragma makr life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCells];
}

- (void)setupCells {
    TSTTransitionGlobalSetting *setting = [TSTTransitionGlobalSetting globalSetting];
//    self.usedTSTAnimatorAsDefaultSwitch = [self switchWithValue:self.transition.isUsedTSTAnimatorAsDefault];
//    self.durationSlider = [self sliderWithValue:self.transition.duration minValue:0 maxValue:1.0];
//    self.enabledInteractiveDismissTransitionSwitch = [self switchWithValue:self.transition.enabledInteractiveDismissTransition];
//    self.triggerPercentSlider = [self sliderWithValue:self.transition.triggerPercent minValue:0 maxValue:1.0];
//    self.alphaSlider = [self sliderWithValue:self.transition.alpha minValue:0 maxValue:1.0];
//    self.widthScaleSlider = [self sliderWithValue:self.transition.widthScale minValue:0.5 maxValue:1.5];
//    self.heightScaleSlider = [self sliderWithValue:self.transition.heightScale minValue:0.5 maxValue:1.5];
    self.usedTSTAnimatorAsDefaultSwitch = [self switchWithValue:setting.isUsedTSTAnimatorAsDefault];
    self.durationSlider = [self sliderWithValue:setting.duration minValue:0 maxValue:1.0];
    self.enabledInteractiveDismissTransitionSwitch = [self switchWithValue:setting.enabledInteractiveDismissTransition];
    self.triggerPercentSlider = [self sliderWithValue:setting.triggerPercent minValue:0 maxValue:1.0];
    self.alphaSlider = [self sliderWithValue:setting.alpha minValue:0 maxValue:1.0];
    self.widthScaleSlider = [self sliderWithValue:setting.widthScale minValue:0.5 maxValue:1.5];
    self.heightScaleSlider = [self sliderWithValue:setting.heightScale minValue:0.5 maxValue:1.5];
    
    self.usedTSTAnimatorAsDefaultCell.accessoryView = self.usedTSTAnimatorAsDefaultSwitch;
    self.durationCell.accessoryView = self.durationSlider;
    self.enabledInteractiveDismissTransitionCell.accessoryView = self.enabledInteractiveDismissTransitionSwitch;
    self.triggerPercentCell.accessoryView = self.triggerPercentSlider;
    self.alphaCell.accessoryView = self.alphaSlider;
    self.widthScaleCell.accessoryView = self.widthScaleSlider;
    self.heightScaleCell.accessoryView = self.heightScaleSlider;
    [self updateDurationCell];
    [self updateTriggerPercentCell];
}


- (void)updateDurationCell {
    self.durationCell.textLabel.text = [NSString stringWithFormat:@"duration:%.2fs", self.durationSlider.value];
}

- (void)updateTriggerPercentCell {
    self.triggerPercentCell.textLabel.text = [NSString stringWithFormat:@"triggerPercent:%ld%%", (NSInteger)(self.triggerPercentSlider.value * 100)];
}

- (void)updateAlphaCell {
    self.alphaCell.textLabel.text = [NSString stringWithFormat:@"alpha:%.2f", self.alphaSlider.value];
}

- (void)updateWidthScaleCell {
    self.widthScaleCell.textLabel.text = [NSString stringWithFormat:@"widthScale:%.2f", self.widthScaleSlider.value];
}

- (void)updateHeightScaleCell {
    self.heightScaleCell.textLabel.text = [NSString stringWithFormat:@"heightScale:%.2f", self.heightScaleSlider.value];
}


@end
