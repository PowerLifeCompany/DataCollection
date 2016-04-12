//
//  PileInfoViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoViewController.h"
#import "PileInfoCell.h"
#import "ParkingTypeCell.h"
#import "CustomCellTwo.h"
#import "SpecialInstructionsCell.h"
#import "CustomAlertView.h"

@interface PileInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UITextView *desTextView;

@property (strong, nonatomic) UILabel *placeHolderLabel;

@end

@implementation PileInfoViewController

- (instancetype)init
{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadNavigationBar];
}

- (void)loadNavigationBar
{
    self.navigationItem.title = @"电桩详情";
}

#pragma mark - tableView协议代理
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
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *cellId = @"PileInfoCell";
        PileInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PileInfoCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 4) {
            static NSString *cellId = @"ParkingTypeCell";
            ParkingTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"ParkingTypeCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 5){
            static NSString *cellId = @"SpecialInstructionsCell";
            SpecialInstructionsCell*cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"SpecialInstructionsCell" owner:self options:nil] lastObject];
                cell.specialInstructionTextView.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            static NSString *cellId = @"CustomCellTwo";
            CustomCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"CustomCellTwo" owner:self options:nil] lastObject];
                if (indexPath.row == 0) {
                    cell.titleLabel.text = @"停车位:";
                }else if (indexPath.row == 1){
                    cell.titleLabel.text = @"电桩全景:";
                }else if (indexPath.row == 2){
                    cell.titleLabel.text = @"空位:";
                }else{
                    cell.titleLabel.text = @"充电中:";
                }
            }
            //cell.placeHolderLabel.text = @"请输入...";
            //cell.placeHolderLabel.textColor = [UIColor lightGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //self.desTextView = cell.descTextView;
            //self.placeHolderLabel = cell.placeHolderLabel;
            return cell;
        }
        
    }else{
        UITableViewCell * cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text=@"测试---";
        return cell;
    }
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 160;
    }else if (indexPath.section == 1){
        return 160;
    }else{
        return 60;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"位置";
    }else if (section == 1){
        return @"车位";
    }else{
        return @"电桩";
    }
}

#pragma mark - textView delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CGRect frame = self.tableView.frame;
    frame.origin = CGPointMake(frame.origin.x, frame.origin.y - 216);
    self.tableView.frame = frame;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    CGRect frame = self.tableView.frame;
    frame.origin = CGPointMake(frame.origin.x, frame.origin.y + 216);
    self.tableView.frame = frame;
    return YES;
}

//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@"请输入..."]) {
//        textView.text = @"";
//    }
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if (textView.text.length < 1) {
//        textView.text = @"请输入...";
//    }
//}


@end
