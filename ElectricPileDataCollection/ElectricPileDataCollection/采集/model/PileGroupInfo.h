//
//  PileGroupInfo.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PileGroupSite.h"
#import "PileGroupSpace.h"
#import "Pile.h"

/**
 *  电桩组的信息的描述-->site(接口数据中的变量名)
 */
@interface PileGroupInfo : NSObject

@property(nonatomic,assign)NSInteger Id;
/**
 *  电桩组的位置
 */
@property (nonatomic, strong) PileGroupSite *pile_site;
/**
 *  电桩组的停车位
 */
@property (nonatomic, strong) PileGroupSpace *pile_space;
/**
 *  电桩信息集合
 */
@property (nonatomic, strong) NSArray<Pile *> *piles;

@end
