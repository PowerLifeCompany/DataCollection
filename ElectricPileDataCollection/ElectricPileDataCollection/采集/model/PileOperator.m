//
//  PileOperator.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileOperator.h"
#import "NSObject+KVC.h"

@implementation PileOperator

+ (instancetype)pileOperatorWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

static NSArray * sharePileOperatorArray;

+ (NSArray *)sharePileOperatorFromPileOperatorPlist{
    if (sharePileOperatorArray==nil) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pile_operators.plist" ofType:nil]];
            NSMutableArray * dataArray=[NSMutableArray new];
            for (NSDictionary * dict in array) {
                [dataArray addObject:[PileOperator pileOperatorWithDict:dict]];
            }
            sharePileOperatorArray = dataArray;
        });
    }
    return sharePileOperatorArray;
}
@end
