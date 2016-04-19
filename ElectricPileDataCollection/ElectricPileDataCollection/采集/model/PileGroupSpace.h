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

@property (nonatomic, assign) NSInteger Id;
/**
 *  电桩组的位置ID
 */
@property (nonatomic, assign) NSInteger pileSiteId;

/**
 *  车位类型中四条数据
 */
/**
 *  中停车位
 */
@property (nonatomic, assign) NSInteger mnum;
/**
 *  小停车位
 */
@property (nonatomic, assign) NSInteger snum;
/**
 *  大停车位
 */
@property (nonatomic, assign) NSInteger bnum;
/**
 *  微停车位
 */
@property (nonatomic, assign) NSInteger tnum;
/**
 *  特殊说明
 */
@property (nonatomic, copy) NSString *comment;



/**
 *  停车场位于小区哪里
 */
@property (nonatomic, copy) NSString *comment3;

/**
 *  停车场位于小区哪里(url)
 */
@property (nonatomic, copy) NSString *imageUrl3;

/**
 *  停车场位于小区哪里(存在沙盒的路径)
 */
@property (nonatomic, copy) NSString *image3Path;



/**
 *  电桩组的全景图
 */
@property (nonatomic, copy) NSString *comment4;

/**
 *  电桩组的全景图(url)
 */
@property (nonatomic, copy) NSString *imageUrl4;

/**
 *  电桩组的全景图(存在沙盒的路径)
 */
@property (nonatomic, copy) NSString *image4Path;



/**
 *  空位
 */
@property (nonatomic, copy) NSString *comment5;

/**
 *  空位(url)
 */
@property (nonatomic, copy) NSString *imageUrl5;

/**
 *  空位(存在沙盒的路径)
 */
@property (nonatomic, copy) NSString *image5Path;



/**
 *  充电中
 */
@property (nonatomic, copy) NSString *comment6;

/**
 *  充电中图片路径(url)
 */
@property (nonatomic, copy) NSString *imageUrl6;

/**
 *  充电中图片路径(存在沙盒的路径)
 */
@property (nonatomic, copy) NSString *image6Path;


@end
