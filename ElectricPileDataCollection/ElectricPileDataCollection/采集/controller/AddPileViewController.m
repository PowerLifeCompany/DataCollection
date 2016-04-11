//
//  AddPileViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileViewController.h"
#import "AddPileMainView.h"

@interface AddPileViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) AddPileMainView* tableView;

@end

@implementation AddPileViewController


- (instancetype)init
{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 初始化组件
- (void)loadMainView{
    self.tableView=self.containerView.subviews[0];

}

- (void)loadNavigationBar{
    self.navigationItem.title = @"增加接口";
}


#pragma mark - 自定义代理

#pragma mark - 下载数据

#pragma mark - 懒加载

#pragma mark - 系统协议方法



@end
