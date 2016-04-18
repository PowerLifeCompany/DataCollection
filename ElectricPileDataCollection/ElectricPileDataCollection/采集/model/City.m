//
//  City.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "City.h"
#import "NSObject+KVC.h"
#import "NSObject+Description.h"

@implementation City

+ (instancetype)cityWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

- (NSArray *)districtArray{
    if(_districtArray==nil){
        _districtArray=[[NSMutableArray alloc]init];
    }
    return _districtArray;
}

- (NSString *)description{
    return [self otherDescription];
}

@end
