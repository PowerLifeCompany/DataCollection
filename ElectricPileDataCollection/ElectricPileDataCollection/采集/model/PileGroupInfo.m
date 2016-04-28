//
//  PileGroupInfo.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileGroupInfo.h"
#import "NSObject+Description.h"

@implementation PileGroupInfo

static PileGroupInfo * sharedGroupInfo;

+ (instancetype)sharedPileGroupInfo{
    if(sharedGroupInfo == nil){
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            sharedGroupInfo = [[PileGroupInfo alloc]init];
        });
    }
    return sharedGroupInfo;
}

+ (void)setSharedPileGroupInfo:(PileGroupInfo *)sharedPileGroupInfo{
    sharedPileGroupInfo = sharedPileGroupInfo;
}

- (PileGroupSite *)pile_site{
    if(_pile_site == nil){
       _pile_site = [[PileGroupSite alloc]init];
    }
    return _pile_site;
}

- (PileGroupSpace *)pile_space{
    if(_pile_space == nil){
        _pile_space = [[PileGroupSpace alloc]init];
    }
    return _pile_space;
}

- (NSMutableArray<Pile *> *)piles{
    if(_piles == nil){
        _piles = [[NSMutableArray alloc]init];
    }
    return _piles;
}

- (NSString *)description
{
    return [self otherDescription];
}

@end
