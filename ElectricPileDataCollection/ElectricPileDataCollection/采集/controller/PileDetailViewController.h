//
//  PileDetailViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"
#import "PileGroupSite.h"
#import "PileGroupSpace.h"

@interface PileDetailViewController : RootViewController

/**
 *  位置模型
 */
@property (strong, nonatomic) PileGroupSite *pileLocation;

/**
 *  车位模型
 */
@property (strong, nonatomic) PileGroupSpace *pileParking;

/**
 *  数据数组
 */
@property(nonatomic,strong)NSMutableArray * dataArray;

@end
