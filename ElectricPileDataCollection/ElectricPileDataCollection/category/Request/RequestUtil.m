//
//  RequestUtil.m
//  比颜值
//
//  Created by 陈行 on 15-11-19.
//  Copyright (c) 2015年 陈行. All rights reserved.
//

#import "RequestUtil.h"
#import "AFNetworking.h"
#import "NSString+encrypto.h"
//#import "Setting.h"

#define HMEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@implementation RequestUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isShowProgressHud=false;
    }
    return self;
}

- (void)asyncSessionWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters andMethod:(RequestMethod)method andTimeoutInterval:(NSInteger)timeoutInterval{
    
    NSURL * url=[NSURL URLWithString:urlString];
    
    NSString * params=[self stringWithParameters:parameters];
    NSData * paramData=[params dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutInterval];
    request.HTTPBody=paramData;
    if(method==RequestMethodPost){
        request.HTTPMethod=@"POST";
    }else{
        request.HTTPMethod=@"GET";
    }
    NSURLSession * session=[NSURLSession sharedSession];
    
    NSURLSessionTask * task=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse * res=(NSHTTPURLResponse *)response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate response:response andError:error andData:data andStatusCode:res.statusCode andURLString:urlString];
        });
    }];
    [task resume];
}

- (void)asyncThirdLibWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters andMethod:(RequestMethod)method andTimeoutInterval:(NSInteger)timeoutInterval{
    if(self.isShowProgressHud){
        [LCLoadingHUD showLoading:self.progressHudText];
    }
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
//    NSInteger timeout = [Setting settingFromDatabase].timeout;
//    manager.requestSerializer.timeoutInterval=timeout>0?timeout:timeoutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if(method==RequestMethodPost){
        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSHTTPURLResponse * res=(NSHTTPURLResponse *)operation.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [LCLoadingHUD hideInKeyWindow];
                [self.delegate response:operation.response andError:nil andData:responseObject andStatusCode:res.statusCode andURLString:urlString];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSHTTPURLResponse * res=(NSHTTPURLResponse *)operation.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [LCLoadingHUD hideInKeyWindow];
                [self.delegate response:operation.response andError:error andData:nil andStatusCode:res.statusCode andURLString:urlString];
            });
        }];
    }else{
        [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSHTTPURLResponse * res=(NSHTTPURLResponse *)operation.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate response:operation.response andError:nil andData:responseObject andStatusCode:res.statusCode andURLString:urlString];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSHTTPURLResponse * res=(NSHTTPURLResponse *)operation.response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate response:operation.response andError:error andData:nil andStatusCode:res.statusCode andURLString:urlString];
            });
        }];
    }
}


- (void)asyncThirdLibWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters andImageName:(NSString *)imageName andData:(NSData *)data andTimeoutInterval:(NSInteger)timeoutInterval{
    if(self.isShowProgressHud){
        [LCLoadingHUD showLoading:self.progressHudText];
    }

    urlString =[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlString];
    //2.创建请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    
    //3.构建数据
    NSData * formdata=[self getHttpBody:imageName andData:data andParams:parameters];
    request.HTTPBody=data;
    
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)data.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"KenshinCui"] forHTTPHeaderField:@"Content-Type"];
    
    //4.创建会话
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask=[session uploadTaskWithRequest:request fromData:formdata completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse * res=(NSHTTPURLResponse *)response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [LCLoadingHUD hideInKeyWindow];
            [self.delegate response:response andError:error andData:data andStatusCode:res.statusCode andURLString:urlString];
        });
    }];
    
    [uploadTask resume];
}

#pragma mark 取得数据体
-(NSData *)getHttpBody:(NSString *)fileName andData:(NSData *)fileData andParams:(NSDictionary *)params{
    NSString *boundary=@"KenshinCui";
    NSMutableData *dataM=[NSMutableData data];
    
    NSString *strTop=[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: %@\r\n",boundary,fileName,[NSString stringWithFormat:@"%@.jpg",[self getCurrentTimeStr]],@"image/jpeg"];
    
    [dataM appendData:[strTop dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataM appendData:HMEncode(@"\r\n")];
    [dataM appendData:fileData];
    [dataM appendData:HMEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [dataM appendData:HMEncode(@"--KenshinCui\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [dataM appendData:HMEncode(disposition)];
        
        [dataM appendData:HMEncode(@"\r\n")];
        [dataM appendData:HMEncode(obj)];
        [dataM appendData:HMEncode(@"\r\n")];
    }];
    NSString *strBottom=[NSString stringWithFormat:@"--%@--\r\n",boundary];
    [dataM appendData:[strBottom dataUsingEncoding:NSUTF8StringEncoding]];
    return dataM;
}

/**
 *  把参数按照key=value&key1=value1的格式进行拼接
 *
 *  @param parameters 参数
 *
 *  @return key=value&key1=value1
 */
- (NSString *)stringWithParameters:(NSDictionary *)parameters{
    int i=0;
    NSMutableString * paramsStr=[NSMutableString string];
    for(NSString * key in [parameters allKeys]){
        if(i!=0){
            [paramsStr appendString:@"&"];
        }
        [paramsStr appendFormat:@"%@=%@",key,parameters[key]];
        i++;
    }
    return paramsStr;
}

+ (NSDictionary *)getParamsWithString:(NSString *)value{
    NSMutableDictionary * dict=[NSMutableDictionary new];
    
    NSArray * array=[value componentsSeparatedByString:@"&"];
    for (NSString * keyValue in array) {
        NSArray * tmpKeyValueArr=[keyValue componentsSeparatedByString:@"="];
        NSString * key=tmpKeyValueArr[0];
        NSString * value=tmpKeyValueArr[1];
        value=value.length?value:@"";
        [dict setObject:value forKey:key];
    }
    return dict;
}

- (void)asyncRongYunWithUrl:(NSString *)urlString andParameters:(NSDictionary *)parameters{
    if(self.isShowProgressHud){
        [LCLoadingHUD showLoading:self.progressHudText];
    }
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * timestamp=[self getCurrentTimeStr];
    NSString * nonce = [timestamp sha1];
    NSString * signature = [[NSString stringWithFormat:@"%@%@%@",RongYunSecret,nonce,timestamp] sha1];
    
    [manager.requestSerializer setValue:RongYunAppKey forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
    
    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSHTTPURLResponse * res=(NSHTTPURLResponse *)operation.response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [LCLoadingHUD hideInKeyWindow];
            [self.delegate response:operation.response andError:nil andData:responseObject andStatusCode:res.statusCode andURLString:urlString];
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSHTTPURLResponse * res=(NSHTTPURLResponse *)operation.response;
        dispatch_async(dispatch_get_main_queue(), ^{
            [LCLoadingHUD hideInKeyWindow];
            [self.delegate response:operation.response andError:error andData:nil andStatusCode:res.statusCode andURLString:urlString];
        });
    }];
}

- (NSString *)getCurrentTimeStr{
    NSDate * date=[NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    return [NSString stringWithFormat:@"%ld",(long)[[date dateByAddingTimeInterval:time] timeIntervalSince1970]];
}

- (NSString *)getCurrentTimeDescription{
    NSInteger time = [[self getCurrentTimeStr] integerValue];
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSString * res = [date description];
    return [res substringToIndex:res.length-6];
}

@end
