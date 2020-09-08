//
//  ViewController.m
//  ACActionSheet
//
//  Created by Zhangziyun on 16/5/3.
//  Copyright © 2016年 章子云. All rights reserved.
//


#import "ViewController.h"
#import "ACActionSheet.h"
#import "UIAlertController+ACAlertView.h"

@interface ViewController () <UIActionSheetDelegate, ACActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/** 
 *  系统 - UIActionSheet demo
 */
- (IBAction)_showUIActionSheet:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"微信朋友圈" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"小视频" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    
    [actionSheet showInView:self.view];
}

/** 
 *  系统 - UIAlertController demo
 */
- (IBAction)_showUIAlertController:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存或删除数据" message:@"删除数据将不可恢复" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"UIAlertController - 取消");
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"UIAlertController - 删除");
    }];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"UIAlertController - 保存");
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


/**
 *   ACActionSheet type delegate demo
 */
- (IBAction)_showACActionSheetTypeDelegate:(UIButton *)sender {

    #define ACRGB(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
    
    XJActionSheetConfig *config = [[XJActionSheetConfig alloc] init];
    config.shadowBgColor = ACRGB(0, 0, 0, 0.6);
    config.containerBgColor = ACRGB(42, 43, 44, 1);
    config.cornerRadius = 7;
    config.titleLabelTextColor = ACRGB(255, 255, 255, 0.4);
    config.titleLabelBgColor = ACRGB(42, 43, 44, 1);
    config.titleViewHeight = 40;
    config.buttonNormalBgColor = ACRGB(42, 43, 44, 1);
    config.buttonHighlightBgColor = ACRGB(0, 0, 0, 0.1);
    config.buttonTextColor = ACRGB(225, 74, 73, 1);
    config.buttonHeight = 57;
    config.separatorLineColor = ACRGB(255, 255, 255, 0.05);
    config.separatorViewBgColor = ACRGB(37, 38, 39, 1);
    config.separatorViewHeight = 8;
    config.cancelButtonHeight = 57;
    config.cancelButtonTextColor = ACRGB(255, 255, 255, 1);
    config.cancelBtnNormalBgColor = ACRGB(42, 43, 44, 1);
    config.cancelBtnHighlightBgColor = ACRGB(0, 0, 0, 0.1);
    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    dict[@"保存"] = ACRGB(255, 255, 255, 0.4);
//    dict[@"修改"] = ACRGB(255, 255, 255, 0.4);
    
    NSMutableArray<XJAction *> *data = [[NSMutableArray alloc] init];
    XJAction *action1 = [[XJAction alloc] init];
    action1.title = @"保存";
    action1.titleColor = ACRGB(255, 255, 255, 0.4);
    [data addObject:action1];
    
    XJAction *action2 = [[XJAction alloc] init];
    action2.title = @"修改";
    action2.titleColor = ACRGB(255, 255, 255, 0.4);
    [data addObject:action1];
    
//    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:@"保存或删除数据" config:config delegate:self cancelButtonTitle:@"取消"];
    
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:@"保存或删除数据" actions:data config:config cancelButtonTitle:@"取消" actionSheetBlock:^(NSInteger buttonIndex, XJAction *action) {
        
    } actionCancelBlock:^{
         NSLog(@"click cancel");
    }];
    
//    [ACActionSheet alloc] initWith

    [actionSheet show];
}



/** 
 *   ACActionSheet type block demo 
 */
- (IBAction)_showACActionSheetTypeBlock:(UIButton *)sender {
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"小视频",@"拍照",@"从手机相册选择"] actionSheetBlock:^(NSInteger buttonIndex, XJAction *action) {
        NSLog(@"ACActionSheet block - %ld",buttonIndex);
    } actionCancelBlock:^{
        NSLog(@"click cancel");
    }];
    [actionSheet show];
}

- (IBAction)_showUIAlertControllerAction:(id)sender {
    
    [[UIAlertController alertControllerWithTitle:@"提示" message:@"保持或者删除数据" cancelButtonTitle:@"取消" confirmButtonTitle:@"确定" preferredStyle:UIAlertControllerStyleAlert alertViewBlock:^(NSInteger buttonIndex) {
        NSLog(@"UIAlertController 类目 - %@",@(buttonIndex));
    }] show] ;

}


- (IBAction)_showUIAlertControllerMoreButtonAction:(id)sender {

    [[UIAlertController alertControllerWithTitle:@"提示" message:@"保持或者删除数据" cancelButtonTitle:@"取消" confirmButtonTitle:@"确定" otherButtonTitles:@[@"按钮3",@"按钮4",@"按钮5",@"按钮6"] preferredStyle:UIAlertControllerStyleAlert alertViewBlock:^(NSInteger buttonIndex) {
        NSLog(@"UIAlertController 类目 - %@",@(buttonIndex));
    }] show] ;
    
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"UIActionSheet - %@ %ld",[actionSheet buttonTitleAtIndex:buttonIndex],buttonIndex);
}

#pragma mark - ACActionSheet delegate
- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ACActionSheet delegate - %ld",buttonIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
