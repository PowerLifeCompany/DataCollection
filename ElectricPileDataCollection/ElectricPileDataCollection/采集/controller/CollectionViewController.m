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

@interface CollectionViewController ()<RequestUtilDelegate,CollectionMainViewDelegate,CustomChooseCityViewDelegate,CustomPickViewDelegate>

@property(nonatomic,strong)RequestUtil * requestUtil;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,weak) CollectionMainView * mainView;

@property(nonatomic,weak)CustomChooseCityView * chooseCityView;

@property(nonatomic,weak)CustomPickView * brandPickView;

@property(nonatomic,strong)NSArray * pileBrandArray;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
    [self downloadData];
}

#pragma mark - 初始化组件
- (void)loadMainView{
    /**
     加载主mainView，MVC分开来
     */
//    CollectionMainView * mainView=[[CollectionMainView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStyleGrouped];
//    mainView.mainViewDelegate=self;
//    [self.view addSubview:mainView];
//    self.mainView=mainView;
//    self.mainView.dataArray=@[@"",@"",@"",@"",@""];
    /**
     *  使用懒加载的方式，选择城市
     */
//    [self.view addSubview:self.chooseCityView];
    /**
     *  懒加载，选择品牌运营商
     */
//    [self.view addSubview:self.brandPickView];
//    [self showBrandPickView];
}

- (void)loadNavigationBar{
    self.navigationItem.title=@"数据列表";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[[CollPileViewController alloc]init] animated:YES];
}

#pragma mark - mainView代理
-(void)itemSelectedWithMainView:(CollectionMainView *)mainView andIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)refreshWithMainView:(CollectionMainView *)mainView andRefreshComponent:(MJRefreshComponent *)baseView{
    [mainView.mj_header endRefreshing];
}

#pragma mark - custom方法
- (void)showBrandPickView{
    [UIView animateWithDuration:0.5 animations:^{
        self.brandPickView.transform=CGAffineTransformIdentity;
    }];
}

- (void)hideBrandPickView{
    [UIView animateWithDuration:0.5 animations:^{
        self.brandPickView.transform=CGAffineTransformTranslate(self.brandPickView.transform, 0, HEIGHT);
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
    if(_requestUtil==nil){
        _requestUtil=[[RequestUtil alloc]init];
        _requestUtil.delegate=self;
    }
    return _requestUtil;
}

- (NSMutableArray *)dataArray{
    if(_dataArray==nil){
        _dataArray=[NSMutableArray new];
    }
    return _dataArray;
}

- (CustomChooseCityView *)chooseCityView{
    if(_chooseCityView==nil){
        CustomChooseCityView * chooseCityView=[[CustomChooseCityView alloc]initWithFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        chooseCityView.delegate=self;
        [self.view addSubview:chooseCityView];
        _chooseCityView=chooseCityView;
    }
    return _chooseCityView;
}

- (CustomPickView *)brandPickView{
    if(_brandPickView==nil){
        CustomPickView * pickView=[CustomPickView customPickViewWithDataArray:self.pileBrandArray andComponent:1 andIsDependPre:NO andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.titleKey=@"name";
        pickView.delegate=self;
        pickView.transform=CGAffineTransformTranslate(pickView.transform, 0, HEIGHT);
        [self.view addSubview:pickView];
        _brandPickView=pickView;
    }
    return _brandPickView;
}

- (NSArray *)pileBrandArray{
    NSMutableArray * array=[[NSMutableArray alloc]init];
    NSArray * tmpArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"charging_mouth_tyoe.plist" ofType:nil]];
    for (NSDictionary * dict in tmpArray) {
        [array addObject:[PileBrand pileBrandWithDict:dict]];
    }
    return array;
}

#pragma mark - 系统代理
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AppDelegate customTabbar].hidden=NO;
}



@end
