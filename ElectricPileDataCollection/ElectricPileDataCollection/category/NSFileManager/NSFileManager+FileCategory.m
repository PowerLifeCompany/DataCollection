//
//  NSFileManager+FileCategory.m
//  biyanzhi
//
//  Created by 陈行 on 16-1-19.
//  Copyright (c) 2016年 陈行. All rights reserved.
//

#import "NSFileManager+FileCategory.h"

@implementation NSFileManager (FileCategory)



/**
 *  获取SDWebImage缓存大小
 *
 *  @return 缓存大小
 */
+ (NSInteger)cacheSize{
    //    NSDate * date=[NSDate date];
    NSFileManager * fm=[NSFileManager defaultManager];
    NSInteger fileSize=0;
    NSString * path=[NSString stringWithFormat:SDWEBIMAGE_PATH,NSHomeDirectory()];
    for (NSString * fileName in [fm subpathsAtPath:path]) {
        NSError * error;
        NSDictionary * dict=[fm attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",path,fileName] error:&error];
        
        fileSize+=error?0:[dict fileSize];
    }
    
    //    NSTimeInterval time=[date timeIntervalSinceNow];
    //    NSLog(@"size%f-->%f",fileSize*1.0/1024/1024,time);
    return fileSize;
}

@end
