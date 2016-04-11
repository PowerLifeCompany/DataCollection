//
//  CollectionMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CollectionMainView.h"
#import "CollectionMainCell.h"

@implementation CollectionMainView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        
        self.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.mainViewDelegate refreshWithMainView:self andRefreshComponent:self.mj_header];
        }];
    }
    return self;
}

#pragma mark - tableView代理事件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier=@"CollectionMainCell";
    CollectionMainCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        UINib * nib=[UINib nibWithNibName:identifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.siteLabel.text=@"测试数据一";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)setDataArray:(NSArray *)dataArray{
    if(dataArray.count){
        _dataArray=dataArray;
        [self reloadData];
    }
}

@end
