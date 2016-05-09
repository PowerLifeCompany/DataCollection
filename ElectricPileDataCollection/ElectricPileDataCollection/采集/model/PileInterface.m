//
//  PileInterface.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInterface.h"

@implementation PileInterface

- (NSMutableArray *)paymentTypeArray{
    if(_paymentTypeArray == nil){
        _paymentTypeArray = [[NSMutableArray alloc]init];
    }
    return _paymentTypeArray;
}

@end
