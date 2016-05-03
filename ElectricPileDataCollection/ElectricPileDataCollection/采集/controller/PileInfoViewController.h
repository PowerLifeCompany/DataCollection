//
//  PileInfoViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"
#import "Pile.h"
#import "PileGroupInfo.h"
#import "ParkingChargeStandard.h"

@interface PileInfoViewController : RootViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray <PileGroupInfo *> *pileGroupInfoArray;

@property (nonatomic, strong) NSMutableArray <ParkingChargeStandard *> *pileChargeStandardArray;

@end
