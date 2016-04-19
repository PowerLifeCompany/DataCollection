//
//  PileDetailMainView.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileDetailMainView.h"

@implementation PileDetailMainView

- (void)awakeFromNib
{
    self.delegate = self;
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 130;
    }else if(indexPath.section == 1){
        if (indexPath.row == 4) {
            return 120;
        }else{
            return 150;
        }
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, WIDTH, 30)];
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.textColor=[UIColor grayColor];
    [headerView addSubview:titleLabel];
    
    if(section == 0){
        titleLabel.text=@"位置:";
    }else if (section == 1){
        titleLabel.text = @"车位:";
    }else{
        titleLabel.text=@"电桩:";
        UIButton * addbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        addbtn.frame = CGRectMake(WIDTH - 66, 0, 50, 30);
        [addbtn setTitle:@"+" forState:UIControlStateNormal];
        [addbtn setTitleColor:BOY_BG_COLOR forState:UIControlStateNormal];
        [addbtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:addbtn];
    }
    
    return headerView;
}

- (void)addClick:(UIButton *)sender
{
    NSLog(@"添加电桩");
}


@end
