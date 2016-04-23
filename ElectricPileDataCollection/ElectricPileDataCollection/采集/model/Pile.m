//
//  Pile.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "Pile.h"
#import "NSObject+Description.h"

@implementation Pile

+ (NSDictionary *)objectClassInArray{
    return @{@"interfaces" : [PileInterface class]};
}

static Pile * sharedInfo;

+ (instancetype)sharedPileInfo{
    if(sharedInfo == nil){
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            sharedInfo = [[Pile alloc]init];
        });
    }
    return sharedInfo;
}

+ (void)setSharedPileInfo:(Pile *)sharedPileInfo{
    sharedInfo = sharedPileInfo;
}

- (NSMutableArray<PileInterface *> *)interfaces{
    if(_interfaces == nil){
        _interfaces = [[NSMutableArray alloc]init];
    }
    return _interfaces;
}

- (NSString *)description
{
    return [self otherDescription];
}

@end
