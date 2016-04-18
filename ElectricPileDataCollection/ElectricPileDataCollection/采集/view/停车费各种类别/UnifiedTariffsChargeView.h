//
//  UnifiedTariffsChargeView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnifiedTariffsChargeView : UIView

@property (weak, nonatomic) IBOutlet UIButton *yuanEveryHoursBtn;
@property (weak, nonatomic) IBOutlet UITextField *yuanEveryHoursTF;
@property (weak, nonatomic) IBOutlet UIButton *yuanEveryTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *yuanEveryTimeTF;
@property (weak, nonatomic) IBOutlet UIButton *yuanEveryDayBtn;
@property (weak, nonatomic) IBOutlet UITextField *yuanEveryDayTF;
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@end
