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
            sharedInfo.provinceid=0;
            sharedInfo.cityid=0;
            sharedInfo.districtid=0;
        });
    }
    return sharedInfo;
}

+ (void)setSharedPileVillageInfo:(PileVillageInfo *)sharedPileVillageInfo{
    sharedInfo=sharedPileVillageInfo;
}

- (PileVillageBasicInfo *)pile_village{
    if(_pile_village==nil){
        _pile_village=[[PileVillageBasicInfo alloc]init];
    }
    return _pile_village;
}

- (NSMutableArray<ParkingChargeStandard *> *)parkings{
    if(_parkings==nil){
        _parkings=[[NSMutableArray alloc]init];
    }
    return _parkings;
}

- (NSMutableArray<PileGroupInfo *> *)sites{
    if(_sites==nil){
        _sites=[[NSMutableArray alloc]init];
    }
    return _sites;
}

- (NSString *)description
{
    return [self otherDescription];
}

@end
