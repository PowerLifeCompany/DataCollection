//
//  PileInfo.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  电桩基本信息
 */
@interface PileInfo : NSObject

@property (nonatomic, assign) NSInteger Id;
/**
 *  电桩组的位置ID
 */
@property (nonatomic, assign) NSInteger pileSiteId;

/**
 *  电桩品牌ID
 */
@property (nonatomic, assign) NSInteger pileResourceBrandId;
/**
 *  电桩运营商ID
 */
@property (nonatomic, assign) NSInteger pileResourceOperatorId;

/**
 *  细节特写图片路径
 */
@property (nonatomic, copy) NSString *detailImagePath;
/**
 *  细节特写电桩用法
 */
@property (nonatomic, copy) NSString *comment7;

@end
