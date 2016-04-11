//
//  PileVillageInfo.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PileVillageBasicInfo.h"
#import "PileGroupInfo.h"
#import "Area.h"

/**
 *  对电桩小区内信息的描述，数据的总集合
 */
@interface PileVillageInfo : NSObject

@property(nonatomic,assign)NSInteger Id;
/**
 *  用户ID
 */
@property(nonatomic,assign)NSInteger userId;
/**
 *  省ID
 */
@property(nonatomic,assign)NSInteger provinceid;
/**
 *  市ID
 */
@property(nonatomic,assign)NSInteger cityid;
/**
 *  区ID
 */
@property(nonatomic,assign)NSInteger districtid;
/**
 *  片ID
 */
@property(nonatomic,assign)NSInteger areaid;
/**
 *  电桩小区基本信息
 */
@property(nonatomic,strong)PileVillageBasicInfo *pile_village;
/**
 *  电桩组信息
 */
@property(nonatomic,strong)NSArray<PileGroupInfo *> *sites;

@property(nonatomic,strong)Area * area;

+ (instancetype)sharedPileVillageInfo;

@end
