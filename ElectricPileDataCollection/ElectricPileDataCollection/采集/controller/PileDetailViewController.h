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
#import "PileGroupInfo.h"

@class PileDetailViewController;

@interface PileDetailViewController : RootViewController

/**
 *  电桩组信息
 */
@property (strong, nonatomic) PileGroupInfo *pileGroupInfo;

/**
 *  电桩详情数组
 */
@property (strong, nonatomic) NSMutableArray * dataArray;

/**
 *  接口数组
 */
@property (strong, nonatomic) NSMutableArray *addPileArray;

/**
 *  地理位置
 */
@property (copy, nonatomic) NSString *location;

@end
