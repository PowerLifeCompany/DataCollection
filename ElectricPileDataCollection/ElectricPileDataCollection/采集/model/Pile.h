//
//  Pile.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PileInterface.h"
#import "PileInfo.h"

/**
 *  电桩信息
 */
@interface Pile : NSObject

@property(nonatomic,assign)NSInteger Id;

/**
 *  电桩基本信息
 */
@property (nonatomic, strong) PileInfo *pile_pile;

/**
 *  电桩接口
 */
@property (nonatomic, strong) NSMutableArray<PileInterface *> *interfaces;

+ (instancetype)sharedPileInfo;

+ (void)setSharedPileInfo:(Pile *)sharedPileInfo;


@end
