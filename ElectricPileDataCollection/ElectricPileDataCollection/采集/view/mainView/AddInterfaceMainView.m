//
//  AddInterfaceMainView.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddInterfaceMainView.h"
#import "CustomAlertView.h"
#import "CustomPickView.h"
#import "InterfaceType.h"
#import "CustomCellOne.h"


@interface  AddInterfaceMainView()<CustomAlertViewDelegate, CustomPickViewDelegate>

@property (weak, nonatomic) CustomPickView * interfaceTypePickView;

@end

@implementation AddInterfaceMainView

- (void)awakeFromNib{
    
    /**
     *  设置代理
     */
    self.delegate = self;
    self.serviceFeeTextField.delegate = self;
    self.busyStartTextField.delegate = self;
    self.busyEndTextField.delegate = self;
    self.idleStartTextField.delegate = self;
    self.idleEndTextField.delegate = self;
    self.interfaceTextView.delegate = self;
    self.interfaceDetailTextView.delegate = self;
    self.instructionsTextView.delegate = self;
    
    /**
     *  设置tag值
     */
    self.interfaceImageView.tag = 6000;
    self.interfaceDetailsImageView.tag = 6001;
    self.takeCharingTypeYesImageView.tag = 7000;
    self.takeCharingTypeNoImageView.tag = 7001;
    self.payOpetator.tag = 8000;
    self.payWechat.tag = 8001;
    self.payAli.tag = 8002;
    self.payCreditCard.tag = 8003;
    
    /**
     *  添加手势
     */
    
    // 单选
    UITapGestureRecognizer *takeChargingTypeYesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTakeChargingTypeTap:)];
    self.takeCharingTypeYesImageView.userInteractionEnabled = YES;
    [self.takeCharingTypeYesImageView addGestureRecognizer:takeChargingTypeYesTap];
    
    UITapGestureRecognizer *takeChargingTypeNoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTakeChargingTypeTap:)];
    self.takeCharingTypeNoImageView.userInteractionEnabled = YES;
    [self.takeCharingTypeNoImageView addGestureRecognizer:takeChargingTypeNoTap];
    
    // 多选
    UITapGestureRecognizer *payOperatorTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayTypeTap:)];
    self.payOpetator.userInteractionEnabled = YES;
    [self.payOpetator addGestureRecognizer:payOperatorTap];
    
    UITapGestureRecognizer *payWechatTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayTypeTap:)];
    self.payWechat.userInteractionEnabled = YES;
    [self.payWechat addGestureRecognizer:payWechatTap];
    
    UITapGestureRecognizer *payAliTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayTypeTap:)];
    self.payAli.userInteractionEnabled = YES;
    [self.payAli addGestureRecognizer:payAliTap];
    
    UITapGestureRecognizer *payCreditCardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayTypeTap:)];
    self.payCreditCard.userInteractionEnabled = YES;
    [self.payCreditCard addGestureRecognizer:payCreditCardTap];
    
    // 选择图片
    UITapGestureRecognizer *interfaceIVTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
    self.interfaceImageView.userInteractionEnabled = YES;
    [self.interfaceImageView addGestureRecognizer:interfaceIVTap];
    
    UITapGestureRecognizer *interfaceDetailsIVTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
    self.interfaceDetailsImageView.userInteractionEnabled = YES;
    [self.interfaceDetailsImageView addGestureRecognizer:interfaceDetailsIVTap];
    
}

- (void)chooseAlbubmOrPhotoGraphWithTap:(UITapGestureRecognizer *)tap
{
    self.currentImageView = (UIImageView *)tap.view;
    CustomAlertView * alertView = [CustomAlertView customAlertViewWithArray:@[@"相机",@"相册",@"取消"]];
    alertView.delegate = self;
    [self.superview.superview addSubview:alertView];
    [alertView showAlertView];
}

- (void)chooseTakeChargingTypeTap:(UITapGestureRecognizer *)tap
{
    [self.mainViewDelegate chooseTakeChargingType:self andTap:tap];
}

- (void)choosePayTypeTap:(UITapGestureRecognizer *)tap
{
    [self.mainViewDelegate choosePayType:self payTypeTap:tap];
}

#pragma mark - choose album or camera
- (void)customAlertView:(CustomAlertView *)alertView andIndex:(NSInteger)index{
    [alertView hiddenAlertView];
    if(index == 2){
        return;
    }else{
        [self.mainViewDelegate chooseAlbubmOrPhotoGraphWithIndex:index];
    }
}

- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    customPickView.hidden=YES;
    NSInteger num = [selectedArray[0] integerValue];
    if(self.currentPickViewIndex == 0){
        NSObject * obj = dataArray[num];
        self.currentLabel.text = [obj valueForKey:@"name"];
    }
}

- (void)customPickViewCancleTouch:(CustomPickView *)customPickView{
    customPickView.hidden=YES;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing:YES];
    
    if (indexPath.row == 0) {
        self.interfaceTypePickView.hidden = NO;
        self.currentPickViewIndex = 0;
        self.currentLabel = self.interfaceTypeLabel;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
        return 50;
    }else if (indexPath.row == 6 || indexPath.row == 7){
        return 120;
    }else{
        return 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - Lazy loading
- (CustomPickView *)interfaceTypePickView{
    if(_interfaceTypePickView == nil){
        CustomPickView * pickView = [CustomPickView customPickViewWithDataArray:[InterfaceType shareInterfaceTypeFromPileBrandPlist] andComponent:1 andIsDependPre:NO andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.delegate = self;
        pickView.titleKey = @"name";
        [self.superview.superview addSubview:pickView];
        _interfaceTypePickView = pickView;
    }
    return _interfaceTypePickView;
}

#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:FINAL_PLEASE_ENTER_DESCRIPTION_TEST]){
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""] && ![textView isEqual:self.instructionsTextView]){
        textView.text = FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - testField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

@end
