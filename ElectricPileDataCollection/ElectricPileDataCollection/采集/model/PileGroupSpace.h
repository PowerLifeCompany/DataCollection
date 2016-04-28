//
//  PileGroupSpace.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  电桩组车位的信息
 */
@interface PileGroupSpace : NSObject

@property (assign, nonatomic) NSInteger Id;
/**
 *  电桩组的位置ID
 */
@property (assign, nonatomic) NSInteger pileSiteId;

/**
 *  车位类型中四条数据
 */
/**
 *  中停车位
 */
@property (copy, nonatomic) NSString *mnum;
/**
 *  小停车位
 */
@property (copy, nonatomic) NSString *snum;
/**
 *  大停车位
 */
@property (copy, nonatomic) NSString *bnum;
/**
 *  微停车位
 */
@property (copy, nonatomic) NSString *tnum;
/**
 *  特殊说明
 */
@property (copy, nonatomic) NSString *comment;

/**
 *  停车场位于小区哪里
 */
@property (copy, nonatomic) NSString *comment3;

/**
 *  停车场位于小区哪里(url)
 */
@property (copy, nonatomic) NSString *imageUrl3;

/**
 *  停车场位于小区哪里(存在沙盒的路径)
 */
@property (copy, nonatomic) NSString *image3Path;

/**
 *  电桩组的全景图
 */
@property (copy, nonatomic) NSString *comment4;

/**
 *  电桩组的全景图(url)
 */
@property (copy, nonatomic) NSString *imageUrl4;

/**
 *  电桩组的全景图(存在沙盒的路径)
 */
@property (copy, nonatomic) NSString *image4Path;

/**
 *  空位
 */
@property (copy, nonatomic) NSString *comment5;

/**
 *  空位(url)
 */
@property (copy, nonatomic) NSString *imageUrl5;

/**
 *  空位(存在沙盒的路径)
 */
@property (copy, nonatomic) NSString *image5Path;

/**
 *  充电中
 */
@property (copy, nonatomic) NSString *comment6;

/**
 *  充电中图片路径(url)
 */
@property (copy, nonatomic) NSString *imageUrl6;

/**
 *  充电中图片路径(存在沙盒的路径)
 */
@property (copy, nonatomic) NSString *image6Path;


@end
