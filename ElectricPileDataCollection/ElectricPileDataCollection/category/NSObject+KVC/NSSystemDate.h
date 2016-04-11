//
//  NSSystemDate.h
//  时间插件封装
//
//  Created by MS on 15-10-23.
//  Copyright (c) 2015年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSystemDate : NSObject
{
    @private
    /**结构体，存储描述和微秒数*/
    struct timeval _rawtime;
}

/**秒[0-59]*/
@property(nonatomic,readonly,assign)int second;
/**分[0-59]*/
@property(nonatomic,readonly,assign)int minute;
/**时[0-23]*/
@property(nonatomic,readonly,assign)int	hour;
/**日[1-31]*/
@property(nonatomic,readonly,assign)int	day;
/**月[1-12]*/
@property(nonatomic,readonly,assign)int	month;
/**年数*/
@property(nonatomic,readonly,assign)int	year;
/**星期*/
@property(nonatomic,readonly,assign)int	weekDay;
/**自1月1日起的天数*/
@property(nonatomic,readonly,assign)int	tm_yday;
/**夏令日标记*/
@property(nonatomic,readonly,assign)int	tm_isdst;
/**CUT标准时间偏移时间（秒）*/
@property(nonatomic,readonly,assign)long	tm_gmtoff;
/**所使用的时间标准，如CST(China Standard Time)*/
@property(nonatomic,readonly,assign)char	*tm_zone;
/**从1970年到现在时刻的毫秒数*/
@property long long timeInMollis;
/**YYYY代表年，MM代表月，dd代表日 HH代表小时，mm代表分，ss代表秒 SSS代表毫秒数*/
- (NSString *)descriptionWithTimeFormatter:(NSString *)timeFormmatterString;

@end
