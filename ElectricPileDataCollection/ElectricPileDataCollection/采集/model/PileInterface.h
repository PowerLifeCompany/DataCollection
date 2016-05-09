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


@property (assign, nonatomic) NSInteger Id;

/**
 *  电桩ID
 */
@property (assign, nonatomic) NSInteger pileId;

/**
 *  充电接口类型ID
 */
@property (assign, nonatomic) NSInteger pileResourceInterfaceId;

/**
 *  服务费
 */
@property (copy, nonatomic) NSString *tariffService;

/**
 *  充电接口的个数
 */
@property (copy, nonatomic) NSString *num;

/**
 *  重量
 */
@property (copy, nonatomic) NSString *weight;

/**
 *  电桩是否自带充电线
 */
@property (assign, nonatomic) NSInteger hasChargeCable;

/**
 *  电压
 */
@property (copy, nonatomic) NSString *voltage;

/**
 *  电流
 */
@property (copy, nonatomic) NSString *current;

/**
 *  忙时充电钱数单价
 */
@property (copy, nonatomic) NSString *tariffChargeBusy;

/**
 *  忙时时间区间
 */
@property (copy, nonatomic) NSString *tariffChargeBusyInterval;

/**
 *  闲时充电钱数单价
 */
@property (copy, nonatomic) NSString *tariffChargeIdle;

/**
 *  闲时时间区间
 */
@property (copy, nonatomic) NSString *tariffChargeIdleInterval;

/**
 *  支付类型
 */
@property (copy, nonatomic) NSString *paymentType;

/**
 *  是否选择运营商专用卡
 */
@property (assign, nonatomic) BOOL isChoosepayOpetator;

/**
 *  是否选择微信
 */
@property (assign, nonatomic) BOOL isChoosepayWechat;

/**
 *  是否选择支付宝
 */
@property (assign, nonatomic) BOOL isChoosepayAli;

/**
 *  是否选择信用卡
 */
@property (assign, nonatomic) BOOL isChoosepayCreditCard;


@property (assign, nonatomic) BOOL isSuccess;

/**
 *  支付类型数组
 */
@property (copy, nonatomic) NSMutableArray *paymentTypeArray;

/**
 *  充电口图片描述
 */
@property (copy, nonatomic) NSString *comment8;

/**
 *  充电口图片
 */
@property (copy, nonatomic) NSString *imageUrl8;

/**
 *  充电口图片路径
 */
@property (copy, nonatomic) NSString *chargingMouthImagePath;

/**
 *  细节特写图片描述
 */
@property (copy, nonatomic) NSString *comment9;

/**
 *  细节特写图片
 */
@property (copy, nonatomic) NSString *imageUrl9;

/**
 *  细节特写图片路径
 */
@property (copy, nonatomic) NSString *detailImagePath;

/**
 *  接口特殊说明
 */
@property (copy, nonatomic) NSString *comment;

@end
