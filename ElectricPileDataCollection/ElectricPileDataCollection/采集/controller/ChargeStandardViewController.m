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

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation ChargeStandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
}

#pragma mark - 初始化组件
- (void)loadMainView{
    ChargeStandardMainView * mainView=[[ChargeStandardMainView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-264) style:UITableViewStyleGrouped];
    mainView.mainViewDelegate=self;
    [self.view addSubview:mainView];
    self.mainView=mainView;
    self.mainView.dataArray=self.dataArray;
    
    
    UIButton * preBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    preBtn.frame=CGRectMake((WIDTH-200)/3.0, HEIGHT-110, 100, 40);
    [self.view addSubview:preBtn];
    [preBtn addTarget:self action:@selector(backToPreviousViewCon) forControlEvents:UIControlEventTouchUpInside];
    preBtn.backgroundColor=[UIColor colorWithRed:0.02f green:0.48f blue:1.00f alpha:1.00f];
    [preBtn setTitle:@"上一步" forState:UIControlStateNormal];
    preBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [preBtn layoutCornerRadiusWithCornerRadius:5];
    
    self.view.backgroundColor=self.mainView.backgroundColor;
    
    
    UIButton * saveExitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    saveExitBtn.frame=CGRectMake((WIDTH-200)/3.0*2+100, HEIGHT-110, 100, 40);
    [self.view addSubview:saveExitBtn];
    [saveExitBtn addTarget:self action:@selector(saveExitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    saveExitBtn.backgroundColor=[UIColor colorWithRed:0.02f green:0.48f blue:1.00f alpha:1.00f];;
    [saveExitBtn setTitle:@"保存退出" forState:UIControlStateNormal];
    saveExitBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [saveExitBtn layoutCornerRadiusWithCornerRadius:5];
    
    self.view.backgroundColor=self.mainView.backgroundColor;
}

- (void)loadNavigationBar{
    self.navigationItem.title=@"收费标准";
    UIBarButtonItem * rightItem=[[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleDone target:self action:@selector(navAddBtnClick:)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    self.navigationItem.hidesBackButton=YES;
    
    UIBarButtonItem * leftItem=[[UIBarButtonItem alloc]initWithTitle:@"  回到列表" style:UIBarButtonItemStyleDone target:self action:@selector(backToRootViewCon)];
    self.navigationItem.leftBarButtonItem=leftItem;
}
#pragma mark - 新增一条数据
- (void)navAddBtnClick:(UIBarButtonItem *)item{
    FeesDetailViewController * con=[[FeesDetailViewController alloc]init];
    con.dataArray=self.dataArray;
    [self.navigationController pushViewController:con animated:YES];
}
#pragma mark - 上一步
- (void)backToPreviousViewCon{
    [PileVillageInfo sharedPileVillageInfo].parkings=self.dataArray;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 回到列表
- (void)backToRootViewCon{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 保存退出
- (void)saveExitBtnClick:(UIButton *)btn{
    [PileVillageInfo sharedPileVillageInfo].parkings=self.dataArray;
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSFileManager defaultManager] removeItemAtPath:IMAGE_PATH_DATA_COLLECTION error:nil];
}

#pragma mark - 自定义协议代理
- (void)itemSelectedWithMainView:(ChargeStandardMainView *)mainView andIndexPath:(NSIndexPath *)indexPath{
    FeesDetailViewController * con=[[FeesDetailViewController alloc]init];
    con.dataArray=self.dataArray;
    con.pcs=self.dataArray[indexPath.row];
    [self.navigationController pushViewController:con animated:YES];
}

- (NSMutableArray *)dataArray{
    if(_dataArray==nil){
         NSMutableArray * array = [PileVillageInfo sharedPileVillageInfo].parkings;
        _dataArray=array?:[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mainView reloadData];
}

@end
