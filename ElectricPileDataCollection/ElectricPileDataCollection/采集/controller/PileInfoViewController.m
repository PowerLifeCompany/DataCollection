//
//  PileInfoViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoViewController.h"
#import "PileDetailViewController.h"

#import "PileInfoMainView.h"

@interface PileInfoViewController ()

@property (weak, nonatomic) PileInfoMainView *tableView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property(nonatomic,strong)NSMutableArray * dataArray;

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
    self.navigationItem.title = @"电桩信息";
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"小区信息" style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStyleDone target:self action:@selector(addClick:)];
    self.navigationItem.rightBarButtonItem = addBtnItem;
    
}

- (void)loadMainView
{
    self.tableView = self.containerView.subviews[0];
    self.tableView.dataArray = self.dataArray;
}

- (void)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addClick:(UIButton *)sender
{
    PileDetailViewController *pileDetailVC = [[PileDetailViewController alloc] init];
    pileDetailVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:pileDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
