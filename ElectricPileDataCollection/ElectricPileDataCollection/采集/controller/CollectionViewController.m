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

@interface CollectionViewController ()<RequestUtilDelegate,CollectionMainViewDelegate,CustomChooseCityViewDelegate,CustomPickViewDelegate>

@property(nonatomic,strong)RequestUtil * requestUtil;

@property(nonatomic,strong)NSMutableArray <PileVillageInfo *> *dataArray;

@property(nonatomic,weak) CollectionMainView * mainView;

@property(nonatomic,weak)CustomChooseCityView * chooseCityView;

@property(nonatomic,weak)CustomPickView * brandPickView;

@property(nonatomic,strong)NSArray * pileBrandArray;

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
    
    if (self.dataArray.count) {
        
        PileVillageInfo *pileInfo = self.dataArray[num];
        
        PileVillageBasicInfo *pile_village = pileInfo.pile_village;
        NSLog(@"id = %ld, villageId = %ld, comment1 = %@, comment2 = %@, villageName = %@", pile_village.Id, pile_village.villageId, pile_village.comment1, pile_village.comment2, pile_village.villageName);
        
        NSMutableArray<PileGroupInfo *> *sites = pileInfo.sites;
        
        for (int i = 0; i < sites.count; i++) {
            PileGroupInfo *pileGroupInfo = sites[i];
            NSLog(@"pileSiteId = %ld, villageId = %ld, siteName = %@, x = %@, y = %@",pileGroupInfo.pile_site.Id, pile_village.villageId, pile_village.villageName, pileGroupInfo.pile_site.x, pileGroupInfo.pile_site.y);
            
            NSLog(@"spaceId = %ld, pileSiteId = %ld, comment3 = %@, comment4 = %@, comment5 = %@, comment6 = %@, comment = %@, bnum = %@, mnum = %@, snum = %@, tnum = %@, imageUrl3 = %@, imageUrl4 = %@, imageUrl5 = %@, imageUrl6 = %@", pileGroupInfo.pile_space.Id, pileGroupInfo.pile_space.pileSiteId, pileGroupInfo.pile_space.comment3, pileGroupInfo.pile_space.comment4, pileGroupInfo.pile_space.comment5, pileGroupInfo.pile_space.comment6, pileGroupInfo.pile_space.comment, pileGroupInfo.pile_space.bnum, pileGroupInfo.pile_space.snum, pileGroupInfo.pile_space.mnum, pileGroupInfo.pile_space.tnum, pileGroupInfo.pile_space.imageUrl3, pileGroupInfo.pile_space.imageUrl4, pileGroupInfo.pile_space.imageUrl5, pileGroupInfo.pile_space.imageUrl6);
            
            NSMutableArray<Pile *> *piles = pileGroupInfo.piles;
            for (int i = 0; i < piles.count; i++) {
                Pile *pile = piles[i];
                NSLog(@"pildId = %ld, pileSiteId = %ld, pileResourceBrandId = %ld, pileResourceOperatorId = %ld, imageUrl7 = %@ ,comment7 = %@", pile.pile_pile.Id, pile.pile_pile.pileSiteId, pile.pile_pile.pileResourceBrandId, pile.pile_pile.pileResourceOperatorId, pile.pile_pile.imageUrl7, pile.pile_pile.comment7);
                
                NSMutableArray<PileInterface *> *interfaces = pile.interfaces;
                for (int i = 0; i < interfaces.count; i++) {
                    PileInterface *interface = interfaces[i];
                    NSLog(@"pileInterfaceIds = %ld, pileId = %ld, pileResourceInterfaceId = %ld, tariffService = %@, num = %@, weight = %@, hasChargeCable = %ld, voltage = %@, current = %@, tariffChargeBusy = %@, tariffChargeBusyInterval = %@， tariffChargeIdle = %@, tariffChargeIdleInterval = %@, paymentType = %@, imageUrl8 = %@, imageUrl9 = %@, comment8 = %@, comment9 = %@, comment = %@", interface.Id, interface.pileId, interface.pileResourceInterfaceId, interface.tariffService, interface.num, interface.weight, interface.hasChargeCable, interface.voltage, interface.current,interface.tariffChargeBusy, interface.tariffChargeBusyInterval, interface.tariffChargeIdle, interface.tariffChargeIdleInterval, interface.paymentType, interface.imageUrl8, interface.imageUrl9, interface.comment8, interface.comment9, interface.comment);
                }
            }
        }
        NSMutableArray<ParkingChargeStandard *> *parkings = pileInfo.parkings;
        for (int i = 0; i < parkings.count; i++) {
            ParkingChargeStandard *parkingChargeStandard = parkings[i];
            NSLog(@"parkingsId = %ld, parkingName = %@, villageId = %ld, openIntervalWork = %@, openIntervalNowork = %@, openComment = %@, tariffType = %@, tariffTypeUnity = %@, tariffTypeSplit = %@, tariffTypeLadder = %@, comment = %@, comment10 = %@", parkingChargeStandard.Id, parkingChargeStandard.parkingName, parkingChargeStandard.villageId, parkingChargeStandard.openIntervalWork, parkingChargeStandard.openIntervalNowork, parkingChargeStandard.openComment, parkingChargeStandard.tariffType, parkingChargeStandard.tariffTypeUnify, parkingChargeStandard.tariffTypeSplit, parkingChargeStandard.tariffTypeLadder, parkingChargeStandard.comment, parkingChargeStandard.comment10);
        }
    }
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
