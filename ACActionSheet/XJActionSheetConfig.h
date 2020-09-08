//
//  XJActionSheetConfig.h
//  ACActionSheetDemo
//
//  Created by chenxianjing on 2020/9/8.
//  Copyright © 2020 章子云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ACRGB(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define ACButtonTitleFont     [UIFont systemFontOfSize:17.0f]

#define ACSeparatorViewHeight 7.0f
#define ACButtonHeight  55.0f
#define ACTitleHeight 66.0f
#define ACViewCornerRadius 10.0f
#define ACDarkShadowViewAlpha 0.35f

#define ACShowAnimateDuration 0.3f
#define ACHideAnimateDuration 0.2f

@interface XJActionSheetConfig : NSObject

@property (nonatomic, copy) UIColor *shadowBgColor;             // 上方阴影效果
@property (nonatomic, assign) float shadowViewAlpha;
@property (nonatomic, copy) UIColor *containerBgColor;          // 按钮区域背景色
@property (nonatomic, assign) float cornerRadius;

@property (nonatomic, copy) UIColor *titleLabelBgColor;
@property (nonatomic, copy) UIColor *titleLabelTextColor;
@property (nonatomic, copy) UIFont *titleFont;
@property (nonatomic, assign) float titleViewHeight;

@property (nonatomic, copy) UIColor *buttonNormalBgColor;
@property (nonatomic, copy) UIColor *buttonHighlightBgColor;
@property (nonatomic, copy) UIColor *buttonTextColor;
@property (nonatomic, copy) NSDictionary<NSString *, UIColor *> *buttonProperty;
@property (nonatomic, copy) UIColor *destructiveButtonTextColor;
@property (nonatomic, copy) UIFont *buttonTextFont;
@property (nonatomic, assign) float buttonHeight;

@property (nonatomic, copy) UIColor *separatorLineColor;        // item分割线颜色
@property (nonatomic, assign) float separatorLineHeight;
@property (nonatomic, copy) UIColor *separatorViewBgColor;      // 底部取消item与普通item的分割线颜色
@property (nonatomic, assign) float separatorViewHeight;

@property (nonatomic, copy) UIColor *cancelBtnNormalBgColor;
@property (nonatomic, copy) UIColor *cancelBtnHighlightBgColor;
@property (nonatomic, copy) UIFont *cancelButtonTextFont;
@property (nonatomic, copy) UIColor *cancelButtonTextColor;
@property (nonatomic, assign) float cancelButtonHeight;

@property (nonatomic, assign) float showAnimationDuration;
@property (nonatomic, assign) float hideAnimationDuration;

@end

