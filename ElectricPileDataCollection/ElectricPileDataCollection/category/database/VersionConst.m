//
//  VersionConst.m
//  比颜值
//
//  Created by 陈行 on 15-12-1.
//  Copyright (c) 2015年 陈行. All rights reserved.
//

#import "VersionConst.h"

@implementation VersionConst

NSString *const APPVERSION_PLIST=@"IpaInfo.plist";

NSString *const VERSION_0=@"0";
NSString *const VERSION_1_0 = @"1.0";
NSString *const VERSION_1_1 = @"1.1";
NSString *const VERSION_1_2 = @"1.2";
//创建version表
NSString *const VERSION_SQL_1_0_1 = @"CREATE TABLE `version_info` (`database_version`	TEXT NOT NULL,`timeout`	INTEGER DEFAULT 10);";

NSString *const VERSION_SQL_1_0_2 = @"INSERT INTO `version_info`(`database_version`,`timeout`) VALUES ('1.0',10);";

NSString *const VERSION_SQL_1_0_3 = @"CREATE TABLE `pile_brand` (`id`	INTEGER,`name`	TEXT,PRIMARY KEY(id));";

NSString *const VERSION_SQL_1_0_4=@"CREATE TABLE `pile_operator` (`id`	INTEGER,`name`	TEXT,PRIMARY KEY(id));";

NSString *const VERSION_SQL_1_0_5=@"CREATE TABLE `province` (`Id`	INTEGER,`name`	INTEGER,`createdBy`	INTEGER,`createdDate`	INTEGER,`lastUpdatedBy`	INTEGER,`lastUpdatedDate`	INTEGER,`letter`	INTEGER,`sequence`	INTEGER,`ver`	INTEGER,PRIMARY KEY(Id));";

NSString *const VERSION_SQL_1_0_6=@"CREATE TABLE `city` (`Id`	INTEGER,`name`	INTEGER,`createdBy`	INTEGER,`createdDate`	INTEGER,`lastUpdatedBy`	INTEGER,`lastUpdatedDate`	INTEGER,`letter`	INTEGER,`sequence`	INTEGER,`ver`	INTEGER,`provinceId`	INTEGER,PRIMARY KEY(Id));";

NSString *const VERSION_SQL_1_0_7=@"CREATE TABLE `district` (`Id`	INTEGER,`name`	INTEGER,`createdBy`	INTEGER,`createdDate`	INTEGER,`lastUpdatedBy`	INTEGER,`lastUpdatedDate`	INTEGER,`letter`	INTEGER,`sequence`	INTEGER,`ver`	INTEGER,`cityId`	INTEGER,PRIMARY KEY(Id));";

NSString *const VERSION_SQL_1_0_8 = @"CREATE TABLE `area` (`Id`	INTEGER,`name`	INTEGER,`createdBy`	INTEGER,`createdDate`	INTEGER,`lastUpdatedBy`	INTEGER,`lastUpdatedDate`	INTEGER,`letter`	INTEGER,`sequence`	INTEGER,`ver`	INTEGER,`districtId`	INTEGER,PRIMARY KEY(Id));";

NSString *const VERSION_SQL_1_0_9 = @"";

NSString *const VERSION_SQL_1_0_10 = @"";


@end
