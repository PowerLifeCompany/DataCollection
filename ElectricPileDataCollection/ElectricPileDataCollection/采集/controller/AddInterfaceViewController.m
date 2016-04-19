//
//  AddInterfaceViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddInterfaceViewController.h"
#import "AddInterfaceMainView.h"

@interface AddInterfaceViewController ()

@property (weak, nonatomic) AddInterfaceMainView *tableView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation AddInterfaceViewController

- (instancetype)init{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
}

#pragma mark - 初始化组件
- (void)loadMainView{
    self.tableView = self.containerView.subviews[0];
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"新增接口";
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.leftBarButtonItem = saveBtnItem;
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.rightBarButtonItem = cancelBtnItem;
}

- (void)saveClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
