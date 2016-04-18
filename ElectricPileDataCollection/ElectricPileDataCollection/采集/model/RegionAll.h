//
//  RegionAll.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Province.h"
#import "City.h"
#import "District.h"
#import "Area.h"

@interface RegionAll : NSObject

@property (nonatomic, assign) NSInteger provinceId;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, copy) NSString *provinceLetter;

@property (nonatomic, assign) NSInteger cityId;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *cityLetter;

@property (nonatomic, assign) NSInteger districtId;

@property (nonatomic, copy) NSString *districtName;

@property (nonatomic, copy) NSString *districtLetter;

@property (nonatomic, assign) NSInteger areaId;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, copy) NSString *areaLetter;

+ (BOOL)updateRegionAllDataWithArray:(NSArray *)dataArray;

+ (NSArray *)provinceArrayFromDatabase;

+ (void)setProvinceArrayIsNil;


@end
