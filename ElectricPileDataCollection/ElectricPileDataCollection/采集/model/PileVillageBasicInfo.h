//
//  PileVillageBasicInfo.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  电桩小区的基本描述---->PileVillage
 */
@interface PileVillageBasicInfo : NSObject

/**
 *  唯一ID
 */
@property (nonatomic, assign) NSInteger Id;

/**
 *  省市区片中片的ID
 */
@property (nonatomic, assign) NSInteger villageId;

/**
 *  小区名称
 */
@property (nonatomic, copy) NSString *villageName;

/**
 *  小区路口怎么走本地图片路径
 */
@property (nonatomic, copy) NSString *villagePathImagePath;

/**
 *  小区路口怎么走图片url
 */
@property (nonatomic, copy) NSString *imageUrl1;

/**
 *  路口如何走，标明来处，面描述
 */
@property (nonatomic, copy) NSString *comment1;

/**
 *  小区入口本地图片路径
 */
@property (nonatomic, copy) NSString *villageEntranceImagePath;

/**
 *  小区入口本地图片url
 */
@property (nonatomic, copy) NSString *imageUrl2;

/**
 *  小区入口（左转右转描述）
 */
@property (nonatomic, copy) NSString *comment2;

@end
