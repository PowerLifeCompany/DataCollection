//
//  LadderChargeView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "LadderChargeView.h"
#import "UIView+LayoutCornerRadius.h"

@implementation LadderChargeView

-(void)awakeFromNib{
    [self.makeSureBtn layoutCornerRadiusWithCornerRadius:5];
    [self.cancleBtn layoutCornerRadiusWithCornerRadius:5];
    
    
    [self setTextFeildWith:self.firstTF];
    [self setTextFeildWith:self.secondTF];
    [self setTextFeildWith:self.increasingTF];
}

- (void)setTextFeildWith:(UITextField *)tf{
    tf.keyboardType=UIKeyboardTypeDecimalPad;
    tf.text=@"";
}

- (IBAction)cancleBtnClick:(id)sender {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
