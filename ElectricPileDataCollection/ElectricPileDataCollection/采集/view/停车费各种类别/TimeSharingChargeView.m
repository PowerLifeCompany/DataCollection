//
//  TimeSharingChargeView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "TimeSharingChargeView.h"
#import "TimeSharingMainCell.h"

@implementation TimeSharingChargeView

- (void)awakeFromNib{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}

#pragma mark - tableView协议代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier=@"TimeSharingMainCell";
    TimeSharingMainCell * cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        UINib * nib=[UINib nibWithNibName:identifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.contentLabel.text=self.dataArray[indexPath.row];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag=indexPath.row+100;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - 私有方法
- (IBAction)cancleBtnClick:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)insertBtnClick:(UIButton *)sender {
    NSString * value = [NSString stringWithFormat:@"%@ 至 %@  %@ 元/%@分钟",self.timeBeginTF.text,self.timeEndTF.text,self.moneyTF.text,self.everyTimeTF.text];
    [self.dataArray addObject:value];
    [self.tableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

- (void)deleteBtnClick:(UIButton *)btn{
    [self.dataArray removeObjectAtIndex:btn.tag-100];
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray{
    if(_dataArray==nil){
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

@end
