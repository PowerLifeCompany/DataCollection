//
//  PileInfoDataViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoDataViewController.h"
#import "PileInfoDataCell.h"
#import "ChargeStandardViewController.h"
#import "PileDetailViewController.h"

@interface PileInfoDataViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation PileInfoDataViewController

- (instancetype)init
{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view bringSubviewToFront:_nextStepBtn];
    [self loadNavigationBar];
    
}

- (void)loadNavigationBar
{
    self.navigationItem.title = @"桩信息(2/3)";
    
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStyleDone target:self action:@selector(addClick:)];
    self.navigationItem.rightBarButtonItem = addBtnItem;
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"小区信息" style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"PileInfoDataCell";
    PileInfoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PileInfoDataCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)addClick:(UIButton *)sender
{
    PileDetailViewController *pileDetailVC = [[PileDetailViewController alloc] init];
    [self.navigationController pushViewController:pileDetailVC animated:YES];
}

- (void)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)nextStepBtn:(id)sender {
    
    ChargeStandardViewController * chargeStandardVC =[[ChargeStandardViewController alloc]init];
    [self.navigationController pushViewController: chargeStandardVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
