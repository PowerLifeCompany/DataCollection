//
//  RegionAll.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "RegionAll.h"
#import "NSObject+KVC.h"
#import "SQLiteManager.h"

@implementation RegionAll

+ (BOOL)updateRegionAllDataWithArray:(NSArray *)dataArray{
    [SQLiteManager deleteWithTableName:nil andClass:[Province class] andParams:nil];
    [SQLiteManager deleteWithTableName:nil andClass:[City class] andParams:nil];
    [SQLiteManager deleteWithTableName:nil andClass:[District class] andParams:nil];
    [SQLiteManager deleteWithTableName:nil andClass:[Area class] andParams:nil];
    
    BOOL res = true;
    for (NSDictionary * dict in dataArray) {
        RegionAll * data = [self objectWithDict:dict];
        
        if(data.provinceId){
            Province * pro=[Province new];
            pro.Id=data.provinceId;
            pro.name=data.provinceName;
            pro.letter=data.provinceLetter;
            if(![SQLiteManager insertOrReplaceWithNoArrayToTableName:nil andObject:pro]){
                res=false;
            }
        }
        
        if(data.cityId){
            City * city=[City new];
            city.Id=data.cityId;
            city.name=data.cityName;
            city.letter=data.cityLetter;
            city.provinceId=data.provinceId;
            if(![SQLiteManager insertOrReplaceWithNoArrayToTableName:nil andObject:city]){
                res=false;
            }
        }
        
        if(data.districtId){
            District * dis=[District new];
            dis.Id=data.districtId;
            dis.name=data.districtName;
            dis.letter=data.districtLetter;
            dis.cityId=data.cityId;
            if(![SQLiteManager insertOrReplaceWithNoArrayToTableName:nil andObject:dis]){
                res=false;
            }
        }
        
        if(data.areaId){
            Area * area = [Area new];
            area.Id=data.areaId;
            area.name=data.areaName;
            area.letter=data.areaLetter;
            area.districtId=data.districtId;
            if(![SQLiteManager insertOrReplaceWithNoArrayToTableName:nil andObject:area]){
                res=false;
            }
        }
    }
    return res;
}

static NSArray * sharedProviceArray;
+ (NSArray *)provinceArrayFromDatabase{
    if(sharedProviceArray==nil){
        @synchronized (self) {
            NSArray * provinceArray = [SQLiteManager queryAllWithTableName:nil andClass:[Province class]];
            for (Province * pro in provinceArray) {
                pro.cityArray = [SQLiteManager queryByParamsWithTableName:nil andClass:[City class] andParams:@{@"provinceId":@(pro.Id)}];
                for (City * city in pro.cityArray) {
                    city.districtArray = [SQLiteManager queryByParamsWithTableName:nil andClass:[District class] andParams:@{@"cityId":@(city.Id)}];
                    for (District * dis in city.districtArray) {
                        dis.areaArray = [SQLiteManager queryByParamsWithTableName:nil andClass:[Area class] andParams:@{@"districtId":@(dis.Id)}];
                    }
                }
            }
            sharedProviceArray=provinceArray;
        }
    }
    return sharedProviceArray;
}

+ (void)setProvinceArrayIsNil{
    sharedProviceArray=nil;
}

- (void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:@"districtId"] && value==nil){
        
    }else if ([key isEqualToString:@"areaId"] && value==nil){
        
    }else if ([key isEqualToString:@"cityId"] && value==nil){
        
    }else if ([key isEqualToString:@"provinceId"] && value==nil){
        
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
