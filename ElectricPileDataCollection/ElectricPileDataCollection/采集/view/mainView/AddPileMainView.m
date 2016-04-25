//
//  AddPileMainView.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/23.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileMainView.h"
#import "CustomAlertView.h"
#import "CustomPickView.h"
#import "CustomCellOne.h"
#import "CustomCellTwo.h"
#import "PileOperator.h"
#import "PileBrand.h"

@interface AddPileMainView()<CustomAlertViewDelegate,CustomPickViewDelegate, UITextViewDelegate, UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) CustomPickView * brandPickView;

@property (weak, nonatomic) CustomPickView * operatorPickView;

@end

@implementation AddPileMainView

- (void)awakeFromNib
{
    /**
     *  设置代理
     */
    self.delegate = self;
    self.dataSource = self;
    
    self.currentImageView.tag = 5000;
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }else{
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        if(indexPath.row==0){
            CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
            cell.categoryLabel.text=@"电桩品牌";
            cell.contentLabel.text=@"";
            self.pileBrandLabel = cell.contentLabel;
            return cell;
        }else if(indexPath.row==1){
            CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
            cell.categoryLabel.text=@"电桩运营商";
            cell.contentLabel.text=@"";
            self.pileOperatorLabel = cell.contentLabel;
            return cell;
        }else{
            CustomCellTwo * cell = [CustomCellTwo customCellWithTableView:tableView];
            cell.titleLabel.text=@"（照片）细节特写、电桩用法、logo：";
            cell.descImageView.image=[UIImage imageNamed:@"addPic.png"];
            cell.descTextView.text=FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
            UITapGestureRecognizer * tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
            cell.descImageView.userInteractionEnabled = YES;
            [cell.descImageView addGestureRecognizer:tgr];
            cell.descTextView.delegate = self;
            return cell;
        }
    }else{
        CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
        cell.categoryLabel.text=[NSString stringWithFormat:@"接口-%ld", indexPath.row + 1];
        cell.contentLabel.text=@"点击编辑";
        cell.contentLabel.textAlignment = NSTextAlignmentRight;
        return cell;
        
    }
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
        return 150;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, WIDTH, 30)];
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.textColor=[UIColor grayColor];
    [headerView addSubview:titleLabel];
    
    if(section == 0){
        titleLabel.text=@"电桩介绍:";
    }else{
        titleLabel.text=@"增加接口:";
        UIButton * addbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        addbtn.frame = CGRectMake(WIDTH - 66, 0, 50, 30);
        [addbtn setTitle:@"+" forState:UIControlStateNormal];
        [addbtn setTitleColor:BOY_BG_COLOR forState:UIControlStateNormal];
        [addbtn.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
        [addbtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:addbtn];
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)addClick:(UIButton *)sender
{
    [self.mainViewDelegate addPileInterface:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //选中某行，执行相应的代理方法
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            self.brandPickView.hidden = NO;
            self.operatorPickView.hidden = YES;
            self.currentPickViewIndex = 0;
            CustomCellOne * cell = [tableView cellForRowAtIndexPath:indexPath];
            self.pileBrandLabel = cell.contentLabel;
        }else if(indexPath.row == 1){
            self.brandPickView.hidden = YES;
            self.operatorPickView.hidden = NO;
            self.currentPickViewIndex = 1;
            CustomCellOne * cell = [tableView cellForRowAtIndexPath:indexPath];
            self.pileOperatorLabel = cell.contentLabel;
        }
    }else{//第二组数据，代理通知controller进行界面跳转
        [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
    }
}

- (void)chooseAlbubmOrPhotoGraphWithTgr:(UITapGestureRecognizer *)tgr{
    
    self.currentImageView = (UIImageView *)tgr.view;
    CustomAlertView * alertView =[CustomAlertView customAlertViewWithArray:@[@"相机",@"相册",@"取消"]];
    alertView.delegate = self;
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
    if(self.currentPickViewIndex == 0){
        NSObject * obj = dataArray[num];
        self.pileBrandLabel.text = [obj valueForKey:@"name"];
    }else{
        NSObject * obj = dataArray[num];
        self.pileOperatorLabel.text = [obj valueForKey:@"name"];
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

//#pragma mark - 私有方法
//- (void)addTableViewCell{//跳转到下一个界面，
//    if(self.dataArray==nil){
//        self.dataArray=[[NSMutableArray alloc]init];
//    }
//    [self.dataArray addObject:[NSObject new]];
//    [self reloadData];
//}

- (void)setDataArray:(NSMutableArray *)dataArray{
    if(dataArray){
        _dataArray = dataArray;
        [self reloadData];
    }
}

#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:FINAL_PLEASE_ENTER_DESCRIPTION_TEST]){
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text = FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
