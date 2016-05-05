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
    [PPNetworkingHelper uploadDataWithInfo:_dataDic andFinishBlock:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"tmd = %@",responseObject);
        }else{
            NSLog(@"123 = %@",error);
        }
    }];
}

#pragma mark - 整理上传数据
- (void)dealUpLoadData:(NSInteger)num{
    
    /**
     *  整理数据
     */
    if (self.dataArray.count) {
        
        PileVillageInfo *pileInfo = self.dataArray[num];
        self.dataDic = [NSMutableDictionary dictionary];
        
        // 小区数据
        NSMutableDictionary *villageDic = [NSMutableDictionary dictionary];
        _dataDic[@"pile_village"] = villageDic;
        PileVillageBasicInfo *pile_village = pileInfo.pile_village;
        villageDic[@"id"] = [NSString stringWithFormat:@"%ld", pile_village.Id];
        villageDic[@"villageId"] = [NSString stringWithFormat:@"%ld", pile_village.villageId];
        villageDic[@"imageUrl1"] = pile_village.imageUrl1;
        villageDic[@"imageUrl2"] = pile_village.imageUrl2;
        villageDic[@"comment1"] = pile_village.comment2;
        
        // 电桩数据
        NSMutableArray *siteArr = pileInfo.sites;
        _dataDic[@"sites"] = siteArr;
        for (int i = 0; i < siteArr.count; i++) {
            PileGroupInfo *pileGroupInfo = siteArr[i];
            NSMutableDictionary *sitesDic = [NSMutableDictionary dictionary];
            [siteArr addObject:sitesDic];
            
            // 电桩位置
            NSMutableDictionary *pileSiteDic = [NSMutableDictionary dictionary];
            sitesDic[@"pile_site"] = pileSiteDic;
            pileSiteDic[@"id"] = [NSString stringWithFormat:@"%ld", pileGroupInfo.pile_site.Id];
            pileSiteDic[@"villageId"] = [NSString stringWithFormat:@"%ld", pile_village.villageId];
            pileSiteDic[@"siteName"] = pile_village.villageName;
            pileSiteDic[@"x"] = pileGroupInfo.pile_site.x;
            pileSiteDic[@"y"] = pileGroupInfo.pile_site.y;
        
            // 电桩车位
            NSMutableDictionary *pileSpaceDic = [NSMutableDictionary dictionary];
            sitesDic[@"pile_space"] = pileSpaceDic;
            pileSpaceDic[@"id"] = [NSString stringWithFormat:@"%ld", pileGroupInfo.pile_space.Id];
            pileSpaceDic[@"pileSiteId"] = [NSString stringWithFormat:@"%ld", pileGroupInfo.pile_space.pileSiteId];
            pileSpaceDic[@"comment3"] = pileGroupInfo.pile_space.comment3;
            pileSpaceDic[@"comment4"] = pileGroupInfo.pile_space.comment4;
            pileSpaceDic[@"comment5"] = pileGroupInfo.pile_space.comment5;
            pileSpaceDic[@"comment6"] = pileGroupInfo.pile_space.comment6;
            pileSpaceDic[@"imageUrl3"] = pileGroupInfo.pile_space.imageUrl3;
            pileSpaceDic[@"imageUrl4"] = pileGroupInfo.pile_space.imageUrl4;
            pileSpaceDic[@"imageUrl5"] = pileGroupInfo.pile_space.imageUrl5;
            pileSpaceDic[@"imageUrl6"] = pileGroupInfo.pile_space.imageUrl6;
            pileSpaceDic[@"bnum"] = pileGroupInfo.pile_space.bnum;
            pileSpaceDic[@"snum"] = pileGroupInfo.pile_space.snum;
            pileSpaceDic[@"mnum"] = pileGroupInfo.pile_space.mnum;
            pileSpaceDic[@"tnum"] = pileGroupInfo.pile_space.tnum;
            pileSpaceDic[@"comment"] = pileGroupInfo.pile_space.comment;
            
            
            // 电桩新增电桩
            NSMutableArray *pilesPilesArr = pileGroupInfo.piles;
            [sitesDic setObject:pilesPilesArr forKey:@"piles"];
            for (int i = 0; i < pilesPilesArr.count; i++) {
                Pile *pile = pilesPilesArr[i];
                NSMutableDictionary *pileDataDic = [NSMutableDictionary dictionary];
                [pilesPilesArr addObject:pileDataDic];
                
                // 新增电桩
                NSMutableDictionary *pilePileDic = [NSMutableDictionary dictionary];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.Id] forKey:@"id"];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileSiteId] forKey:@"pileSiteId"];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileResourceBrandId] forKey:@"pileResourceBrandId"];
                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileResourceOperatorId] forKey:@"pile.pile_pile.pileResourceOperatorId"];
                [pilePileDic setObject:pile.pile_pile.imageUrl7 forKey:@"imageUrl7"];
                [pilePileDic setObject:pile.pile_pile.comment7 forKey:@"comment7"];
                [pileDataDic setObject:pilePileDic forKey:@"pile_pile"];
                
                NSMutableArray *interfaceDataArr = pile.interfaces;
                [pileDataDic setObject:interfaceDataArr forKey:@"interfaces"];
                for (int i = 0; i < interfaceDataArr.count; i++) {
                    PileInterface *interface = interfaceDataArr[i];
                    NSMutableDictionary *interfaceDataDic = [NSMutableDictionary dictionary];
                    [interfaceDataArr addObject:interfaceDataDic];
                    
                    // 新增接口
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
        
        /**
         *  收费标准数据存储
         */
        NSMutableArray *parkingsDataArr = pileInfo.parkings;
        [_dataDic setObject:parkingsDataArr forKey:@"parkings"];
        for (int i = 0; i <parkingsDataArr.count; i++) {
            ParkingChargeStandard *parkingChargeStandard = parkingsDataArr[i];
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

    }
}

#pragma mark - 数据上传
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
    
    NSLog(@"-------------%@", formData);
    
    // 2.创建请求
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:UPLOAD_PILE_DATA parameters:formData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } error:nil];
    [request setHTTPMethod:@"POST"];
    
    // 3.创建数据数据上传任务
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:finishBlock];
    
    // 4.开始上传数据
    [uploadTask resume];
}

//- (void)upLoadData{
//
//    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"userId",@"0",@"provinceid",@"0", @"cityid",@"0",@"districtid",@"0",@"areaid", self.json1, @"pile_village",self.json2,@"sites",self.json3,@"parkings",nil];
////    NSDictionary * headerDict = @{@"__provinceid":@(0),@"__cityid":@(0),@"__districtid":@(0),@"__areaid":@(0),@"__villageid":@(0)};
////    self.requestUtil.headerDict = headerDict;
//
//    [self.requestUtil uploadDataWithUrl:UPLOAD_PILE_DATA andParameters:dic andTimeoutInterval:20];
//
//}

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

- (void)nslog{
    
    //NSLog(@"Id = %ld, villageId = %ld, comment1 = %@, comment2 = %@, imageUrl1 = %@, imageUrl2 = %@,",pile_village.Id,pile_village.villageId,pile_village.comment1,pile_village.comment2,pile_village.imageUrl1, pile_village.imageUrl2);
    
    
    // 存储数据的大字典
    //self.dataDic = [NSMutableDictionary dictionary];
    //[_dataDic setObject:villageDic forKey:@"pile_village"];
    
    
    //NSData *villageData = [NSJSONSerialization dataWithJSONObject:villageDic options:NSJSONWritingPrettyPrinted error:nil];
    //self.json1 = [[NSString alloc] initWithData:villageData encoding:NSUTF8StringEncoding];
    
    
    //        NSData *siteData = [NSJSONSerialization dataWithJSONObject:siteDataArr options:NSJSONWritingPrettyPrinted error:nil];
    //        self.json2 = [[NSString alloc] initWithData:siteData encoding:NSUTF8StringEncoding];
    
    
    //        /**
    //         *  收费标准数据存储
    //         */
    //        NSMutableArray<ParkingChargeStandard *> *parkings = pileInfo.parkings;
    //        NSMutableArray *parkingsDataArr = [NSMutableArray array];
    //        //[_dataDic setObject:parkingsDataArr forKey:@"parkings"];
    //        for (int i = 0; i < parkings.count; i++) {
    //            ParkingChargeStandard *parkingChargeStandard = parkings[i];
    //            NSMutableDictionary *parkingsDic = [NSMutableDictionary dictionary];
    //            [parkingsDic setObject:[NSString stringWithFormat:@"%ld", parkingChargeStandard.Id] forKey:@"id"];
    //            [parkingsDic setObject:parkingChargeStandard.parkingName forKey:@"parkingName"];
    //            [parkingsDic setObject:[NSString stringWithFormat:@"%ld", parkingChargeStandard.villageId] forKey:@"villageId"];
    //            [parkingsDic setObject:parkingChargeStandard.openIntervalWork forKey:@"openIntervalWork"];
    //            [parkingsDic setObject:parkingChargeStandard.openIntervalNowork forKey:@"openIntervalNowork"];
    //            [parkingsDic setObject:parkingChargeStandard.openComment forKey:@"openComment"];
    //            [parkingsDic setObject:parkingChargeStandard.tariffType forKey:@"tariffType"];
    //            [parkingsDic setObject:parkingChargeStandard.tariffTypeUnify forKey:@"tariffTypeUnify"];
    //            [parkingsDic setObject:parkingChargeStandard.tariffTypeSplit forKey:@"tariffTypeSplit"];
    //            [parkingsDic setObject:parkingChargeStandard.tariffTypeLadder forKey:@"tariffTypeLadder"];
    //            [parkingsDic setObject:parkingChargeStandard.comment forKey:@"comment"];
    //            [parkingsDic setObject:parkingChargeStandard.comment10 forKey:@"comment10"];
    //            [parkingsDic setObject:parkingChargeStandard.imageUrl0 forKey:@"imageUrl0"];
    //            [parkingsDataArr addObject:parkingsDic];
    //        }
    //        NSData *parkingsData = [NSJSONSerialization dataWithJSONObject:parkingsDataArr options:NSJSONWritingPrettyPrinted error:nil];
    //        self.json3 = [[NSString alloc] initWithData:parkingsData encoding:NSUTF8StringEncoding];
    
    //[_dataDic setObject:siteDataArr forKey:@"sites"];
    
    //            NSMutableArray<Pile *> *piles = pileGroupInfo.piles;
    //            NSMutableArray *pilesDataArr = [NSMutableArray array];
    //            //[sitesDataDic setObject:pilesDataArr forKey:@"piles"];
    //            for (int i = 0; i < piles.count; i++) {
    //                Pile *pile = piles[i];
    //                NSMutableDictionary *pileDataDic = [NSMutableDictionary dictionary];
    //                [pilesDataArr addObject:pileDataDic];
    //
    //                // 新增电桩
    //                NSMutableDictionary *pilePileDic = [NSMutableDictionary dictionary];
    //                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.Id] forKey:@"id"];
    //                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileSiteId] forKey:@"pileSiteId"];
    //                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileResourceBrandId] forKey:@"pileResourceBrandId"];
    //                [pilePileDic setObject:[NSString stringWithFormat:@"%ld", pile.pile_pile.pileResourceOperatorId] forKey:@"pile.pile_pile.pileResourceOperatorId"];
    //                [pilePileDic setObject:pile.pile_pile.imageUrl7 forKey:@"imageUrl7"];
    //                [pilePileDic setObject:pile.pile_pile.comment7 forKey:@"comment7"];
    //                [pileDataDic setObject:pilePileDic forKey:@"pile_pile"];
    //
    //                NSMutableArray<PileInterface *> *interfaces = pile.interfaces;
    //                NSMutableArray *interfaceDataArr = [NSMutableArray array];
    //                [pileDataDic setObject:interfaceDataArr forKey:@"interfaces"];
    //                for (int i = 0; i < interfaces.count; i++) {
    //                    PileInterface *interface = interfaces[i];
    //                    NSMutableDictionary *interfaceDataDic = [NSMutableDictionary dictionary];
    //                    [interfaceDataArr addObject:interfaceDataDic];
    //
    //                    // 新增接口
    //                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.Id] forKey:@"id"];
    //                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.pileId] forKey:@"pileId"];
    //                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.pileResourceInterfaceId] forKey:@"pileResourceInterfaceId"];
    //                    [interfaceDataDic setObject:interface.tariffService forKey:@"tariffService"];
    //                    [interfaceDataDic setObject:interface.num forKey:@"num"];
    //                    [interfaceDataDic setObject:interface.weight forKey:@"weight"];
    //                    [interfaceDataDic setObject:[NSString stringWithFormat:@"%ld", interface.hasChargeCable] forKey:@"hasChargeCable"];
    //                    [interfaceDataDic setObject:interface.voltage forKey:@"voltage"];
    //                    [interfaceDataDic setObject:interface.current forKey:@"current"];
    //                    [interfaceDataDic setObject:interface.tariffChargeBusy forKey:@"tariffChargeBusy"];
    //                    [interfaceDataDic setObject:interface.tariffChargeBusyInterval forKey:@"tariffChargeBusyInterval"];
    //                    [interfaceDataDic setObject:interface.tariffChargeIdle forKey:@"tariffChargeIdle"];
    //                    [interfaceDataDic setObject:interface.tariffChargeIdleInterval forKey:@"tariffChargeIdleInterval"];
    //                    [interfaceDataDic setObject:interface.paymentType forKey:@"paymentType"];
    //                    [interfaceDataDic setObject:interface.imageUrl8 forKey:@"imageUrl8"];
    //                    [interfaceDataDic setObject:interface.comment8 forKey:@"comment8"];
    //                    [interfaceDataDic setObject:interface.imageUrl9 forKey:@"imageUrl9"];
    //                    [interfaceDataDic setObject:interface.comment9 forKey:@"comment9"];
    //                    [interfaceDataDic setObject:interface.comment forKey:@"comment"];
    //                }
    //            }
    
    
    //    // 电桩车位
    //    NSMutableDictionary *pileSpaceDic = [NSMutableDictionary dictionary];
    //    [pileSpaceDic setObject:[NSString stringWithFormat:@"%ld", pileGroupInfo.pile_space.Id] forKey:@"id"];
    //    [pileSpaceDic setObject:[NSString stringWithFormat:@"%ld", pileGroupInfo.pile_space.pileSiteId] forKey:@"pileSiteId"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.comment3 forKey:@"comment3"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl3 forKey:@"imageUrl3"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.comment4 forKey:@"comment4"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl4 forKey:@"imageUrl4"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.comment5 forKey:@"comment5"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl5 forKey:@"imageUrl5"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.comment6 forKey:@"comment6"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.imageUrl6 forKey:@"imageUrl6"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.comment forKey:@"comment"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.bnum forKey:@"bnum"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.snum forKey:@"snum"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.mnum forKey:@"mnum"];
    //    [pileSpaceDic setObject:pileGroupInfo.pile_space.tnum forKey:@"tnum"];
    //    [sitesDic setObject:pileSpaceDic forKey:@"pile_space"];
    
    
    //NSLog(@"id = %ld,villageId = %ld,siteName = %@,x = %@,y = %@",pileGroupInfo.pile_site.Id,pile_village.villageId,pile_village.villageName,pileGroupInfo.pile_site.x,pileGroupInfo.pile_site.y);
    
    //            NSLog(@"id=%ld,pileSiteId=%ld,comment3=%@,comment4=%@,comment5=%@,comment6=%@,imageUrl3=%@,imageUrl4=%@,imageUrl5=%@,imageUrl6=%@,bnum=%@,snum=%@,mnum=%@,tnum=%@,comment=%@",pileGroupInfo.pile_space.Id,pileGroupInfo.pile_space.pileSiteId,pileGroupInfo.pile_space.comment3,pileGroupInfo.pile_space.comment4,pileGroupInfo.pile_space.comment5,pileGroupInfo.pile_space.comment6,pileGroupInfo.pile_space.imageUrl3,pileGroupInfo.pile_space.imageUrl4,pileGroupInfo.pile_space.imageUrl5,pileGroupInfo.pile_space.imageUrl6,pileGroupInfo.pile_space.bnum,pileGroupInfo.pile_space.snum,pileGroupInfo.pile_space.mnum,pileGroupInfo.pile_space.tnum,pileGroupInfo.pile_space.comment);
    
    //[villageDic setObject:[NSString stringWithFormat:@"%ld", pile_village.Id] forKey:@"id"];
    //[villageDic setObject:[NSString stringWithFormat:@"%ld", pile_village.villageId] forKey:@"villageId"];
    //[villageDic setObject:pile_village.imageUrl1 forKey:@"imageUrl1"];
    //[villageDic setObject:pile_village.imageUrl2 forKey:@"imageUrl2"];
    //[villageDic setObject:pile_village.comment1 forKey:@"comment1"];
    //[villageDic setObject:pile_village.comment2 forKey:@"comment2"];
    
}


@end
