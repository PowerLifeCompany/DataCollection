//
//  AddPileViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/23.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"
#import "PileInfo.h"

@interface AddPileViewController : RootViewController

@property (strong, nonatomic) Pile *addPile;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *interfaceArray;

@end
