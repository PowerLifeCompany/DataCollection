//
//  CustomAlertView.h
//  customAlertView
//
//  Created by huchunyuan on 15/12/2.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CustomAlertView;

@protocol CustomAlertViewDelegate <NSObject>

@optional
- (void)customAlertView:(CustomAlertView *)alertView  andIndex:(NSInteger)index;

@end

@interface CustomAlertView : UIView

@property(nonatomic,strong)NSArray * dataArray;

@property (assign, nonatomic)id<CustomAlertViewDelegate>delegate;

+ (instancetype)customAlertViewWithArray:(NSArray *)array;

- (void)showAlertView;
- (void)hiddenAlertView;

- (void)setCancleBtnBackgroundColor:(UIColor *)bgColor;

@end
