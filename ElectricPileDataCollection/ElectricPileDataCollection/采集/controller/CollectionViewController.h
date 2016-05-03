//
//  CollectionViewController.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RootViewController.h"

@interface CollectionViewController : RootViewController

/**
 *  小区数据属性
 */

// id1(返回数据中的 pileVillageId 字段)
@property (copy, nonatomic) NSString *id1;

// 小区id(上传userId, areaId(片Id), name(小区名字), code(空字符)获取 )
@property (copy, nonatomic) NSString *villageId;

// 路口图片的url
@property (copy, nonatomic) NSString *imageUrl1;

// 路口图片描述
@property (copy, nonatomic) NSString *comment1;

// 小区入口图片的url
@property (copy, nonatomic) NSString *imageUrl2;

// 小区入口图片描述
@property (copy, nonatomic) NSString *comment2;


/**
 *  电桩组数据属性--位置
 */

// id2(返回数据中的 pileSiteId)
@property (copy, nonatomic) NSString *id2;

// 位置名字
@property (copy, nonatomic) NSString *siteName;

// 经度
@property (copy, nonatomic) NSString *x;

// 纬度
@property (copy, nonatomic) NSString *y;


/**
 *  电桩组数据属性--车位
 */

// id3(返回数据中的 spaceId)
@property (copy, nonatomic) NSString *id3;

// 停车场位置图片url
@property (copy, nonatomic) NSString *imageUrl3;

// 停车场位置图片描述
@property (copy, nonatomic) NSString *comment3;

// 电桩全景图片url
@property (copy, nonatomic) NSString *imageUrl4;

// 电桩全景图片描述
@property (copy, nonatomic) NSString *comment4;

// 空位图片描述url
@property (copy, nonatomic) NSString *imageUrl5;

// 空位图片描述
@property (copy, nonatomic) NSString *comment5;

// 充电中图片描述url
@property (copy, nonatomic) NSString *imageUrl6;

// 充电中图片描述
@property (copy, nonatomic) NSString *comment6;

// 车位特殊说明
@property (copy, nonatomic) NSString *space_comment;

// 大
@property (copy, nonatomic) NSString *bnum;

// 中
@property (copy, nonatomic) NSString *mnum;

// 小
@property (copy, nonatomic) NSString *snum;

// 微
@property (copy, nonatomic) NSString *tnum;


/**
 *  电桩组数据属性--车位
 */

// id4(返回数据中的pileId)
@property (copy, nonatomic) NSString *id4;

// 电桩品牌id
@property (copy, nonatomic) NSString *pileResourceBrandId;

// 运营商id
@property (copy, nonatomic) NSString *pileResourceOperatorId;

// 电桩用法图片url
@property (copy, nonatomic) NSString *imageUrl7;

// 电桩用法图片描述
@property (copy, nonatomic) NSString *comment7;


/**
 *  电桩组数据属性--接口
 */

// id5 (返回数据中的pileInterfaceIds)
@property (copy, nonatomic) NSString *id5;

// 服务费类型
@property (copy, nonatomic) NSString *pileResourceInterfaceId;

//服务费用
@property (copy, nonatomic) NSString *tariffService;

// 个
@property (copy, nonatomic) NSString *num;

// 重量
@property (copy, nonatomic) NSString *weight;

// 是否自带电桩充电线
@property (copy, nonatomic) NSString *hasChargeCable;

// 电压
@property (copy, nonatomic) NSString *voltage;

// 电流
@property (copy, nonatomic) NSString *currrent;

// 忙时费用
@property (copy, nonatomic) NSString *tariffChargeBusy;

// 忙时区间
@property (copy, nonatomic) NSString *tariffChargeBusyInterval;

// 闲时费用
@property (copy, nonatomic) NSString *tariffChargeIdle;

// 闲时区间
@property (copy, nonatomic) NSString *tariffChargeIdleInterval;

// 支付类型
@property (copy, nonatomic) NSString *paymentType;

// 充电口正面照图片url
@property (copy, nonatomic) NSString *imageUrl8;

// 充电口正面照图片描述
@property (copy, nonatomic) NSString *comment8;

// 细节图片url
@property (copy, nonatomic) NSString *imageUrl9;

// 细节图片描述
@property (copy, nonatomic) NSString *comment9;

// 接口特殊说明
@property (copy, nonatomic) NSString *interface_comment;


/**
 *  收费标准
 */

// id6 (返回数据中的parkingIds)
@property (copy, nonatomic) NSString *id6;

// 收费名称
@property (copy, nonatomic) NSString *parkingName;

// 工作日开放时间
@property (copy, nonatomic) NSString *openIntervalWork;

// 周末开放时间
@property (copy, nonatomic) NSString *openIntervalNowork;

// 特殊说明
@property (copy, nonatomic) NSString *openComment;

// 停车费类型
@property (copy, nonatomic) NSString *tariffType;

// 统一类型
@property (copy, nonatomic) NSString *tariffTypeUnify;

// 分时资费
@property (copy, nonatomic) NSString *tariffTypeSplit;

// 阶梯资费
@property (copy, nonatomic) NSString *tariffTypeLadder;

// 收费标准特殊说明
@property (copy, nonatomic) NSString *ChargeaStandard_comment;

// 收费标准图片url
@property (copy, nonatomic) NSString *imageUrl10;

// 收费标准图片描述
@property (copy, nonatomic) NSString *comment10;

@end
