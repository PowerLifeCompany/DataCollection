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
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }else{
        return self.interfaceArray.count;
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
            if ([cell.descTextView.text isEqualToString:@""]) {
                cell.descTextView.text = FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
            }
            cell.descTextView.delegate = self;
            self.logoDetailImageView = cell.descImageView;
            self.logoDetailTextView = cell.descTextView;
            UITapGestureRecognizer * tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
            cell.descImageView.userInteractionEnabled = YES;
            [cell.descImageView addGestureRecognizer:tgr];
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
    if (section == 1) {
        return 50;
    }
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
    }
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    /**
     *  表尾视图
     */
    if (section == 1) {
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 20, 20)];
        addImageView.image = [UIImage imageNamed:@"add"];
        
        UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 120, 30)];
        addLabel.text = @"新增接口";
        addLabel.textAlignment = NSTextAlignmentLeft;
        addLabel.font = [UIFont systemFontOfSize:14];
        
        UIImageView *pushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH - 40, 15, 20, 20)];
        pushImageView.image = [UIImage imageNamed:@"push"];
        
        [_footerView addSubview:addImageView];
        [_footerView addSubview:addLabel];
        [_footerView addSubview:pushImageView];
        
        /**
         *  手势
         */
        UITapGestureRecognizer *footerViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
        _footerView.userInteractionEnabled = YES;
        [_footerView addGestureRecognizer:footerViewTap];
        
        return _footerView;
        
    }
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.interfaceArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)pushVC{
    [self.mainViewDelegate addPileInterface:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    }else{
        [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
    }
}

- (void)chooseAlbubmOrPhotoGraphWithTgr:(UITapGestureRecognizer *)tgr{
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

#pragma mark - lazy loading
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

- (void)setDataArray:(NSMutableArray *)dataArray{
    if(dataArray){
        _dataArray = dataArray;
        [self reloadData];
    }
}

- (void)setInterfaceArray:(NSMutableArray *)interfaceArray{
    if (interfaceArray) {
        _interfaceArray = interfaceArray;
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
