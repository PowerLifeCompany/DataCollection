//
//  PileVillageInfo.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileVillageInfo.h"
#import "NSObject+Description.h"


@implementation PileVillageInfo

static PileVillageInfo * sharedInfo;

+ (instancetype)sharedPileVillageInfo{
    if(sharedInfo==nil){
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            sharedInfo=[[PileVillageInfo alloc]init];
            sharedInfo.provinceid=1;
            sharedInfo.cityid=1;
            sharedInfo.districtid=1;
        });
    }
    return sharedInfo;
}

- (NSString *)description
{
    return [self otherDescription];
}

@end
