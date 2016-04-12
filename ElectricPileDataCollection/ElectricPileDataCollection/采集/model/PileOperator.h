//
//  PileOperator.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PileOperator : NSObject

@property(nonatomic,assign)NSInteger Id;

@property (nonatomic, copy) NSString *name;

+ (instancetype)pileOperatorWithDict:(NSDictionary *)dict;

+ (NSArray *)sharePileOperatorFromPileOperatorPlist;

@end
