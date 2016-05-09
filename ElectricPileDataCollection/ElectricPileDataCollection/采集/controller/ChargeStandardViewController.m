//
//  ChargeStandardViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "ChargeStandardViewController.h"
#import "FeesDetailViewController.h"
#import "ChargeStandardMainView.h"
#import "UIView+LayoutCornerRadius.h"

@interface ChargeStandardViewController ()<ChargeStandardMainViewDelegate>

@property (nonatomic ,weak)ChargeStandardMainView * mainView;

@end

@implementation ChargeStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
}

#pragma mark - 初始化组件
- (void)loadMainView{
    ChargeStandardMainView * mainView=[[ChargeStandardMainView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-214) style:UITableViewStyleGrouped];
    mainView.mainViewDelegate=self;
    [self.view addSubview:mainView];
    self.mainView=mainView;
    self.mainView.dataArray=self.dataArray;
    
#pragma mark - 勿删
    /*
    UIButton * preBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    preBtn.frame=CGRectMake((WIDTH-200)/3.0, HEIGHT-110, 100, 40);
    [self.view addSubview:preBtn];
    [preBtn addTarget:self action:@selector(backToPreviousViewCon) forControlEvents:UIControlEventTouchUpInside];
    preBtn.backgroundColor=[UIColor colorWithRed:0.02f green:0.48f blue:1.00f alpha:1.00f];
    [preBtn setTitle:@"上一步" forState:UIControlStateNormal];
    preBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [preBtn layoutCornerRadiusWithCornerRadius:5];
    self.view.backgroundColor=self.mainView.backgroundColor;
    */
    
    UIButton * saveExitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveExitBtn.frame = CGRectMake(70, HEIGHT-60, WIDTH-140, 40);
    [self.view addSubview:saveExitBtn];
    [saveExitBtn addTarget:self action:@selector(saveExitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    saveExitBtn.backgroundColor = [UIColor colorWithRed:0.02f green:0.48f blue:1.00f alpha:1.00f];;
    [saveExitBtn setTitle:@"保存数据" forState:UIControlStateNormal];
    saveExitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveExitBtn layoutCornerRadiusWithCornerRadius:5];
    self.view.backgroundColor = self.mainView.backgroundColor;
}

- (void)loadNavigationBar{
    self.navigationItem.title=@"收费标准(3/3)";
    
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(returnBtnClick)];
    self.navigationItem.leftBarButtonItem = returnBtnItem;
    
}

- (void)returnBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveExitBtnClick:(UIButton *)sender{
    /**
     *  保存数据提示框
     */
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"保存本次数据采集?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveData];

    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - 保存
- (void)saveData{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 勿删
/*
#pragma mark - 上一步
- (void)backToPreviousViewCon{
    [PileVillageInfo sharedPileVillageInfo].parkings=self.dataArray;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 保存退出
- (void)saveExitBtnClick:(UIButton *)btn{
    [PileVillageInfo sharedPileVillageInfo].parkings=self.dataArray;
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSFileManager defaultManager] removeItemAtPath:IMAGE_PATH_DATA_COLLECTION error:nil];
}
*/

#pragma mark - 自定义协议代理
- (void)itemSelectedWithMainView:(ChargeStandardMainView *)mainView andIndexPath:(NSIndexPath *)indexPath{
    FeesDetailViewController * con=[[FeesDetailViewController alloc]init];
    con.dataArray=self.dataArray;
    con.pcs=self.dataArray[indexPath.row];
    [self.navigationController pushViewController:con animated:YES];
}

- (void)pushNextVC{
    FeesDetailViewController * con=[[FeesDetailViewController alloc]init];
    con.dataArray = self.dataArray;
    [self.navigationController pushViewController:con animated:YES];
}

- (NSMutableArray *)dataArray{
    if(_dataArray==nil){
         NSMutableArray * array = [PileVillageInfo sharedPileVillageInfo].parkings;
        _dataArray=array?:[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

//- (NSMutableArray *)pileVillageInfoArray{
//    
//    if (_pileVillageInfoArray == nil) {
//        _pileVillageInfoArray = [[NSMutableArray alloc] init];
//    }
//    return _pileVillageInfoArray;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mainView reloadData];
}

@end
