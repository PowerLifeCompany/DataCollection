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

+ (instancetype)pileBrandWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

- (NSString *)description{
    return [self otherDescription];
}

@end
