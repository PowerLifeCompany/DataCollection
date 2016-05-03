//
//  ChargeStandardViewController.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"
#import "PileVillageInfo.h"

@interface ChargeStandardViewController : RootViewController

@property (strong, nonatomic) ParkingChargeStandard * pcs;

@property (strong, nonatomic) PileVillageInfo *pileVillageInfo;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property (strong, nonatomic) NSMutableArray *pileVillageInfoArray;

@end
