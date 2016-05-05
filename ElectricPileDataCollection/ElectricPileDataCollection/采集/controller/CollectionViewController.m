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
 *  数据总字典
 */
@property (strong, nonatomic) NSMutableDictionary *dataDic;

@property (copy, nonatomic) NSString *json1;

@property (copy, nonatomic) NSString *json2;

@property (copy, nonatomic) NSString *json3;

@end

@implementation CollectionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
    [self downloadData];
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
    
    [self dealUpLoadData:num];
    [self upLoadData];
    
//    [PPNetworkingHelper uploadDataWithInfo:_dataDic andFinishBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"上传失败:%@", error);
//        }else{
//            NSLog(@"上传成功:%@", responseObject);
//        }
//    }];
    
}

#pragma mark - 处理上传数据
- (void)dealUpLoadData:(NSInteger)num{
    
    /**
     *  处理数据
     */
    if (self.dataArray.count) {
        
        PileVillageInfo *pileInfo = self.dataArray[num];
        
        // 存储数据的大字典
        //self.dataDic = [NSMutableDictionary dictionary];
        
        PileVillageBasicInfo *pile_village = pileInfo.pile_village;
        /**
         *  小区存储数据
         */
        NSMutableDictionary *villageDic = [NSMutableDictionary dictionary];
        [villageDic setObject:[NSString stringWithFormat:@"%ld", pile_village.Id] forKey:@"id"];
        [villageDic setObject:[NSString stringWithFormat:@"%ld", pile_village.villageId] forKey:@"villageId"];
        [villageDic setObject:pile_village.comment1 forKey:@"comment1"];
        [villageDic setObject:pile_village.comment2 forKey:@"comment2"];
        //[_dataDic setObject:villageDic forKey:@"pile_village"];
        
        NSData *villageData = [NSJSONSerialization dataWithJSONObject:villageDic options:NSJSONWritingPrettyPrinted error:nil];
        self.json1 = [[NSString alloc] initWithData:villageData encoding:NSUTF8StringEncoding];
        
        /**
         *  电桩组存储数据
         */
        NSMutableArray<PileGroupInfo *> *sites = pileInfo.sites;
        NSMutableArray *siteDataArr = [NSMutableArray array];
        //[_dataDic setObject:siteDataArr forKey:@"sites"];
        for (int i = 0; i < sites.count; i++) {
            PileGroupInfo *pileGroupInfo = sites[i];
            NSMutableDictionary *sitesDataDic = [NSMutableDictionary dictionary];
            [siteDataArr addObject:sitesDataDic];
            
            /**
             *  电桩位置存储数据
             */
            NSMutableDictionary *pileSiteDic = [NSMutableDictionary dictionary];
            [pileSiteDic setObject:[NSString stringWithFormat:@"%ld", pileGroupInfo.pile_site.Id] forKey:@"id"];
            [pileSiteDic setObject:[NSString stringWithFormat:@"%ld", pile_village.villageId] forKey:@"villageId"];
            [pileSiteDic setObject:pile_village.villageName forKey:@"siteName"];
            [pileSiteDic setObject:pileGroupInfo.pile_site.x forKey:@"x"];
            [pileSiteDic setObject:pileGroupInfo.pile_site.y forKey:@"y"];
            [sitesDataDic setObject:pileSiteDic forKey:@"pile_site"];
            
            /**
             *  电桩车位存储数据
             */
            NSMutableDictionary *pileSpaceDic = [NSMutableDictionary dictionary];
            [pileSpaceDic setObject:[NSString stringWithFormat:@"%ld", pileGroupInfo.pile_space.Id] forKey:@"id"];
            [pileSpaceDic setObject:[NSString stringWithFormat:@"%ld", pileGroupInfo.pile_space.pileSiteId] forKey:@"pileSiteId"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.comment3 forKey:@"comment3"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl3 forKey:@"imageUrl3"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.comment4 forKey:@"comment4"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl4 forKey:@"imageUrl4"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.comment5 forKey:@"comment5"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl5 forKey:@"imageUrl5"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.comment6 forKey:@"comment6"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl6 forKey:@"imageUrl6"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.comment forKey:@"comment"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.bnum forKey:@"bnum"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.snum forKey:@"snum"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.mnum forKey:@"mnum"];
            [pileSpaceDic setObject:pileGroupInfo.pile_space.tnum forKey:@"tnum"];
            [sitesDataDic setObject:pileSpaceDic forKey:@"pile_space"];
            
            NSMutableArray<Pile *> *piles = pileGroupInfo.piles;
            NSMutableArray *pilesDataArr = [NSMutableArray array];
            [sitesDataDic setObject:pilesDataArr forKey:@"piles"];
            for (int i = 0; i < piles.count; i++) {
                Pile *pile = piles[i];
                NSMutableDictionary *pileDataDic = [NSMutableDictionary dictionary];
                [pilesDataArr addObject:pileDataDic];
                
                /**
                 *  电桩信息存储数据
                 */
                NSMutableDictionary *pilePileDic = [NSMutableDictionary dictionary];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.Id] forKey:@"id"];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileSiteId] forKey:@"pileSiteId"];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileResourceBrandId] forKey:@"pileResourceBrandId"];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileResourceOperatorId] forKey:@"pile.pile_pile.pileResourceOperatorId"];
                [pilePileDic setObject:pile.pile_pile.imageUrl7 forKey:@"imageUrl7"];
                [pilePileDic setObject:pile.pile_pile.comment7 forKey:@"comment7"];
                [pileDataDic setObject:pilePileDic forKey:@"pile_pile"];
                
                NSMutableArray<PileInterface *> *interfaces = pile.interfaces;
                NSMutableArray *interfaceDataArr = [NSMutableArray array];
                [pileDataDic setObject:interfaceDataArr forKey:@"interfaces"];
                for (int i = 0; i < interfaces.count; i++) {
                    PileInterface *interface = interfaces[i];
                    NSMutableDictionary *interfaceDataDic = [NSMutableDictionary dictionary];
                    [interfaceDataArr addObject:interfaceDataDic];
                    
                    /**
                     *  接口信息存储数据
                     */
                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.Id] forKey:@"id"];
                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.pileId] forKey:@"pileId"];
                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.pileResourceInterfaceId] forKey:@"pileResourceInterfaceId"];
                    [interfaceDataDic setObject:interface.tariffService forKey:@"tariffService"];
                    [interfaceDataDic setObject:interface.num forKey:@"num"];
                    [interfaceDataDic setObject:interface.weight forKey:@"weight"];
                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.hasChargeCable] forKey:@"hasChargeCable"];
                    [interfaceDataDic setObject:interface.voltage forKey:@"voltage"];
                    [interfaceDataDic setObject:interface.current forKey:@"current"];
                    [interfaceDataDic setObject:interface.tariffChargeBusy forKey:@"tariffChargeBusy"];
                    [interfaceDataDic setObject:interface.tariffChargeBusyInterval forKey:@"tariffChargeBusyInterval"];
                    [interfaceDataDic setObject:interface.tariffChargeIdle forKey:@"tariffChargeIdle"];
                    [interfaceDataDic setObject:interface.tariffChargeIdleInterval forKey:@"tariffChargeIdleInterval"];
                    [interfaceDataDic setObject:interface.paymentType forKey:@"paymentType"];
                    [interfaceDataDic setObject:interface.imageUrl8 forKey:@"imageUrl8"];
                    [interfaceDataDic setObject:interface.comment8 forKey:@"comment8"];
                    [interfaceDataDic setObject:interface.imageUrl9 forKey:@"imageUrl9"];
                    [interfaceDataDic setObject:interface.comment9 forKey:@"comment9"];
                    [interfaceDataDic setObject:interface.comment forKey:@"comment"];
                }
            }
        }
        NSData *siteData = [NSJSONSerialization dataWithJSONObject:siteDataArr options:NSJSONWritingPrettyPrinted error:nil];
        self.json2 = [[NSString alloc] initWithData:siteData encoding:NSUTF8StringEncoding];
        
        
        /**
         *  收费标准数据存储
         */
        NSMutableArray<ParkingChargeStandard *> *parkings = pileInfo.parkings;
        NSMutableArray *parkingsDataArr = [NSMutableArray array];
        //[_dataDic setObject:parkingsDataArr forKey:@"parkings"];
        for (int i = 0; i < parkings.count; i++) {
            ParkingChargeStandard *parkingChargeStandard = parkings[i];
            NSMutableDictionary *parkingsDic = [NSMutableDictionary dictionary];
            [parkingsDic setObject:[NSString stringWithFormat:@"%ld", parkingChargeStandard.Id] forKey:@"id"];
            [parkingsDic setObject:parkingChargeStandard.parkingName forKey:@"parkingName"];
            [parkingsDic setObject:[NSString stringWithFormat:@"%ld", parkingChargeStandard.villageId] forKey:@"villageId"];
            [parkingsDic setObject:parkingChargeStandard.openIntervalWork forKey:@"openIntervalWork"];
            [parkingsDic setObject:parkingChargeStandard.openIntervalNowork forKey:@"openIntervalNowork"];
            [parkingsDic setObject:parkingChargeStandard.openComment forKey:@"openComment"];
            [parkingsDic setObject:parkingChargeStandard.tariffType forKey:@"tariffType"];
            [parkingsDic setObject:parkingChargeStandard.tariffTypeUnify forKey:@"tariffTypeUnify"];
            [parkingsDic setObject:parkingChargeStandard.tariffTypeSplit forKey:@"tariffTypeSplit"];
            [parkingsDic setObject:parkingChargeStandard.tariffTypeLadder forKey:@"tariffTypeLadder"];
            [parkingsDic setObject:parkingChargeStandard.comment forKey:@"comment"];
            [parkingsDic setObject:parkingChargeStandard.comment10 forKey:@"comment10"];
            [parkingsDic setObject:parkingChargeStandard.imageUrl0 forKey:@"imageUrl0"];
            [parkingsDataArr addObject:parkingsDic];
        }
        NSData *parkingsData = [NSJSONSerialization dataWithJSONObject:parkingsDataArr options:NSJSONWritingPrettyPrinted error:nil];
        self.json3 = [[NSString alloc] initWithData:parkingsData encoding:NSUTF8StringEncoding];
        
    }
}

//#pragma mark - 数据上传
//+ (void)uploadDataWithInfo:(NSDictionary *)dict andFinishBlock:(nullable void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))finishBlock {
//    
//    // 1.格式转换
//    NSMutableDictionary *formData = [[NSMutableDictionary alloc]init];
//    NSArray *keyList = [dict allKeys];
//    for (NSString *key in keyList) {
//        
//        id value = dict[key];
//        
//        if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
//            formData[key] = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
//        }
//        else {
//            formData[key] = value;
//        }
//    }
//    
//    NSLog(@"-------------%@", formData);
//    
//    // 2.创建请求
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:UPLOAD_PILE_DATA parameters:formData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    } error:nil];
//    [request setHTTPMethod:@"POST"];
//    
//    // 3.创建数据数据上传任务
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:finishBlock];
//    
//    // 4.开始上传数据
//    [uploadTask resume];
//}

- (void)upLoadData{

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"userId",@"0",@"provinceid",@"0", @"cityid",@"0",@"districtid",@"0",@"areaid", self.json1, @"pile_village",self.json2,@"sites",self.json3,@"parkings",nil];

    RequestUtil * requestUtil =[[RequestUtil alloc]init];
    requestUtil.delegate=self;
    [requestUtil uploadDataWithUrl:UPLOAD_PILE_DATA andParameters:dic andTimeoutInterval:20];

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:UPLOAD_PILE_DATA parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        // 拼接data到请求体
//        formData appendPartWithFormData:(nonnull NSData *) name:(nonnull NSString *)
//        self.villageJson, @"pile_village",self.pileJson,@"sites",self.chargeStandardJson,@"parkings";
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        // 获取上传进度
//        NSLog(@"%@", uploadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 数据上传成功
//        NSLog(@"成功后返回:%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //数据上传失败
//        NSLog(@"失败后返回:%@", error);
//    }];
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

#pragma mark - 下载数据
- (void)downloadData{
    //数据请求
//    [self.requestUtil asyncThirdLibWithUrl:PIC_SCORE_DETAIL_URL andParameters:[RequestUtil getParamsWithString:params] andMethod:RequestMethodPost andTimeoutInterval:10];
}

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
