//
//  PileDetailMainView.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileDetailMainView.h"
#import "CustomAlertView.h"
#import "CustomPickView.h"
#import "AddPileViewController.h"

#import "CustomCellOne.h"
#import "CustomCellTwo.h"
#import "CustomCellThree.h"
#import "CustomCellFour.h"
#import "CustomCellFive.h"

@interface PileDetailMainView()<CustomAlertViewDelegate>

@end

@implementation PileDetailMainView

- (void)awakeFromNib
{
    /**
     *  设置代理
     */
    self.dataSource = self;
    self.delegate = self;

}

- (void)chooseAlbubmOrPhotoGraphWithTap:(UITapGestureRecognizer *)tap
{
    self.currentImageView = (UIImageView *)tap.view;
    CustomAlertView * alertView = [CustomAlertView customAlertViewWithArray:@[@"相机",@"相册",@"取消"]];
    alertView.delegate = self;
    [self.superview.superview addSubview:alertView];
    [alertView showAlertView];

}

#pragma mark - choose album or camera
- (void)customAlertView:(CustomAlertView *)alertView andIndex:(NSInteger)index{
    [alertView hiddenAlertView];
    if(index == 2){
        return;
    }else{
        [self.mainViewDelegate chooseAlbubmOrPhotoGraphWithIndex:index];
    }
}

- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    customPickView.hidden=YES;
}

- (void)customPickViewCancleTouch:(CustomPickView *)customPickView{
    customPickView.hidden=YES;
}

#pragma mark - tableView delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        CustomCellThree *cell = [CustomCellThree customCellWithTableView:tableView];
       
        self.locationLabel = cell.locationLabel;
        self.longitudeTextField = cell.longitudeTextField;
        self.latitudeTextField = cell.latitudeTextField;
        
        cell.locationLabel.text = @"北京市十里河";
        //cell.longitudeTextField.text = _pileGroupInfo.pile_site.x;
        //cell.latitudeTextField.text = _pileGroupInfo.pile_site.y;
        
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 4) {
            CustomCellFour *cell = [CustomCellFour customCellWithTableView:tableView];
            
            self.bnumTextField = cell.bnumTextField;
            self.mnumTextField = cell.mnumTextField;
            self.snumTextField = cell.snumTextField;
            self.wnumTextField = cell.wnumTextField;
            
            cell.bnumTextField.text = _pileGroupInfo.pile_space.bnum;
            cell.mnumTextField.text = _pileGroupInfo.pile_space.mnum;
            cell.snumTextField.text = _pileGroupInfo.pile_space.snum;
            cell.wnumTextField.text = _pileGroupInfo.pile_space.tnum;
            
            return cell;
        }else if (indexPath.row == 5){
            CustomCellFive *cell = [CustomCellFive customCellWithTableView:tableView];
            
            cell.specialInstructionsTextView.delegate = self;
            self.instructionsTextView = cell.specialInstructionsTextView;
            cell.specialInstructionsTextView.text = _pileGroupInfo.pile_space.comment;
            
            return cell;
        }else{
            CustomCellTwo *cell = [CustomCellTwo customCellWithTableView:tableView];
            if ([cell.descTextView.text isEqualToString:@""]) {
                cell.descTextView.text = FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
            }
            cell.descTextView.delegate = self;
            cell.descTextView.tag = 4000 + indexPath.row;
            cell.descImageView.tag = 5000 + indexPath.row;
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
            cell.descImageView.userInteractionEnabled = YES;
            [cell.descImageView addGestureRecognizer:tap];
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"停车位:";
                
                self.parkingImageView = cell.descImageView;
                self.parkingTextView = cell.descTextView;
                
//                if (self.pileGroupInfo.pile_space.image3Path) {
//                    if([self.pileGroupInfo.pile_space.image3Path containsString:@"http"]){
//                        [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image3Path]];
//                    }else{
//                        NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image3Path];
//                        cell.descImageView.image=[UIImage imageWithData:data];
//                    }
//                }
//                cell.descTextView.text = _pileGroupInfo.pile_space.comment3;
            }
            
            if (indexPath.row == 1) {
                cell.titleLabel.text = @"电桩全景:";
                
                self.pileImageView = cell.descImageView;
                self.pileTextView = cell.descTextView;
                
//                if (self.pileGroupInfo.pile_space.image4Path) {
//                    if([self.pileGroupInfo.pile_space.image4Path containsString:@"http"]){
//                        [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image4Path]];
//                    }else{
//                        NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image4Path];
//                        cell.descImageView.image=[UIImage imageWithData:data];
//                    }
//                }
//                cell.descTextView.text = _pileGroupInfo.pile_space.comment4;
            }
            
            if (indexPath.row == 2) {
                cell.titleLabel.text = @"空位:";
                self.emptyImageView = cell.descImageView;
                self.emptyTextView = cell.descTextView;
                
//                if (self.pileGroupInfo.pile_space.image5Path) {
//                    if([self.pileGroupInfo.pile_space.image5Path containsString:@"http"]){
//                        [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image5Path]];
//                    }else{
//                        NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image5Path];
//                        cell.descImageView.image=[UIImage imageWithData:data];
//                    }
//                }
//                cell.descTextView.text = _pileGroupInfo.pile_space.comment5;
                
            }
            
            if (indexPath.row == 3) {
                cell.titleLabel.text = @"充电:";
                self.charingImageView = cell.descImageView;
                self.charingTextView = cell.descTextView;
                
                if (self.pileGroupInfo.pile_space.image6Path) {
                    if([self.pileGroupInfo.pile_space.image6Path containsString:@"http"]){
                        [cell.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image6Path]];
                    }else{
                        NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image6Path];
                        cell.descImageView.image=[UIImage imageWithData:data];
                    }
                }
                cell.descTextView.text = _pileGroupInfo.pile_space.comment6;
            }
            
            return cell;
        }
    }else{
        CustomCellOne * cell = [CustomCellOne customCellWithTableView:tableView];
        cell.categoryLabel.text=[NSString stringWithFormat:@"电桩-%ld", indexPath.row + 1];
        cell.contentLabel.text=@"点击编辑";
        cell.contentLabel.textAlignment = NSTextAlignmentRight;
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 6;
    }else{
        return self.addPileArray.count;
    }
}

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
        return 50;
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
        [addbtn.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
        [addbtn setTitleColor:BOY_BG_COLOR forState:UIControlStateNormal];
        [addbtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:addbtn];
    }
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing:YES];
    
    if (indexPath.section == 2) {
        [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.addPileArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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


//- (void)setPileGroupInfo:(PileGroupInfo *)pileGroupInfo{
//    
//    _pileGroupInfo = pileGroupInfo;
//    [self reloadData];
//}


- (void)setDataArray:(NSMutableArray *)dataArray{
    if(dataArray){
        _dataArray = dataArray;
        [self reloadData];
    }
}

- (void)setAddPileArray:(NSMutableArray *)addPileArray{
    if (addPileArray) {
        _addPileArray = addPileArray;
        [self reloadData];
    }
}

#pragma mark - testField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}


- (void)addClick:(UIButton *)sender
{
    [self.mainViewDelegate addPile:self];
}

@end
