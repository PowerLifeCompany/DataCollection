//
//  PileInfoDataViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PileGroupInfo.h"

@interface PileInfoDataViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) PileGroupInfo *PileGroupInfo;

@end
