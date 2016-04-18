//
//  UnifiedTariffsChargeView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "UnifiedTariffsChargeView.h"
#import "UIView+LayoutCornerRadius.h"

@implementation UnifiedTariffsChargeView

- (void)awakeFromNib{
    [self.makeSureBtn layoutCornerRadiusWithCornerRadius:5];
    [self.cancleBtn layoutCornerRadiusWithCornerRadius:5];
    [self setTextFeildWith:self.yuanEveryHoursTF];
    [self setTextFeildWith:self.yuanEveryTimeTF];
    [self setTextFeildWith:self.yuanEveryDayTF];
}

- (void)setTextFeildWith:(UITextField *)tf{
    tf.userInteractionEnabled=NO;
    tf.keyboardType=UIKeyboardTypeDecimalPad;
    tf.text=@"";
}

- (IBAction)chooseParkingCategory:(UIButton *)sender {
    self.yuanEveryHoursBtn.selected=NO;
    self.yuanEveryTimeBtn.selected=NO;
    self.yuanEveryDayBtn.selected=NO;
    sender.selected=YES;
    
    self.yuanEveryHoursTF.userInteractionEnabled=NO;
    self.yuanEveryTimeTF.userInteractionEnabled=NO;
    self.yuanEveryDayTF.userInteractionEnabled=NO;
    self.yuanEveryHoursTF.text=@"";
    self.yuanEveryTimeTF.text=@"";
    self.yuanEveryDayTF.text=@"";
    
    [self endEditing:YES];
    
    if(sender==self.yuanEveryDayBtn){
        self.yuanEveryDayTF.userInteractionEnabled=YES;
        [self.yuanEveryDayTF becomeFirstResponder];
    }else if (sender==self.yuanEveryHoursBtn){
        self.yuanEveryHoursTF.userInteractionEnabled=YES;
        [self.yuanEveryHoursTF becomeFirstResponder];
    }else if (sender==self.yuanEveryTimeBtn){
        self.yuanEveryTimeTF.userInteractionEnabled=YES;
        [self.yuanEveryTimeTF becomeFirstResponder];
    }
}

- (IBAction)cancleBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
