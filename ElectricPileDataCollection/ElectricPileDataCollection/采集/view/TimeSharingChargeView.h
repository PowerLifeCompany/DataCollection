//
//  TimeSharingChargeView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSharingChargeView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *timeBeginTF;
@property (weak, nonatomic) IBOutlet UITextField *timeEndTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *everyTimeTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *makeSureBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end
