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

@interface PileDetailMainView()<CustomAlertViewDelegate>

@end

@implementation PileDetailMainView

- (void)awakeFromNib
{
    /**
     *  设置代理
     */
    self.delegate = self;
    self.locationTextField.delegate = self;
    self.parkingTextView.delegate = self;
    self.pilePanoramicTextView.delegate = self;
    self.parkingVacancyTextView.delegate = self;
    self.carChargingTextView.delegate = self;
    self.instructionsTextView.delegate = self;
    
    /**
     *  设置tag值
     */
    self.parkingImageView.tag = 5000;
    self.pilePanoramicImageView.tag = 5001;
    self.parkingVacancyImageView.tag = 5002;
    self.carChargingImageView.tag = 5003;
    
    /**
     *  添加手势
     */
    UITapGestureRecognizer *parkingTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
    self.parkingImageView.userInteractionEnabled = YES;
    [self.parkingImageView addGestureRecognizer:parkingTap];
    
    UITapGestureRecognizer *panoramicTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
    self.pilePanoramicImageView.userInteractionEnabled = YES;
    [self.pilePanoramicImageView addGestureRecognizer:panoramicTap];
    
    UITapGestureRecognizer *vacancyTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
    self.parkingVacancyImageView.userInteractionEnabled = YES;
    [self.parkingVacancyImageView addGestureRecognizer:vacancyTap];
    
    UITapGestureRecognizer *chargingTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTap:)];
    self.carChargingImageView.userInteractionEnabled = YES;
    [self.carChargingImageView addGestureRecognizer:chargingTap];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing:YES];
}

#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:FINAL_PLEASE_ENTER_DESCRIPTION_TEST]){
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""] && ![textView isEqual:self.instructionsTextView]){
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

#pragma mark - testField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}


- (void)addClick:(UIButton *)sender
{
    NSLog(@"添加电桩");
}


@end
