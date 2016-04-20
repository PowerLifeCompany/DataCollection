//
//  InterfaceType.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/20.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "InterfaceType.h"
#import "NSObject+KVC.h"
#import "NSObject+Description.h"

@implementation InterfaceType

static NSArray * shareInterfaceTypeArray;

+ (instancetype)interfaceTypeWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

+ (NSArray *)shareInterfaceTypeFromPileBrandPlist{
    if (shareInterfaceTypeArray == nil) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"charging_mouth_type.plist" ofType:nil]];
            NSMutableArray * dataArray=[NSMutableArray new];
            for (NSDictionary * dict in array) {
                [dataArray addObject:[InterfaceType interfaceTypeWithDict:dict]];
            }
            shareInterfaceTypeArray = dataArray;
        });
    }
    return shareInterfaceTypeArray;
}

- (NSString *)description{
    return [self otherDescription];
}

@end
