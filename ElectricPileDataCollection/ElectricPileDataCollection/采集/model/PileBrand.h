//
//  PileBrand.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PileBrand : NSObject

@property(nonatomic,assign)NSInteger Id;

@property (nonatomic, copy) NSString *name;

+ (instancetype)pileBrandWithDict:(NSDictionary *)dict;

+ (NSArray *)sharePileBrandFromPileBrandPlist;


@end
