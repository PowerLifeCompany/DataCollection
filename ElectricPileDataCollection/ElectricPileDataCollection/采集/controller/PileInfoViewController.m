//
//  PileInfoViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoViewController.h"

@interface PileInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

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
}


- (void)loadNavigationBar{
    self.navigationItem.title = @"桩信息";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.textLabel.text=@"测试---";
    return cell;
}

#pragma mark - tableView协议代理
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0 || indexPath.row==1){
        return 60;
    }else{
        return 160;
    }
}


@end
