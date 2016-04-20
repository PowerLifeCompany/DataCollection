//
//  InterfaceType.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/20.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterfaceType : NSObject

@property(nonatomic,assign)NSInteger Id;

@property (nonatomic, copy) NSString *name;

+ (instancetype)InterfaceTypeWithDict:(NSDictionary *)dict;

+ (NSArray *)shareInterfaceTypeFromPileBrandPlist;

@end
