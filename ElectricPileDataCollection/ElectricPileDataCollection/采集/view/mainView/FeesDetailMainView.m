//
//  FeesDetailMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "FeesDetailMainView.h"
#import "UIView+LayoutCornerRadius.h"
#import "UIButton+RefreshLocation.h"
#import "CustomAlertView.h"
#import "CustomPickView.h"
#import "UIView+Frame.h"

@interface FeesDetailMainView()<CustomAlertViewDelegate>


@end

@implementation FeesDetailMainView

- (void)awakeFromNib{
    //设置button按钮样式
    [self setButtonWithBtn:self.unifiedTariffsBtn];
    [self setButtonWithBtn:self.timeSharingBtn];
    [self setButtonWithBtn:self.ladderChargesBtn];
    
    //设置textView样式
    [self setTextViewWithTextView:self.feesDetailCommentTV];
    [self setTextViewWithTextView:self.feesDetailTextView];
    
    //设置textField加代理事件
    [self setTextFieldWithTextField:self.feesDetailNameTF];
    [self setTextFieldWithTextField:self.workDayBeginTF];
    [self setTextFieldWithTextField:self.workDayEndTF];
    [self setTextFieldWithTextField:self.weekendBeginTF];
    [self setTextFieldWithTextField:self.weekendEndTF];
    [self setTextFieldWithTextField:self.openTimeCommentTF];
    
    self.feesDetailImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
    [self.feesDetailImageView addGestureRecognizer:tgr];
    
    self.delegate=self;
}

- (void)chooseAlbubmOrPhotoGraphWithTgr:(UITapGestureRecognizer *)tgr{
    CustomAlertView * alertView=[CustomAlertView customAlertViewWithArray:@[@"相机",@"相册",@"取消"]];
    alertView.delegate=self;
    [self.superview.superview addSubview:alertView];
    [alertView showAlertView];
}

#pragma mark - 选择相册或者相机
- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    customPickView.hidden=YES;
    //NSInteger num = [selectedArray[0] integerValue];
    //NSLog(@"%@",dataArray[num]);
}

- (void)customPickViewCancleTouch:(CustomPickView *)customPickView{
    customPickView.hidden=YES;
}

- (void)customAlertView:(CustomAlertView *)alertView andIndex:(NSInteger)index{
    [alertView hiddenAlertView];
    if(index==2){
        return;
    }else{
        [self.mainViewDelegate chooseAlbubmOrPhotoGraphWithIndex:index];
    }
}

#pragma mark - tableView协议代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 60;
    }
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TextView协议代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:FINAL_PLEASE_ENTER_DESCRIPTION_TEST]){
        textView.text=@"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text=FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
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

#pragma mark - testField协议代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

#pragma mark - 私有方法
- (void)setButtonWithBtn:(UIButton *)btn{
    [btn setImage:[[UIImage imageNamed:@"select_no.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:@"select_yes.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    [btn setImage:[[UIImage imageNamed:@"select_yes.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [btn setTintColor:TAB_COLOR];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
}

- (void)setTextFieldWithTextField:(UITextField *)tf{
    tf.returnKeyType=UIReturnKeyDone;
    tf.delegate=self;
}

- (void)setTextViewWithTextView:(UITextView *)tv{
    tv.layer.borderColor = [[UIColor blackColor]CGColor];
    tv.layer.borderWidth = 0.5;
    [tv layoutCornerRadiusWithCornerRadius:5];
    tv.returnKeyType = UIReturnKeyDone;
    tv.delegate = self;
}

#pragma mark - 系统协议代理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
