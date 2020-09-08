//
//  XJActionSheetConfig.m
//  ACActionSheetDemo
//
//  Created by chenxianjing on 2020/9/8.
//  Copyright © 2020 章子云. All rights reserved.
//

#import "XJActionSheetConfig.h"

@implementation XJActionSheetConfig

-(id)init {
    if (self = [super init]) {
        self.shadowBgColor = ACRGB(20, 20, 20);
        self.shadowViewAlpha = ACDarkShadowViewAlpha;
        self.containerBgColor = ACRGB(240, 240, 240);
        self.cornerRadius = ACViewCornerRadius;
        self.titleLabelTextColor = ACRGB(125, 125, 125);
        self.titleFont = [UIFont systemFontOfSize:13.0f];
        self.titleLabelBgColor = [UIColor whiteColor];
        self.titleViewHeight = ACTitleHeight;
        self.buttonNormalBgColor = [UIColor whiteColor];
        self.buttonTextFont = ACButtonTitleFont;
        self.buttonTextColor = [UIColor blackColor];
        self.buttonHeight = ACButtonHeight;
        self.separatorLineColor = ACRGB(230, 230, 230);
        self.separatorLineHeight = 0.5;
        self.separatorViewHeight = ACSeparatorViewHeight;
        self.separatorViewBgColor = ACRGB(240, 240, 240);
        self.cancelButtonHeight = ACButtonHeight;
        self.cancelBtnNormalBgColor = [UIColor whiteColor];
        self.cancelButtonTextFont = ACButtonTitleFont;
        self.cancelButtonTextColor = [UIColor blackColor];
        self.showAnimationDuration = ACShowAnimateDuration;
        self.hideAnimationDuration = ACHideAnimateDuration;
    }
    return self;
}

@end
