//
//  ACActionSheet.m
//  ACActionSheetDemo
//
//  Created by Zhangziyun on 16/5/3.
//  Copyright © 2016年 章子云. All rights reserved.
//
//  GitHub:     https://github.com/GardenerYun
//  Email:      gardeneryun@foxmail.com
//  简书博客地址: http://www.jianshu.com/users/8489e70e237d/latest_articles
//  如有问题或建议请联系我，我会马上解决问题~ (ง •̀_•́)ง
//

#import "ACActionSheet.h"

#define ACScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ACScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ACActionSheet () {
    
    NSString *_cancelButtonTitle;
    NSString *_destructiveButtonTitle;
    NSArray *_otherButtonTitles;
    
    
    UIView *_buttonBackgroundView;
    UIView *_darkShadowView;
}


@property (nonatomic, copy) ACActionSheetBlock actionSheetBlock;
@property (nonatomic, copy) ACActionCancelBlock actionCancelBlock;
@end

@implementation ACActionSheet

// MARK: - init by delegate

- (instancetype)initWithTitle:(NSString *)title
                      actions:(NSArray<XJAction *> *)actions
                       config:(XJActionSheetConfig *)config
                     delegate:(id<ACActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle {
    self = [super init];
    if(self) {
        if (config == nil) {
            config = [[XJActionSheetConfig alloc] init];
        }
        _config = config;
        _actions = actions;
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = @"";
        
        NSMutableArray *args = [NSMutableArray array];
        if (_actions) {
            for (int32_t i = 0; i < _actions.count; i++) {
                XJAction *action = _actions[i];
                if (action) {
                    [args addObject:action.title];
                }
            }
        }
        _otherButtonTitles = [NSArray arrayWithArray:args];
        [self _initSubViews];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<ACActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {

    self = [super init];
    if(self) {
        XJActionSheetConfig *config = [[XJActionSheetConfig alloc] init];
        _config = config;
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *args = [NSMutableArray array];
        
        if(_destructiveButtonTitle.length) {
            [args addObject:_destructiveButtonTitle];
        }
        
        [args addObject:otherButtonTitles];
        
        if (otherButtonTitles) {
            va_list params;
            va_start(params, otherButtonTitles);
            id buttonTitle;
            while ((buttonTitle = va_arg(params, id))) {
                if (buttonTitle) {
                    [args addObject:buttonTitle];
                }
            }
            va_end(params);
        }
        _otherButtonTitles = [NSArray arrayWithArray:args];
        
        [self _initSubViews];
    }
    
    return self;
}

- (void)initDataWithDelegate:(NSString *)title
          config:(XJActionSheetConfig *)config
        delegate:(id<ACActionSheetDelegate>)delegate
cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
otherButtonTitles:(NSString *)otherButtonTitles,
... NS_REQUIRES_NIL_TERMINATION {
    
    if (config == nil) {
        config = [[XJActionSheetConfig alloc] init];
    }
    _config = config;
    _title = title;
    _delegate = delegate;
    _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
    _destructiveButtonTitle = destructiveButtonTitle;
    
    NSMutableArray *args = [NSMutableArray array];
    
    if(_destructiveButtonTitle.length) {
        [args addObject:_destructiveButtonTitle];
    }
    
    [args addObject:otherButtonTitles];
    
    if (otherButtonTitles) {
        va_list params;
        va_start(params, otherButtonTitles);
        id buttonTitle;
        while ((buttonTitle = va_arg(params, id))) {
            if (buttonTitle) {
                [args addObject:buttonTitle];
            }
        }
        va_end(params);
    }
    _otherButtonTitles = [NSArray arrayWithArray:args];
}

// MARK: - init by block

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(ACActionSheetBlock) actionSheetBlock
            actionCancelBlock: (ACActionCancelBlock) actionCancelBlock {
    
    self = [super init];
    if(self) {
        XJActionSheetConfig *config = [[XJActionSheetConfig alloc] init];
        [self initDataWithBlock:title config:config cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles actionSheetBlock:actionSheetBlock actionCancelBlock: actionCancelBlock];
        [self _initSubViews];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      actions:(NSArray<XJAction *> *)actions
                       config:(XJActionSheetConfig *)config
            cancelButtonTitle:(NSString *)cancelButtonTitle
             actionSheetBlock:(ACActionSheetBlock) actionSheetBlock
            actionCancelBlock: (ACActionCancelBlock) actionCancelBlock {
    
    self = [super init];
    if(self) {
        if (config == nil) {
            config = [[XJActionSheetConfig alloc] init];
        }
        _actions = actions;
        NSMutableArray *otherButtonTitles = [NSMutableArray array];
        if (_actions) {
            for (int32_t i = 0; i < _actions.count; i++) {
                XJAction *action = _actions[i];
                if (action) {
                    [otherButtonTitles addObject:action.title];
                }
            }
        }
        
        [self initDataWithBlock:title config:config cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:@"" otherButtonTitles:otherButtonTitles actionSheetBlock:actionSheetBlock actionCancelBlock:actionCancelBlock];
        [self _initSubViews];
    }
    
    return self;
    
}

- (void)initDataWithBlock:(NSString *)title
                   config: (XJActionSheetConfig *) config
        cancelButtonTitle:(NSString *)cancelButtonTitle
   destructiveButtonTitle:(NSString *)destructiveButtonTitle
        otherButtonTitles:(NSArray *)otherButtonTitles
         actionSheetBlock:(ACActionSheetBlock) actionSheetBlock
        actionCancelBlock:(ACActionCancelBlock) actionCancelBlock{
    if (config == nil) {
        config = [[XJActionSheetConfig alloc] init];
    }
    _config = config;
    _title = title;
    _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
    _destructiveButtonTitle = destructiveButtonTitle;
    
    NSMutableArray *titleArray = [NSMutableArray array];
    if (_destructiveButtonTitle.length) {
        [titleArray addObject:_destructiveButtonTitle];
    }
    [titleArray addObjectsFromArray:otherButtonTitles];
    _otherButtonTitles = [NSArray arrayWithArray:titleArray];
    self.actionSheetBlock = actionSheetBlock;
    self.actionCancelBlock = actionCancelBlock;
}


- (void)_initSubViews {

    self.frame = CGRectMake(0, 0, ACScreenWidth, ACScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    _darkShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ACScreenWidth, ACScreenHeight)];
    _darkShadowView.backgroundColor = _config.shadowBgColor;
    _darkShadowView.alpha = 0.0f;
    [self addSubview:_darkShadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissView:)];
    [_darkShadowView addGestureRecognizer:tap];
    
    
    _buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _buttonBackgroundView.backgroundColor = _config.containerBgColor;
    [self addSubview:_buttonBackgroundView];
    _buttonBackgroundView.layer.cornerRadius = _config.cornerRadius;
    _buttonBackgroundView.clipsToBounds = YES;
    
    float buttonHeight = _config.buttonHeight;
    float titleViewHeight = _config.titleViewHeight;
    
    if (self.title.length) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ACScreenWidth, titleViewHeight)];
        titleLabel.text = _title;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = _config.titleLabelTextColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = _config.titleFont;
        titleLabel.backgroundColor = _config.titleLabelBgColor;
        [_buttonBackgroundView addSubview:titleLabel];
    }
    
    for (int i = 0; i < _otherButtonTitles.count; i++) {
        XJAction *action = _actions[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        NSString *text = _otherButtonTitles[i];
        [button setTitle:text forState:UIControlStateNormal];
        button.backgroundColor = _config.buttonNormalBgColor;
        button.titleLabel.font = _config.buttonTextFont;
        //优先从_actions中读取字体颜色
        if (_actions && _actions[i]) {
            [button setTitleColor: action.titleColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:_config.buttonTextColor forState:UIControlStateNormal];
        }
        
        if (i==0 && _destructiveButtonTitle.length && _config.destructiveButtonTextColor) {
            [button setTitleColor:_config.destructiveButtonTextColor forState:UIControlStateNormal];
        }
        //有设置按钮高亮背景色，则使用颜色背景
        if (_config.buttonHighlightBgColor) {
            [button addTarget:self action:@selector(_onButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(_onButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(_onButtonUpInside:) forControlEvents:UIControlEventTouchDragExit];
        } else {
            UIImage *image = [UIImage imageWithContentsOfFile:[[self _acBundle] pathForResource:@"actionSheetHighLighted@2x" ofType:@"png"]];
            [button setBackgroundImage:image forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonY = buttonHeight * i + (_title.length > 0 ? titleViewHeight : 0);
        button.frame = CGRectMake(0, buttonY, ACScreenWidth, buttonHeight);
        [_buttonBackgroundView addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = _config.separatorLineColor;
        line.frame = CGRectMake(0, buttonY, ACScreenWidth, _config.separatorLineHeight);
        [_buttonBackgroundView addSubview:line];
    }
    
    CGFloat separatorViewY = buttonHeight * _otherButtonTitles.count + (_title.length > 0 ? titleViewHeight : 0);
    
    // 分割view
    float separatorViewHeight = _config.separatorViewHeight;
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, separatorViewY, ACScreenWidth, separatorViewHeight)];
    separatorView.backgroundColor = _config.separatorViewBgColor;
    [_buttonBackgroundView addSubview:separatorView];
    
    CGFloat safeAreaHeight = 0.0f;
    
    if (@available(iOS 11.0, *)) {
        safeAreaHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }
    float cancelButtonHeight = _config.cancelButtonHeight;
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, separatorViewY + separatorViewHeight, ACScreenWidth, cancelButtonHeight + safeAreaHeight);
    
    cancelButton.tag = _otherButtonTitles.count;
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.backgroundColor = _config.cancelBtnNormalBgColor;
    cancelButton.titleLabel.font = _config.cancelButtonTextFont;
    [cancelButton setTitleColor: _config.cancelButtonTextColor forState:UIControlStateNormal];
    //有设置按钮高亮背景色，则使用颜色背景
    if (_config.cancelBtnHighlightBgColor) {
        [cancelButton addTarget:self action:@selector(_onButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [cancelButton addTarget:self action:@selector(_onButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton addTarget:self action:@selector(_onButtonUpInside:) forControlEvents:UIControlEventTouchDragExit];
    } else {
        UIImage *image = [UIImage imageWithContentsOfFile:[[self _acBundle] pathForResource:@"actionSheetHighLighted@2x" ofType:@"png"]];
        [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    
    [cancelButton addTarget:self action:@selector(_didClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonBackgroundView addSubview:cancelButton];
    
    [cancelButton setTitleEdgeInsets:UIEdgeInsetsMake(-safeAreaHeight, 0, 0, 0)];
    
    CGFloat height = buttonHeight * _otherButtonTitles.count + (_title.length > 0 ? titleViewHeight : 0) + separatorViewHeight + cancelButton.frame.size.height;
    
    _buttonBackgroundView.frame = CGRectMake(0, ACScreenHeight, ACScreenWidth, height);
    
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self showInWindow:window];
}

- (void)showInWindow:(UIWindow *)window {
    [window addSubview:self];
    
    self.hidden = NO;
    
    [UIView animateWithDuration:_config.showAnimationDuration animations:^{
        self->_darkShadowView.alpha = self->_config.shadowViewAlpha;
        self->_buttonBackgroundView.transform = CGAffineTransformMakeTranslation(0, -self->_buttonBackgroundView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - Private methods
- (void)_onButtonTouchDown:(UIButton *)button {
    if (_config.buttonHighlightBgColor) {
        button.backgroundColor = _config.buttonHighlightBgColor;
    }
}

- (void)_onButtonUpInside:(UIButton *)button {
    if (_config.buttonNormalBgColor) {
        button.backgroundColor = _config.buttonNormalBgColor;
    }
}

- (void)_didClickButton:(UIButton *)button {
    int index = (int) button.tag;
    XJAction *action = nil;
    if (_actions && index >= 0 && index < _actions.count) {
        action = _actions[index];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex:action:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:button.tag action:action];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(button.tag, action);
    }
    
    [self _hide];
}

- (void)_didClickCancelButton: (UIButton *)button {
    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickCancelButton:)]) {
        [_delegate actionSheet:self didClickCancelButton:button.tag];
    }
    
    if (self.actionCancelBlock) {
        self.actionCancelBlock();
    }
    [self _hide];
}

- (void)_dismissView:(UITapGestureRecognizer *)tap {

    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickCancelButton:)]) {
        [_delegate actionSheet:self didClickCancelButton:_otherButtonTitles.count];
    }
    
    if (self.actionCancelBlock) {
        self.actionCancelBlock();
    }
    [self _hide];
}

- (void)_hide {
    
    [UIView animateWithDuration:_config.hideAnimationDuration animations:^{
        _darkShadowView.alpha = 0;
        _buttonBackgroundView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}


- (NSBundle *)_acBundle {
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[ACActionSheet class]] pathForResource:@"ACActionSheet" ofType:@"bundle"]];
    
    return bundle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
