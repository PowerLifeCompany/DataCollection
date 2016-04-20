//
//  PileInterface.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  电桩接口信息
 */
@interface PileInterface : NSObject

@property (nonatomic, assign) NSInteger Id;
/**
 *  电桩ID
 */
@property (nonatomic, assign) NSInteger pileId;
/**
 *  充电接口类型ID
 */
@property (nonatomic, assign) NSInteger pileResourceInterfaceId;
/**
 *  服务费
 */
@property (nonatomic, assign) double tariffService;
/**
 *  充电接口的个数
 */
@property (nonatomic, assign) NSInteger num;
/**
 *  重量
 */
@property (nonatomic, assign) NSInteger weight;
/**
 *  电桩是否自带充电线
 */
@property (nonatomic, assign) NSInteger hasChargeCable;
/**
 *  电压
 */
@property (nonatomic, assign) double voltage;
/**
 *  电流
 */
@property (nonatomic, assign) double current;
/**
 *  忙时充电钱数单价
 */
@property (nonatomic, assign) double tariffChargeBusy;
/**
 *  忙时时间区间
 */
@property (nonatomic, copy) NSString *tariffChargeBusyInterval;
/**
 *  闲时充电钱数单价
 */
@property (nonatomic, assign) double tariffChargeIdle;
/**
 *  闲时时间区间
 */
@property (nonatomic, copy) NSString *tariffChargeIdleInterval;
/**
 *  支付类型
 */
@property (nonatomic, copy) NSString *paymentType;
/**
 *  充电口图片描述
 */
@property (nonatomic, copy) NSString *comment8;
/**
 *  充电口图片
 */
@property (nonatomic, copy) NSString *imageUrl8;
/**
 *  充电口图片路径
 */
@property (nonatomic, copy) NSString *chargingMouthImagePath;
/**
 *  细节特写图片描述
 */
@property (nonatomic, copy) NSString *comment9;
/**
 *  细节特写图片
 */
@property (nonatomic, copy) NSString *imageUrl9;
/**
 *  细节特写图片路径
 */
@property (nonatomic, copy) NSString *detailImagePath;
/**
 *  接口特殊说明
 */
@property (nonatomic, copy) NSString *comment;

@end
