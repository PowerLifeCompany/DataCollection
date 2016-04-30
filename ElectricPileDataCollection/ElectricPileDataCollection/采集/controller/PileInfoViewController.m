//
//  PileInfoViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoViewController.h"
#import "PileDetailViewController.h"
#import "ChargeStandardViewController.h"

#import "PileInfoMainView.h"

@interface PileInfoViewController ()<PileInfoMainViewDelegate>

@property (weak, nonatomic) PileInfoMainView *tableView;

@property (weak, nonatomic) IBOutlet UIView *containerView;


@end

@implementation PileInfoViewController

- (instancetype)init
{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationBar];
    [self loadMainView];
}

- (void)loadNavigationBar
{
    self.navigationItem.title = @"电桩信息(2/3)";
    
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(returnBtnClick)];
    self.navigationItem.leftBarButtonItem = returnBtnItem;
}

- (void)returnBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMainView
{
    self.tableView = self.containerView.subviews[0];
    self.tableView.mainViewDelegate = self;
    self.tableView.dataArray = self.dataArray;
}

- (void)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushNextVC
{
    PileDetailViewController *pileDetailVC = [[PileDetailViewController alloc] init];
    pileDetailVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:pileDetailVC animated:YES];
}

- (void)itemSelectedWithMainView:(PileInfoMainView *)mainView andIndexPath:(NSIndexPath *)indexPath{
    
    PileDetailViewController *pileDetailVC  =[[PileDetailViewController alloc]init];
    pileDetailVC.pileGroupInfo = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:pileDetailVC animated:YES];
    
}

- (NSMutableArray *)dataArray{
    if(_dataArray == nil){
        NSMutableArray * array = [PileVillageInfo sharedPileVillageInfo].sites;
        _dataArray = array?:[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (IBAction)nextStep:(id)sender{
    
    ChargeStandardViewController *chargeStandardVC = [[ChargeStandardViewController alloc] init];
    [self.navigationController pushViewController:chargeStandardVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

@end
