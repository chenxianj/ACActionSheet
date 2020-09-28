//
//  XJActionSheetConfig.m
//  ACActionSheetDemo
//
//  Created by chenxianjing on 2020/9/8.
//  Copyright © 2020 章子云. All rights reserved.
//

#import "XJActionSheetConfig.h"

#define ACRGB(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation XJActionSheetConfig

-(id)init {
    if (self = [super init]) {
        
        // 开源库原先的style
//        self.shadowBgColor = ACRGB(20, 20, 20);
//        self.shadowViewAlpha = ACDarkShadowViewAlpha;
//        self.containerBgColor = ACRGB(240, 240, 240);
//        self.cornerRadius = ACViewCornerRadius;
//        self.titleLabelTextColor = ACRGB(125, 125, 125);
//        self.titleFont = [UIFont systemFontOfSize:13.0f];
//        self.titleLabelBgColor = [UIColor whiteColor];
//        self.titleViewHeight = ACTitleHeight;
//        self.buttonNormalBgColor = [UIColor whiteColor];
//        self.buttonTextFont = ACButtonTitleFont;
//        self.buttonTextColor = [UIColor blackColor];
//        self.buttonHeight = ACButtonHeight;
//        self.separatorLineColor = ACRGB(230, 230, 230);
//        self.separatorLineHeight = 0.5;
//        self.separatorViewHeight = ACSeparatorViewHeight;
//        self.separatorViewBgColor = ACRGB(240, 240, 240);
//        self.cancelButtonHeight = ACButtonHeight;
//        self.cancelBtnNormalBgColor = [UIColor whiteColor];
//        self.cancelButtonTextFont = ACButtonTitleFont;
//        self.cancelButtonTextColor = [UIColor blackColor];
//        self.showAnimationDuration = ACShowAnimateDuration;
//        self.hideAnimationDuration = ACHideAnimateDuration;
        
        // style for ours
        self.shadowBgColor = ACRGB(0, 0, 0, 0.6);
        self.shadowViewAlpha = 0.6;
        self.containerBgColor = ACRGB(42, 43, 44, 1);
        self.cornerRadius = 7;
        self.titleLabelTextColor = ACRGB(255, 255, 255, 0.4);
        self.titleFont = [UIFont systemFontOfSize: 12.0f];
        self.titleLabelBgColor = ACRGB(42, 43, 44, 1);
        self.titleViewHeight = 40;
        self.buttonNormalBgColor = ACRGB(42, 43, 44, 1);
        self.buttonHighlightBgColor = ACRGB(0, 0, 0, 0.1);
        self.buttonTextColor = ACRGB(225, 74, 73, 1);
        self.buttonTextFont = [UIFont systemFontOfSize:15.0f];
        self.buttonHeight = 57;
        self.separatorLineHeight = 0.5;
        self.separatorLineColor = ACRGB(255, 255, 255, 0.05);
        self.separatorViewBgColor = ACRGB(37, 38, 39, 1);
        self.separatorViewHeight = 8;
        self.cancelButtonHeight = 57;
        self.cancelButtonTextColor = ACRGB(255, 255, 255, 1);
        self.cancelBtnNormalBgColor = ACRGB(42, 43, 44, 1);
        self.cancelButtonTextFont = [UIFont systemFontOfSize:15.0f];
        self.cancelBtnHighlightBgColor = ACRGB(0, 0, 0, 0.1);
        self.showAnimationDuration = ACShowAnimateDuration;
        self.hideAnimationDuration = ACHideAnimateDuration;
    }
    return self;
}

@end
