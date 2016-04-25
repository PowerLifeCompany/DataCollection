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

@property (strong, nonatomic) NSArray<Pile *> *piles;

@property (strong, nonatomic) PileInfo *addPile;

@end
