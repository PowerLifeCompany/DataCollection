//
//  PPNetworkingHelper.m
//  上传Demo
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 鲁强. All rights reserved.
//

#import "PPNetworkingHelper.h"
#import "PPNewworkingUrl.h"
#import "AFNetworking.h"

@implementation PPNetworkingHelper
// 图片上传
+ (void)uploadImageWithInfo:(NSDictionary *)dict andFinishBlock:(nullable void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))finishBlock {
    // 获取URL
    NSString *urlStr = [NSString stringWithFormat:UpLoadImageUrl, dict[@"type"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 获取图片路径URL
    NSString *picPath = [NSString stringWithFormat:@"%@/%@", [PPNetworkingHelper docFolderPath], dict[@"name"]];
    NSURL *picUrl = [NSURL fileURLWithPath:picPath];
    
    // 拼接请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    
    NSArray *keys = [dict allKeys];
    for (NSString *key in keys) {
        if ([key isEqualToString:@"name"] || [key isEqualToString:@"type"]) {
            continue;
        }
        NSString *value = [NSString stringWithFormat:@"%@",  dict[key]];
        NSString *query = [NSString stringWithFormat:@"__%@",  key];
        
        NSLog(@"%@", NSStringFromClass([value class]));
        NSLog(@"%@", NSStringFromClass([query class]));
        [request addValue:value forHTTPHeaderField:query];
    }
    
    // 创建上传任务
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:picUrl progress:nil completionHandler:finishBlock];
    
    // 开始上传
    [uploadTask resume];
}

// 数据上传
+ (void)uploadDataWithInfo:(NSDictionary *)dict andFinishBlock:(nullable void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))finishBlock {
    // 1.格式转换
    NSMutableDictionary *formData = [[NSMutableDictionary alloc]init];
    NSArray *keyList = [dict allKeys];
    for (NSString *key in keyList) {
        
        id value = dict[key];
        
        if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
            formData[key] = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
        }
        else {
            formData[key] = value;
        }
    }
    
    NSLog(@"----------------%@", formData);
    
    // 2.创建请求
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:UpLoadDataUrl parameters:formData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } error:nil];
    [request setHTTPMethod:@"POST"];
    
    // 3.创建数据数据上传任务
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:finishBlock];
    
    // 4.开始上传数据
    [uploadTask resume];
}

// 新增片区
+ (void)addNewAreaWithInfo:(NSString *)info andSuccessBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock failureBlock:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock{
    // 1.格式转换
    NSMutableDictionary *formData = [[NSMutableDictionary alloc]init];
    formData[@"data"] = info;
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager GET:UpLoadNewArea parameters:formData progress:nil success:successBlock failure:failureBlock];
}

// 新增小区
+ (void)addNewVillageWithInfo:(NSString *)info andSuccessBlock:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))successBlock failureBlock:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock{
    // 1.格式转换
    NSMutableDictionary *formData = [[NSMutableDictionary alloc]init];
    formData[@"data"] = info;
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager GET:UpLoadNewVillage parameters:formData progress:nil success:successBlock failure:failureBlock];
}

// 获取doc路径
+ (NSString *)docFolderPath {
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [documentPath objectAtIndex:0];
}

@end
