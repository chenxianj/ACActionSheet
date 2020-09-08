//
//  XJAction.h
//  ACActionSheetDemo
//
//  Created by chenxianjing on 2020/9/8.
//  Copyright © 2020 章子云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XJAction : NSObject

@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSObject *tag;

@end

NS_ASSUME_NONNULL_END
