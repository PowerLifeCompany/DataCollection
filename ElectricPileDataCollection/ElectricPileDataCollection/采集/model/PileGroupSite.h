//
//  PileGroupSite.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  电桩组位置描述
 */
@interface PileGroupSite : NSObject

@property (nonatomic, assign) NSInteger Id;
/**
 *  小区ID值
 */
@property (nonatomic, assign) NSInteger villageId;
/**
 *  电桩组的具体位置
 */
@property (nonatomic, copy) NSString *siteName;
/**
 *  经度
 */
@property (nonatomic, copy) NSString *x;
/**
 *  纬度
 */
@property (nonatomic, copy) NSString *y;

@end
