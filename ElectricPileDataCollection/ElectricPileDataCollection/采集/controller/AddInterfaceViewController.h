//
//  AddInterfaceViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"
#import "PileInterface.h"

@interface AddInterfaceViewController : RootViewController

@property (strong, nonatomic) PileInterface *interface;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end
