//
//  PileDetailViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileDetailViewController.h"
#import "PileDetailMainView.h"

@interface PileDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) PileDetailMainView *tableView;

@end

@implementation PileDetailViewController

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
    self.navigationItem.title = @"电桩详情";
}

- (void)loadMainView
{
    self.tableView = self.containerView.subviews[0];
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
