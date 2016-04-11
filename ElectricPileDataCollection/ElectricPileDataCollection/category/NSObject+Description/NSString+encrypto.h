//
//  NSString+encrypto.h
//  biyanzhi
//
//  Created by 陈行 on 16-1-20.
//  Copyright (c) 2016年 陈行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (encrypto)

- (NSString *) md5;
- (NSString *) sha1;

@end
