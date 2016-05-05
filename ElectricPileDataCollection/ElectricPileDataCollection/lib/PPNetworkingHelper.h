//
//  PPNetworkingHelper.h
//  上传Demo
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 鲁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPNetworkingHelper : NSObject

/**
*  上传Document中的图片
*
*  @param dict        @param dict 图片名[@"name"]，图片类型[@"type"]，图片id信息
*  @param finishBlock 图片上传完成后的回调block
*/
+ (void)uploadImageWithInfo:(NSDictionary *)dict andFinishBlock:(nullable void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))finishBlock;

/**
 *  上传文本数据
 *
 *  @param dict        dict中的NSDictionary、NSArray成员要转换成NSData
 *  @param finishBlock 数据上传完成后的回调block
 */
+ (void)uploadDataWithInfo:(NSDictionary *)dict andFinishBlock:(nullable void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))finishBlock;

/**
 *  新增片区
 *
 *  @param dict        dict中的NSDictionary、NSArray成员要转换成NSData
 *  @param finishBlock 数据上传完成后的回调block
 */
+ (void)addNewAreaWithInfo:(NSString *)info andSuccessBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock failureBlock:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

/**
 *  新增小区
 *
 *  @param dict        dict中的NSDictionary、NSArray成员要转换成NSData
 *  @param finishBlock 数据上传完成后的回调block
 */
+ (void)addNewVillageWithInfo:(NSString *)info andSuccessBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock failureBlock:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

@end
