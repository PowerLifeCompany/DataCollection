//
//  CustomAlertView.m
//  customAlertView
//
//  Created by huchunyuan on 15/12/2.
//  Copyright © 2015年 huchunyuan. All rights reserved.
//

#import "CustomAlertView.h"

/** 二进制码转RGB */
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BUTTON_WIDTH 250
#define BUTTON_HEIGHT 44

@interface CustomAlertView()

//@property(nonatomic,strong)NSArray * array;

@property(nonatomic,strong)NSMutableArray * btnArray;

@property(nonatomic,weak)UIButton * cancleBtn;

@end

@implementation CustomAlertView

+ (instancetype)customAlertViewWithArray:(NSArray *)array{
    return [[self alloc]initWithArray:array];
}

- (instancetype)initWithArray:(NSArray *)array{
    CGRect frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    if(self=[super initWithFrame:frame]){
        self.backgroundColor=[UIColor colorWithRed:0.92f green:0.91f blue:0.92f alpha:0.7f];
        self.hidden = YES;
        self.alpha = 0.0;
        self.dataArray=array;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [super setFrame:frame];
}

- (void)setDataArray:(NSArray *)dataArray{
    if(dataArray==_dataArray){
        return;
    }
    
    _btnArray=nil;
    for (UIView * view in self.subviews) {
        for (UIView * nextView in view.subviews) {
            [nextView removeFromSuperview];
        }
        [view removeFromSuperview];
    }

    UIView * alertView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,BUTTON_WIDTH, dataArray.count * BUTTON_HEIGHT)];
    [self addSubview:alertView];
    alertView.center=self.center;
    
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 5;
    
    for (int i = 0; i < dataArray.count;i++) {
        // 因为有一条分割线 所以最下面是一层view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, i*BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        view.backgroundColor = [UIColor whiteColor];
        
        // 创建button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT);
        [button setTitle:dataArray[i] forState:(UIControlStateNormal)];
        
        [button addTarget:self action:@selector(alertAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];
        
        if ([dataArray[i] isEqualToString:@"取消"]) {
            button.tintColor = [UIColor whiteColor];
//            view.backgroundColor = UIColorFromRGBValue(0x82DFB0);
            view.backgroundColor=[UIColor colorWithRed:0.31f green:0.78f blue:0.97f alpha:1.00f];
            self.cancleBtn=button;
        }else{
            button.tintColor = UIColorFromRGBValue(0x333333);
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, BUTTON_HEIGHT-1, BUTTON_WIDTH, 1)];
            lineView.backgroundColor = UIColorFromRGBValue(0xefefef);
            [view addSubview:lineView];
        }
        [self.btnArray addObject:button];
        [alertView addSubview:view];
    }
}

- (NSMutableArray *)btnArray{
    if(_btnArray==nil){
        _btnArray=[NSMutableArray new];
    }
    return _btnArray;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hiddenAlertView];
}

- (void)showAlertView{
    [self.superview bringSubviewToFront:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.hidden = NO;
    }];
}

- (void)hiddenAlertView{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)setCancleBtnBackgroundColor:(UIColor *)bgColor{
    self.cancleBtn.backgroundColor=bgColor;
}

#pragma mark - 点击事件
- (void)alertAction:(UIButton *)button{
    NSInteger index=[self.btnArray indexOfObject:button];
    [_delegate customAlertView:self andIndex:index];
}
@end
