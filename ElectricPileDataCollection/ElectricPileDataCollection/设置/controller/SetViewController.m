//
//  SetViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "SetViewController.h"
#import "RegionAll.h"

@interface SetViewController ()<RequestUtilDelegate>

@property (nonatomic,strong)RequestUtil * requestUtil;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
    
}
#pragma mark - 初始化组件
- (void)loadMainView{
    //测试按钮
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, HEIGHT-220, 100, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=BOY_BG_COLOR;
    [btn setTitle:@"数据同步" forState:UIControlStateNormal];
}

- (void)testBtn{
    [self.requestUtil asyncThirdLibWithUrl:GET_ALL_REGION_URL andParameters:nil andMethod:RequestMethodGet andTimeoutInterval:30];
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"设置";
}


#pragma mark - 下载数据
- (void)response:(NSURLResponse *)response andError:(NSError *)error andData:(NSData *)data andStatusCode:(NSInteger)statusCode andURLString:(NSString *)urlString{
    if(statusCode==200 && !error){
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            BOOL res =[RegionAll updateRegionAllDataWithArray:array];
            [RegionAll setProvinceArrayIsNil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [LCLoadingHUD hideInKeyWindow];
                [self.view addSubview:[CustomPopupView customPopupViewWithMsg:[NSString stringWithFormat:@"同步数据%@！",res?@"成功":@"失败"]]];
            });
        });
    }else{
        NSLog(@"%@",error);
        [LCLoadingHUD hideInKeyWindow];
        [self.view addSubview:[CustomPopupView customPopupViewWithMsg:FINAL_DATA_REQUEST_FAIL]];
    }
}
#pragma mark - 懒加载
- (RequestUtil *)requestUtil{
    if(_requestUtil==nil){
        _requestUtil=[[RequestUtil alloc]init];
        _requestUtil.isShowProgressHud=YES;
        _requestUtil.delegate=self;
    }
    return _requestUtil;
}
@end
