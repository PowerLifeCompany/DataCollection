//
//  CollectionViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CollectionViewController.h"
#import "TestDataViewController.h"
#import "CollPileViewController.h"
#import "CollectionMainView.h"
#import "CustomChooseCityView.h"
#import "CustomPopupView.h"
#import "PileBrand.h"
#import "CollPileViewController.h"
#import "PPNetworkingHelper.h"
#import "AFNetworking.h"

@interface CollectionViewController ()<RequestUtilDelegate,CollectionMainViewDelegate,CustomChooseCityViewDelegate,CustomPickViewDelegate>

@property (nonatomic,strong) RequestUtil * requestUtil;

@property (nonatomic,strong) NSMutableArray <PileVillageInfo *> *dataArray;

@property (nonatomic,weak) CollectionMainView * mainView;

@property (nonatomic,weak) CustomChooseCityView * chooseCityView;

@property (nonatomic,weak) CustomPickView * brandPickView;

@property (nonatomic,strong) NSArray * pileBrandArray;

/**
 *  上传数据汇总字典
 */
@property (nonatomic, strong) NSMutableDictionary *collectionDictionary;

/**
 *  用户省市区片小区数据汇总字典
 */
@property (nonatomic, strong) NSMutableDictionary *villageDictionary;

/**
 *  位置数据汇总数组
 */
@property (nonatomic, strong) NSMutableArray *sitesArray;

/**
 *  收费标准数据汇总数组
 */
@property (nonatomic, strong) NSMutableArray *parkingsArray;

@end

@implementation CollectionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
}

#pragma mark - 初始化组件
- (void)loadMainView{
    CollectionMainView *mainView =[[CollectionMainView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
    mainView.mainViewDelegate = self;
    [self.view addSubview:mainView];
    self.mainView = mainView;
    self.mainView.dataArray = self.dataArray;
    
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"数据列表";
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addItem"] style:UIBarButtonItemStyleDone target:self action:@selector(addClick:)];
    self.navigationItem.rightBarButtonItem = addBtnItem;
}

- (void)addClick:(id)sender{
    CollPileViewController *regionVC = [[CollPileViewController alloc] init];
    regionVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:regionVC animated:YES];
}

#pragma mark - mainView代理
-(void)itemSelectedWithMainView:(CollectionMainView *)mainView andIndexPath:(NSIndexPath *)indexPath{
    CollPileViewController *regionVC = [[CollPileViewController alloc] init];
    regionVC.info = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:regionVC animated:YES];
}

- (void)refreshWithMainView:(CollectionMainView *)mainView andRefreshComponent:(MJRefreshComponent *)baseView{
    [mainView.mj_header endRefreshing];
}

- (void)upLoadWithMainView:(CollectionMainView *)mainView andButtonNumber:(NSInteger)num{
    
    [self getData:num];
    
    NSMutableDictionary *upLoadDataDictionary = self.collectionDictionary;
    
//    self.requestUtil.headerDict=self.collectionDictionary;
//    [self.requestUtil uploadDataWithUrl:UPLOAD_PILE_DATA andParameters:upLoadDataDictionary andTimeoutInterval:20];
    //[self.requestUtil asyncThirdLibWithUrl:UPLOAD_PILE_DATA andParameters:upLoadDataDictionary andMethod:RequestMethodPost andTimeoutInterval:20];
    
    
    [PPNetworkingHelper uploadDataWithInfo:upLoadDataDictionary andFinishBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"123 = %@",error);
        }else{
            NSLog(@"345 = %@",responseObject);
        }
    }];
}

#pragma mark - 整理数据
- (void)getData:(NSInteger)num{
    
    if (self.dataArray.count) {
        
        PileVillageInfo *pileInfo = self.dataArray[num];
        
        // 添加用户省市区片ID
        self.collectionDictionary[@"userId"] = @"1";
        self.collectionDictionary[@"provinceid"] = @"1";
        self.collectionDictionary[@"cityid"] = @"1";
        self.collectionDictionary[@"districtid"] = @"1";
        self.collectionDictionary[@"areaid"] = @"1";

        // 添加小区数据
        self.collectionDictionary[@"pile_village"] = self.villageDictionary;
        self.villageDictionary[@"id"] = @"0";
        self.villageDictionary[@"villageId"] = @"0";
        self.villageDictionary[@"imageUrl1"] = pileInfo.pile_village.imageUrl1;
        self.villageDictionary[@"imageUrl2"] = pileInfo.pile_village.imageUrl2;
        self.villageDictionary[@"comment1"] = [pileInfo.pile_village.comment1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.villageDictionary[@"comment2"] = [pileInfo.pile_village.comment2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        // 添加位置
        self.collectionDictionary[@"sites"] = self.sitesArray;
        for (int i = 0; i < pileInfo.sites.count; i++) {
            NSMutableDictionary *sitesDic = [NSMutableDictionary dictionary];
            [self.sitesArray addObject:sitesDic];
            PileGroupInfo *pileGroupInfo = pileInfo.sites[i];
            
            // 电桩位置
            NSMutableDictionary *pileSiteDic = [NSMutableDictionary dictionary];
            sitesDic[@"pile_site"] = pileSiteDic;
            pileSiteDic[@"id"] = @"0";
            pileSiteDic[@"villageId"] = @"0";
            pileSiteDic[@"siteName"] = [pileInfo.pile_village.villageName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            pileSiteDic[@"x"] = pileGroupInfo.pile_site.x;
            pileSiteDic[@"y"] = pileGroupInfo.pile_site.y;

            // 电桩车位
            NSMutableDictionary *pileSpaceDic = [NSMutableDictionary dictionary];
            sitesDic[@"pile_space"] = pileSpaceDic;
            pileSpaceDic[@"id"] = @"0";
            pileSpaceDic[@"pileSiteId"] = @"0";
            pileSpaceDic[@"imageUrl3"] = pileGroupInfo.pile_space.imageUrl3;
            pileSpaceDic[@"imageUrl4"] = pileGroupInfo.pile_space.imageUrl4;
            pileSpaceDic[@"imageUrl5"] = pileGroupInfo.pile_space.imageUrl5;
            pileSpaceDic[@"imageUrl6"] = pileGroupInfo.pile_space.imageUrl6;
            pileSpaceDic[@"bnum"] = pileGroupInfo.pile_space.bnum;
            pileSpaceDic[@"snum"] = pileGroupInfo.pile_space.snum;
            pileSpaceDic[@"mnum"] = pileGroupInfo.pile_space.mnum;
            pileSpaceDic[@"tnum"] = pileGroupInfo.pile_space.tnum;
            pileSpaceDic[@"comment3"] = [pileGroupInfo.pile_space.comment3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
            pileSpaceDic[@"comment4"] = [pileGroupInfo.pile_space.comment4 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            pileSpaceDic[@"comment5"] = [pileGroupInfo.pile_space.comment5 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            pileSpaceDic[@"comment6"] = [pileGroupInfo.pile_space.comment6 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            pileSpaceDic[@"comment"] = [pileGroupInfo.pile_space.comment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            // 新增电桩
            NSMutableArray *pilesPilesArr = [NSMutableArray array];
            sitesDic[@"piles"] = pilesPilesArr;
            for (int i = 0; i < pileGroupInfo.piles.count; i++) {
                NSMutableDictionary *pileDataDic = [NSMutableDictionary dictionary];
                [pilesPilesArr addObject:pileDataDic];
                Pile *pile = pileGroupInfo.piles[i];

                // 电桩基本信息
                NSMutableDictionary *pilePileDic = [NSMutableDictionary dictionary];
                pileDataDic[@"pile_pile"] = pilePileDic;
                pilePileDic[@"id"] = @"0";
                pilePileDic[@"pileSiteId"] = @"0";
                pilePileDic[@"pileResourceBrandId"] = @"0";
                pilePileDic[@"pile.pile_pile.pileResourceOperatorId"] = @"0";
                pilePileDic[@"imageUrl7"] = pile.pile_pile.imageUrl7;
                pilePileDic[@"comment7"] = pile.pile_pile.comment7;

                NSMutableArray *interfaceDataArr = [NSMutableArray array];
                pileDataDic[@"interfaces"] = interfaceDataArr;
                for (int i = 0; i < pile.interfaces.count; i++) {
                    NSMutableDictionary *interfaceDataDic = [NSMutableDictionary dictionary];
                    [interfaceDataArr addObject:interfaceDataDic];
                    PileInterface *interface = pile.interfaces[i];

                    // 新增接口
                    interfaceDataDic[@"id"] = @"0";
                    interfaceDataDic[@"pileId"] = @"0";
                    interfaceDataDic[@"pileResourceInterfaceId"] = @"0";
                    interfaceDataDic[@"num"] = interface.num;
                    interfaceDataDic[@"weight"] = interface.weight;
                    interfaceDataDic[@"hasChargeCable"] = [NSString stringWithFormat:@"%ld", interface.hasChargeCable];
                    interfaceDataDic[@"voltage"] = interface.voltage;
                    interfaceDataDic[@"current"] = interface.current;
                    interfaceDataDic[@"tariffChargeBusy"] = interface.tariffChargeBusy;
                    interfaceDataDic[@"tariffChargeBusyInterval"] = interface.tariffChargeBusyInterval;
                    interfaceDataDic[@"tariffChargeIdle"] = interface.tariffChargeIdle;
                    interfaceDataDic[@"tariffChargeIdleInterval"] = interface.tariffChargeIdleInterval;
                    interfaceDataDic[@"paymentType"] = interface.paymentType;
                    interfaceDataDic[@"imageUrl8"] = interface.imageUrl8;
                    interfaceDataDic[@"imageUrl9"] = interface.imageUrl9;
                    interfaceDataDic[@"comment8"] = [interface.comment8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    interfaceDataDic[@"comment9"] = [interface.comment9 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    interfaceDataDic[@"comment"] = [interface.comment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                }
            }
        }
        
        // 添加收费标准
        self.collectionDictionary[@"parkings"] = self.parkingsArray;
        NSMutableArray *parkingsDataArr = [NSMutableArray array];
        for (int i = 0; i < pileInfo.parkings.count; i++) {
            ParkingChargeStandard *parkingChargeStandard = pileInfo.parkings[i];
            NSMutableDictionary *parkingsDic = [NSMutableDictionary dictionary];
            [parkingsDataArr addObject:parkingsDic];
            
            parkingsDic[@"id"] = @"0";
            parkingsDic[@"villageId"] = @"0";
            parkingsDic[@"parkingName"] = [parkingChargeStandard.parkingName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            parkingsDic[@"openIntervalWork"] = parkingChargeStandard.openIntervalWork;
            parkingsDic[@"openIntervalNowork"] = parkingChargeStandard.openIntervalNowork;
            parkingsDic[@"openComment"] = [parkingChargeStandard.openComment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            parkingsDic[@"tariffType"] = parkingChargeStandard.tariffType;
            parkingsDic[@"tariffTypeUnify"] = parkingChargeStandard.tariffTypeUnify;
            parkingsDic[@"tariffTypeSplit"] = parkingChargeStandard.tariffTypeSplit;
            parkingsDic[@"tariffTypeLadder"] = parkingChargeStandard.tariffTypeLadder;
            parkingsDic[@"comment"] = [parkingChargeStandard.comment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            parkingsDic[@"comment10"] = [parkingChargeStandard.comment stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            parkingsDic[@"imageUrl0"] = parkingChargeStandard.imageUrl0;
        }
   }
}

#pragma mark - 上传数据
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
    
    // 2.创建请求
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"GET" URLString:UPLOAD_PILE_DATA parameters:formData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } error:nil];
    [request setHTTPMethod:@"GET"];
    
    // 3.创建数据数据上传任务
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:finishBlock];
    
    // 4.开始上传数据
    [uploadTask resume];
}


#pragma mark - custom方法
- (void)showBrandPickView{
    [UIView animateWithDuration:0.5 animations:^{
        self.brandPickView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hideBrandPickView{
    [UIView animateWithDuration:0.5 animations:^{
        self.brandPickView.transform = CGAffineTransformTranslate(self.brandPickView.transform, 0, HEIGHT);
    }];
}

#pragma mark - customView代理
- (void)customChooseCityViewAndSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray andValue:(NSString *)value{
    NSLog(@"%@-->%@",selectedArray,value);
}

#pragma mark - customPickView代理协议
- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    [self hideBrandPickView];
}

- (void)customPickViewCancleTouch:(CustomPickView *)customPickView{
    [self hideBrandPickView];
}

#pragma mark - 返回数据
- (void)response:(NSURLResponse *)response andError:(NSError *)error andData:(NSData *)data andStatusCode:(NSInteger)statusCode andURLString:(NSString *)urlString{
    if(statusCode==200 && !error){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
    }else{
        NSLog(@"%@",error);
        [self.view addSubview:[CustomPopupView customPopupViewWithMsg:FINAL_DATA_REQUEST_FAIL]];
        [self.mainView.mj_header endRefreshing];
        [self.mainView.mj_footer endRefreshing];
    }
}

#pragma mark - 懒加载
- (RequestUtil *)requestUtil{
    if(_requestUtil == nil){
        _requestUtil = [[RequestUtil alloc]init];
        _requestUtil.delegate = self;
    }
    return _requestUtil;
}

- (NSMutableArray<PileVillageInfo *> *)dataArray{
    if(_dataArray == nil){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSMutableDictionary *)collectionDictionary {
    if (_collectionDictionary == nil) {
        _collectionDictionary = [NSMutableDictionary dictionary];
    }
    return _collectionDictionary;
}

- (NSMutableDictionary *)villageDictionary {
    if (_villageDictionary == nil) {
        _villageDictionary= [NSMutableDictionary dictionary];
    }
    return _villageDictionary;
}

- (NSMutableArray *)sitesArray {
    if (_sitesArray == nil) {
        _sitesArray = [NSMutableArray array];
    }
    return _sitesArray;
}

- (NSMutableArray *)parkingsArray {
    if (_parkingsArray == nil) {
        _parkingsArray = [NSMutableArray array];
    }
    return _parkingsArray;
}

- (CustomChooseCityView *)chooseCityView{
    if(_chooseCityView == nil){
        CustomChooseCityView *chooseCityView = [[CustomChooseCityView alloc]initWithFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        chooseCityView.delegate = self;
        [self.view addSubview:chooseCityView];
        _chooseCityView=chooseCityView;
    }
    return _chooseCityView;
}

- (CustomPickView *)brandPickView{
    if(_brandPickView == nil){
        CustomPickView *pickView = [CustomPickView customPickViewWithDataArray:self.pileBrandArray andComponent:1 andIsDependPre:NO andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.titleKey = @"name";
        pickView.delegate = self;
        pickView.transform = CGAffineTransformTranslate(pickView.transform, 0, HEIGHT);
        [self.view addSubview:pickView];
        _brandPickView = pickView;
    }
    return _brandPickView;
}

- (NSArray *)pileBrandArray{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSArray * tmpArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"charging_mouth_tyoe.plist" ofType:nil]];
    for (NSDictionary *dict in tmpArray) {
        [array addObject:[PileBrand pileBrandWithDict:dict]];
    }
    return array;
}

#pragma mark - 系统代理
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mainView reloadData];
    [AppDelegate customTabbar].hidden=NO;
}

@end
