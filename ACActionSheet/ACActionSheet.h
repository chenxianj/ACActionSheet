//
//  ACActionSheet.h
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

#import <UIKit/UIKit.h>
#import "XJActionSheetConfig.h"
#import "XJAction.h"

@protocol ACActionSheetDelegate;

typedef void(^ACActionSheetBlock)(NSInteger buttonIndex, XJAction *action);
typedef void(^ACActionCancelBlock)();

@interface ACActionSheet : UIView

/**
 *  type delegate
 *
 *  @param title                  title            (可以为空)
 *  @param delegate               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<ACActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (instancetype)initWithTitle:(NSString *)title
                      actions:(NSArray<XJAction *> *)actions
                       config:(XJActionSheetConfig *)config
                     delegate:(id<ACActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle;

/**
 *  type block
 *
 *  @param title                  title            (可以为空)
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 *  @param actionSheetBlock       actionSheetBlock
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(ACActionSheetBlock) actionSheetBlock
            actionCancelBlock: (ACActionCancelBlock) actionCancelBlock;

- (instancetype)initWithTitle:(NSString *)title
                      actions:(NSArray<XJAction *> *)actions
                       config:(XJActionSheetConfig *)config
            cancelButtonTitle:(NSString *)cancelButtonTitle
             actionSheetBlock:(ACActionSheetBlock) actionSheetBlock
            actionCancelBlock: (ACActionCancelBlock) actionCancelBlock;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) id<ACActionSheetDelegate> delegate;
@property (nonatomic, copy) XJActionSheetConfig *config;
@property (nonatomic, copy) NSArray<XJAction *> *actions;

- (void)show;
- (void)showInWindow:(UIWindow *)window;

@end


#pragma mark - ACActionSheet delegate

@protocol ACActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex action:(XJAction *)action;

- (void)actionSheet:(ACActionSheet *)actionSheet didClickCancelButton:(NSInteger)buttonIndex;

@end
