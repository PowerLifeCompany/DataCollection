//
//  NSFileManager+FileCategory.h
//  biyanzhi
//
//  Created by 陈行 on 16-1-19.
//  Copyright (c) 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SDWEBIMAGE_PATH @"%@/Library/Caches/default/com.hackemist.SDWebImageCache.default"

@interface NSFileManager (FileCategory)

+ (NSInteger)cacheSize;

@end
