//
//  CollPileViewController.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PileVillageInfo.h"
#import "RootViewController.h"

@interface CollPileViewController : RootViewController

@property(nonatomic,strong)PileVillageInfo * pileVillageInfo;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end
