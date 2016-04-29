//
//  MineViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"我的";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 100)];
    label.text = @"敬请期待...";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0 / 255.0 green:118 / 255.0 blue:255 / 255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:label];
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
