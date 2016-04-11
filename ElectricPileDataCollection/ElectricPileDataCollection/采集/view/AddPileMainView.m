//
//  AddPileMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileMainView.h"
#import "AddInterfaceMainCell.h"
#import "CustomCellOne.h"
#import "CustomCellTwo.h"

@implementation AddPileMainView

- (void)awakeFromNib{
    self.dataSource=self;
    self.delegate=self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
            cell.categoryLabel.text=@"电桩品牌";
            cell.contentLabel.text=@"";
            return cell;
        }else if(indexPath.row==1){
            CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
            cell.categoryLabel.text=@"电桩运营商";
            cell.contentLabel.text=@"";
            return cell;
        }else{
            CustomCellTwo * cell = [CustomCellTwo customCellWithTableView:tableView];
            cell.titleLabel.text=@"（照片）细节特写、电桩用法、logo：";
            cell.descImageView.image=[UIImage imageNamed:@"addPic.png"];
            cell.descTextView.text=FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
            return cell;
        }
    }else{
        
    }
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0|| indexPath.row==1){
            return 60;
        }else{
            return 160;
        }
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, WIDTH, 40)];
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor grayColor];
    [headerView addSubview:label];
    
    if(section==1){
        label.text=@"增加接口：";
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(WIDTH-66, 0, 50, 40);
        [btn setTitle:@"+" forState:UIControlStateNormal];
        [btn setTitleColor:BOY_BG_COLOR forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addTableViewCell) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:btn];
    }else{
        label.text=@"电桩介绍：";
    }
    
    return headerView;
}

- (void)addTableViewCell{//跳转到下一个界面，
    if(self.dataArray==nil){
        self.dataArray=[[NSMutableArray alloc]init];
    }
    [self.dataArray addObject:[NSObject new]];
    [self reloadData];
}



@end
