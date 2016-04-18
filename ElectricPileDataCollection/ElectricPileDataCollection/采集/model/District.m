//
//  District.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "District.h"
#import "NSObject+KVC.h"
#import "NSObject+Description.h"

@implementation District

+ (instancetype)districtWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

- (NSArray *)areaArray{
    if(_areaArray==nil){
        _areaArray=[[NSMutableArray alloc]init];
    }
    return _areaArray;
}

- (NSString *)description{
    return [self otherDescription];
}

@end
