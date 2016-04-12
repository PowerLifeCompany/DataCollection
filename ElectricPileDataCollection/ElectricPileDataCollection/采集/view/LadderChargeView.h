//
//  LadderChargeView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LadderChargeView : UIView


@property (weak, nonatomic) IBOutlet UITextField *firstTF;

@property (weak, nonatomic) IBOutlet UITextField *secondTF;

@property (weak, nonatomic) IBOutlet UITextField *increasingTF;

@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@end
