//
//  PileBrand.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileBrand.h"
#import "NSObject+KVC.h"
#import "NSObject+Description.h"

@implementation PileBrand

static NSArray * sharePileBrandArray;

+ (instancetype)pileBrandWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

+ (NSArray *)sharePileBrandFromPileBrandPlist{
    if (sharePileBrandArray==nil) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pile_brand.plist" ofType:nil]];
            NSMutableArray * dataArray=[NSMutableArray new];
            for (NSDictionary * dict in array) {
                [dataArray addObject:[PileBrand pileBrandWithDict:dict]];
            }
            sharePileBrandArray = dataArray;
        });
    }
    return sharePileBrandArray;
}

- (NSString *)description{
    return [self otherDescription];
}

@end
