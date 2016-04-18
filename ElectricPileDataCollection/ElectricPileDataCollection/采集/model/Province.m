//
//  Province.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "Province.h"
#import "NSObject+KVC.h"
#import "NSObject+Description.h"

@implementation Province

+ (instancetype)provinceWithDict:(NSDictionary *)dict{
    return [self objectWithDict:dict];
}

- (NSArray *)cityArray{
    if(_cityArray==nil){
        _cityArray=[[NSMutableArray alloc]init];
    }
    return _cityArray;
}

- (NSString *)description{
    return [self otherDescription];
}

@end


