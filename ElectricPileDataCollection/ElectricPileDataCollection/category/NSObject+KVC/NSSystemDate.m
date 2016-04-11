//
//  NSSystemDate.m
//  时间插件封装
//
//  Created by MS on 15-10-23.
//  Copyright (c) 2015年 陈行. All rights reserved.
//

#import "NSSystemDate.h"
#include "sys/time.h"


@implementation NSSystemDate
- (NSString *)description
{
    return [NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02d", _year,_month,_day,_hour,_minute,_second];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        time_t rawtime;
        struct tm *timeinfo;
        
        time(&rawtime);
//        NSLog(@"从1970年1月1日到现在的秒数：%ld",rawtime);
        
        
        timeinfo = localtime(&rawtime);
        //系统提供的时间格式
//        NSLog(@"%s",asctime(timeinfo));
        //秒
        _second=timeinfo->tm_sec;
        //分
        _minute=timeinfo->tm_min;
        //时
        _hour=timeinfo->tm_hour;
        //日
        _day=timeinfo->tm_mday;
        //月
        _month=timeinfo->tm_mon+1;
        //年
        _year=timeinfo->tm_year+1900;
        //星期
        _weekDay=timeinfo->tm_wday;
        
        _tm_yday=timeinfo->tm_yday;
        _tm_isdst=timeinfo->tm_isdst;
        _tm_gmtoff=timeinfo->tm_gmtoff;
        _tm_zone=timeinfo->tm_zone;
        gettimeofday(&_rawtime, NULL);
//        NSLog(@"微秒数：%d",_rawtime.tv_usec);
        _timeInMollis=_rawtime.tv_sec*1000+_rawtime.tv_usec/1000;
//        NSLog(@"毫秒数：%lld",_timeInMollis/1000);
//        NSLog(@"星期%d",_weekDay);
        
    }
    return self;
}

- (NSString *)descriptionWithTimeFormatter:(NSString *)timeFormmatterString{
    NSMutableString * timeFormmatter=[NSMutableString new];
    [timeFormmatter setString:timeFormmatterString];
    /**NSRange结构体中代表location，length代表长度*/
    NSRange range={0,timeFormmatter.length};
    
    /**YYYY代表年，MM代表月，dd代表日 HH代表小时，mm代表分，ss代表秒 SSS代表毫秒数*/
    [timeFormmatter replaceOccurrencesOfString:@"YYYY" withString:[NSString stringWithFormat:@"%04d",self.year] options:NSLiteralSearch range:range];
    
    [timeFormmatter replaceOccurrencesOfString:@"YY" withString:[NSString stringWithFormat:@"%02d",self.year%100] options:NSLiteralSearch range:range];
    
    [timeFormmatter replaceOccurrencesOfString:@"MM" withString:[NSString stringWithFormat:@"%02d",self.month] options:NSLiteralSearch range:range];

    [timeFormmatter replaceOccurrencesOfString:@"dd" withString:[NSString stringWithFormat:@"%02d",self.day] options:NSLiteralSearch range:range];
    
    [timeFormmatter replaceOccurrencesOfString:@"HH" withString:[NSString stringWithFormat:@"%02d",self.hour] options:NSLiteralSearch range:range];
    
    [timeFormmatter replaceOccurrencesOfString:@"mm" withString:[NSString stringWithFormat:@"%02d",self.minute] options:NSLiteralSearch range:range];
    
    [timeFormmatter replaceOccurrencesOfString:@"ss" withString:[NSString stringWithFormat:@"%02d",self.second] options:NSLiteralSearch range:range];

//    NSLog(@"毫秒数：%lld",self.timeInMollis%1000);
    [timeFormmatter replaceOccurrencesOfString:@"SSS" withString:[NSString stringWithFormat:@"%03lld",self.timeInMollis%1000] options:NSLiteralSearch range:range];
    
//    NSLog(@"%@",timeFormmatter);
    return timeFormmatter;
}

@end
