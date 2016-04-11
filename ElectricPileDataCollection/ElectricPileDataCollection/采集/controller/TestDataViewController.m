//
//  TestDataViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "TestDataViewController.h"
#import "PileBrand.h"

@interface TestDataViewController ()

@property(nonatomic,strong)NSArray * pileBrandArray;

@end

@implementation TestDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 100, 50);
    btn.backgroundColor=[UIColor orangeColor];
    [btn setTitle:@"存储" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick{
    BOOL b;
    //增加
//    for (PileBrand * brand in self.pileBrandArray) {
//        b = [SQLiteManager insertOrReplaceToTableName:@"pile_brand" andObject:brand];
//        NSLog(@"%@-->%@",brand.name,b?@"成功":@"失败");
//    }
    //修改,修改成  name=测试  条件 ID=1
//    b = [SQLiteManager updateWithTableName:@"pile_brand" andClass:nil andParams:@{@"name":@"测试"} andWhereParams:@{@"id":@"1"}];
    
    //查找
    NSArray * array = [SQLiteManager queryAllWithTableName:@"pile_brand" andClass:[PileBrand class]];
    for (PileBrand * brand in array) {
        NSLog(@"%@",brand);
    }
    
    //删除s
//    b = [SQLiteManager deleteWithTableName:@"pile_brand" andClass:nil andParams:@{@"id":@"1"}];
    
    NSLog(@"%@-->%@",@"",b?@"成功":@"失败");
}

- (NSArray *)pileBrandArray{
    NSMutableArray * array=[[NSMutableArray alloc]init];
    NSArray * tmpArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pile_brand.plist" ofType:nil]];
    for (NSDictionary * dict in tmpArray) {
        [array addObject:[PileBrand pileBrandWithDict:dict]];
    }
    return array;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AppDelegate customTabbar].hidden=YES;
}

@end
