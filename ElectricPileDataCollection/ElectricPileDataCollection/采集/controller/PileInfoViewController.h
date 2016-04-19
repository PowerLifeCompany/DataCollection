//
//  PileInfoViewController.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PileGroupSite.h"
#import "PileGroupSpace.h"
#import "Pile.h"


@interface PileInfoViewController : UIViewController

@property (nonatomic, strong) PileGroupSite *pileGroupSite;

@property (nonatomic, strong) PileGroupSpace *pileGroupSpace;

@property (nonatomic, strong) NSArray<Pile *> *piles;


@end
