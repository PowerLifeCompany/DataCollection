//
//  AddPileMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileMainView.h"
#import "AddInterfaceMainCell.h"
#import "CustomAlertView.h"
#import "CustomPickView.h"
#import "CustomCellOne.h"
#import "CustomCellTwo.h"
#import "PileOperator.h"
#import "PileBrand.h"

@interface AddPileMainView()<CustomAlertViewDelegate,CustomPickViewDelegate>

@property (weak, nonatomic) CustomPickView * brandPickView;

@property (weak, nonatomic) CustomPickView * operatorPickView;

@property(nonatomic,assign)NSInteger currentPickViewIndex;

@property (weak, nonatomic) UILabel * currentLabel;

@end

@implementation AddPileMainView

- (void)awakeFromNib{
    self.dataSource=self;
    self.delegate=self;
}

#pragma mark - tableView协议代理
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
            UITapGestureRecognizer * tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
            [cell.descImageView addGestureRecognizer:tgr];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //选中某行，执行相应的代理方法
    if(indexPath.section==0){
        if(indexPath.row==0){
            self.brandPickView.hidden=NO;
            self.operatorPickView.hidden=YES;
            self.currentPickViewIndex=0;
            CustomCellOne * cell = [tableView cellForRowAtIndexPath:indexPath];
            self.currentLabel = cell.contentLabel;
        }else if(indexPath.row==1){
            self.brandPickView.hidden=YES;
            self.operatorPickView.hidden=NO;
            self.currentPickViewIndex=1;
            CustomCellOne * cell = [tableView cellForRowAtIndexPath:indexPath];
            self.currentLabel = cell.contentLabel;
        }
    }else{//第二组数据，代理通知controller进行界面跳转
        
    }
}

#pragma mark - 自定义协议代理
- (void)chooseAlbubmOrPhotoGraphWithTgr:(UITapGestureRecognizer *)tgr{
    self.currentImageView = (UIImageView *)tgr.view;
    CustomAlertView * alertView=[CustomAlertView customAlertViewWithArray:@[@"相机",@"相册",@"取消"]];
    alertView.delegate=self;
    [self.superview.superview addSubview:alertView];
    [alertView showAlertView];
}

- (void)customAlertView:(CustomAlertView *)alertView andIndex:(NSInteger)index{
    [alertView hiddenAlertView];
    if(index==2){
        return;
    }else{
        [self.mainViewDelegate chooseAlbubmOrPhotoGraphWithIndex:index];
    }
}

- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    customPickView.hidden=YES;
    NSInteger num = [selectedArray[0] integerValue];
    if(self.currentPickViewIndex==0 || self.currentPickViewIndex==1){
        NSObject * obj = dataArray[num];
        self.currentLabel.text=[obj valueForKey:@"name"];
    }
}

- (void)customPickViewCancleTouch:(CustomPickView *)customPickView{
    customPickView.hidden=YES;
}

#pragma mark - 懒加载
- (CustomPickView *)brandPickView{
    if(_brandPickView==nil){
        CustomPickView * pickView=[CustomPickView customPickViewWithDataArray:[PileBrand sharePileBrandFromPileBrandPlist] andComponent:1 andIsDependPre:NO andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.delegate=self;
        pickView.titleKey=@"name";
        [self.superview.superview addSubview:pickView];
        _brandPickView=pickView;
    }
    return _brandPickView;
}

- (CustomPickView *)operatorPickView{
    if(_operatorPickView==nil){
        CustomPickView * pickView=[CustomPickView customPickViewWithDataArray:[PileOperator sharePileOperatorFromPileOperatorPlist] andComponent:1 andIsDependPre:NO andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.delegate=self;
        pickView.titleKey=@"name";
        [self.superview.superview addSubview:pickView];
        _operatorPickView=pickView;
    }
    return _operatorPickView;
}

#pragma mark - 私有方法
- (void)addTableViewCell{//跳转到下一个界面，
    if(self.dataArray==nil){
        self.dataArray=[[NSMutableArray alloc]init];
    }
    [self.dataArray addObject:[NSObject new]];
    [self reloadData];
}



@end
