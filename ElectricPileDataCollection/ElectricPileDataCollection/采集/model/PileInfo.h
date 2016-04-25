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

@property (assign, nonatomic) NSInteger Id;

/**
 *  电桩组的位置ID
 */
@property (assign, nonatomic) NSInteger pileSiteId;

/**
 *  电桩品牌ID
 */
@property (assign, nonatomic) NSInteger pileResourceBrandId;

/**
 *  电桩运营商ID
 */
@property (assign, nonatomic) NSInteger pileResourceOperatorId;

/**
 *  细节特写电桩用法
 */
@property (copy, nonatomic) NSString *comment7;

/**
 *  细节特写电桩用法(图片)
 */
@property (copy, nonatomic) NSString *logoDetailImagePath;

/**
 *  细节特写电桩用法(图片)
 */
@property (copy, nonatomic) NSString *imageUrl7;


@end
