//
//  AddPileInterfaceViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPileViewController.h"

@interface AddPileInterfaceViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) AddPileViewController *pile;

@property (nonatomic, strong) NSArray<PileInterface *> *interfaces;

@end
