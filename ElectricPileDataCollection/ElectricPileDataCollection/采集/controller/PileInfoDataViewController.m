//
//  PileInfoDataViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoDataViewController.h"

@interface PileInfoDataViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation PileInfoDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)loadMainView
{
    self.navigationItem.title = @"桩信息";
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
