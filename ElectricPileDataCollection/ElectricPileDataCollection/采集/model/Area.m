//
//  Area.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "Area.h"
#import "NSObject+KVC.h"
#import "NSObject+Description.h"

@implementation Area

+ (instancetype)areaWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

- (NSString *)description{
    return [self otherDescription];
}

@end


