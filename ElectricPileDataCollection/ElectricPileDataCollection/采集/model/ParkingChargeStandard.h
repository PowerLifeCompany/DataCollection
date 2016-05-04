//
//  ParkingChargeStandard.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  停车收费标准
 */
@interface ParkingChargeStandard : NSObject

/**
 *  唯一ID
 */
@property(nonatomic,assign) NSInteger Id;
/**
 *  收费标准名称
 */
@property (nonatomic, copy) NSString *parkingName;

/**
 *  小区ID值
 */
@property (nonatomic, assign) NSInteger villageId;

/**
 *  收费标准图片 存储路径
 */
@property (nonatomic, copy) NSString *chargeImagePath;

/**
 *  收费标准图片 url
 */
@property (nonatomic, copy) NSString *imageUrl0;


/**
 *  收费标准图片 描述
 */
@property (nonatomic, copy) NSString *comment10;

/**
 *  停车费类型
 */
@property (nonatomic, copy) NSString *tariffType;

/**
 *  统一资费
 */
@property (nonatomic, copy) NSString *tariffTypeUnify;

/**
 *  分时资费
 */
@property (nonatomic, copy) NSString *tariffTypeSplit;

/**
 *  阶梯资费
 */
@property (nonatomic, copy) NSString *tariffTypeLadder;

/**
 *  开放时间 工作日
 */
@property (nonatomic, copy) NSString *openIntervalWork;

/**
 *  开放时间  周末
 */
@property (nonatomic, copy) NSString *openIntervalNowork;

/**
 *  开放时间 特殊说明
 */
@property (nonatomic, copy) NSString *openComment;

/**
 *  收费标准 特殊说明
 */
@property (nonatomic, copy) NSString *comment;


@end
