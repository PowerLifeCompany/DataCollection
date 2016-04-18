//
//  City.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, copy) NSString *letter;

@property (nonatomic, copy) NSString *createdDate;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *sequence;

@property (nonatomic, assign) NSInteger ver;

@property (nonatomic, copy) NSString *createdBy;

@property (nonatomic, copy) NSString *lastUpdatedBy;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *lastUpdatedDate;

@property(nonatomic,assign)NSInteger provinceId;

@property(nonatomic,strong)NSArray * districtArray;

+ (instancetype)cityWithDict:(NSDictionary *)dict;

@end
