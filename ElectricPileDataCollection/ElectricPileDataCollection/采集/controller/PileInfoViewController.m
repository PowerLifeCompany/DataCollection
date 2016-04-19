//
//  PileInfoViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileInfoViewController.h"
#import "AddPileViewController.h"
#import "PileInfoCell.h"
#import "ParkingTypeCell.h"
#import "CustomCellTwo.h"
#import "SpecialInstructionsCell.h"
#import "CustomAlertView.h"

@interface PileInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UITextView *desTextView;

@property (strong, nonatomic) UILabel *placeHolderLabel;

@property(nonatomic,strong)NSMutableArray * dataArray;

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
    
    if (self.pileGroupSpace) {
        
    }
    
    
}

- (void)loadNavigationBar
{
    self.navigationItem.title = @"电桩详情";
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.leftBarButtonItem = saveBtnItem;
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.rightBarButtonItem = cancelBtnItem;
    
}

- (void)saveClick:(UIButton *)sender
{
    // 保存数据
    
    // 桩信息多一条
    
    // 返回上一页
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelClick:(UIButton *)sender
{
    // 数据清空
    
    // 桩信息条数不变
    
    // 返回上一页
    [self.navigationController popViewControllerAnimated:YES];
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
        return self.dataArray.count;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else{
        UITableViewCell * cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        return cell;
    }
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 130;
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 4) {
            return 140;
        }else{
            return 160;
        }
        
    }else{
        return 60;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 0, 30, 30)];
        UILabel *titleSectionL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 40)];
        titleSectionL.text = @"位置:";
        titleSectionL.font = [UIFont systemFontOfSize:13.0];
        titleSectionL.textColor = [UIColor grayColor];
        [headerView addSubview:titleSectionL];
        return headerView;

    }else if (section == 1){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 0, 30, 30)];
        UILabel *titleSectionL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 40)];
        titleSectionL.text = @"车位:";
        titleSectionL.font = [UIFont systemFontOfSize:13.0];
        titleSectionL.textColor = [UIColor grayColor];
        [headerView addSubview:titleSectionL];
        return headerView;

    }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 0, 30, 30)];
        
        UILabel *titleSectionL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 40)];
        titleSectionL.text = @"电桩:";
        titleSectionL.font = [UIFont systemFontOfSize:13.0];
        titleSectionL.textColor = [UIColor grayColor];
        [headerView addSubview:titleSectionL];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:BOY_BG_COLOR forState:UIControlStateNormal];
        addBtn.frame = headerView.frame;
        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:addBtn];
        return headerView;
    }
}

- (void)addClick:(UIButton *)sender
{
   
    UIStoryboard *addNewPileSb = [UIStoryboard storyboardWithName:@"AddPileViewController" bundle:nil];
    AddPileViewController *addNewPileVC = [addNewPileSb instantiateViewControllerWithIdentifier:@"AddPileViewController"];
    [self.navigationController pushViewController:addNewPileVC animated:YES];

    [self addTableViewCell];
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

- (void)addTableViewCell{//跳转到下一个界面，
    if(self.dataArray==nil){
        self.dataArray=[[NSMutableArray alloc]init];
    }
    [self.dataArray addObject:[NSObject new]];
    [self.tableView reloadData];
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
