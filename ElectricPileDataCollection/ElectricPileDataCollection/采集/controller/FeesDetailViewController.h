//
//  FeesDetailViewController.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"
#import "ParkingChargeStandard.h"

@interface FeesDetailViewController : RootViewController

@property(nonatomic,strong)ParkingChargeStandard * pcs;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end
