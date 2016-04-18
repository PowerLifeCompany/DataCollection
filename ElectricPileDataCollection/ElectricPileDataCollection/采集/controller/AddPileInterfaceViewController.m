//
//  AddPileInterfaceViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/13.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileInterfaceViewController.h"
#import "AddInterfaceCellOne.h"
#import "AddInterfaceCellTwo.h"
#import "AddInterfaceCellThree.h"
#import "AddInterfaceCellFour.h"
#import "AddInterfaceCellFive.h"
#import "AddInterfaceCellSix.h"
#import "CustomCellTwo.h"
#import "SpecialInstructionsCell.h"

typedef enum {
    
    takeLineYes,
    takeLineNo
    
}takeLineStyle;


typedef enum{
    
    operatorPay = 10001,
    wechatPay,
    aliPay,
    creditCardPay
    
}payStyle;

@interface AddPileInterfaceViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) BOOL selectLine;

@property (assign, nonatomic) BOOL yesState;

@property (assign, nonatomic) BOOL noState;

//@property (assign, nonatomic) BOOL takeLineYes, takeLineNo;

@property (assign, nonatomic) BOOL operatorPay, wechatPay, aliPay, creditPay;


@end

@implementation AddPileInterfaceViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self loadNavigationBar];
    [self loadMainView];
}

- (void)loadNavigationBar
{
    self.navigationItem.title = @"新增电桩接口";
    [self createNavigationBtn];
}

- (void)loadMainView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTapGesture];
}

- (void)createNavigationBtn
{
    /**
     *  返回按钮
     */
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    /**
     *  保存按钮
     */
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}

- (void)createTapGesture
{
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.tableView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row  == 0 || indexPath.row == 3 || indexPath.row == 4) {
        static NSString *cellId = @"addPileInterfaceOne";
        AddInterfaceCellOne *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddInterfaceCellOne" owner:self options:nil] lastObject];
        }
        if (indexPath.row == 0) cell.markLabel.text = @"接口类型:";
        if (indexPath.row == 3) {
            cell.markLabel.text = @"接口个数:";
        }
        if (indexPath.row == 4) cell.markLabel.text = @"重量(kg):";
        if (indexPath.row == 3 || indexPath.row == 4)cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellId = @"addPileInterfaceTwo";
        AddInterfaceCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddInterfaceCellTwo" owner:self options:nil] lastObject];
        }
        cell.markLabel.text = @"服务费:";
        cell.unitLabel.text = @"元/度";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2){
        static NSString *cellId = @"addPileInterfaceThree";
        AddInterfaceCellThree *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddInterfaceCellThree" owner:self options:nil] lastObject];
        }
        cell.markLabel.text = @"电桩是否自带充电线:";
        cell.markYesLabel.text = @"是";
        cell.markNoLabel.text = @"否";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.selectYes addTarget:self action:@selector(selectYesClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.selectNo addTarget:self action:@selector(selectNoClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 5){
        static NSString *cellId = @"addPileInterfaceFour";
        AddInterfaceCellFour *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddInterfaceCellFour" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 6){
        static NSString *cellId = @"addPileInterfaceFive";
        AddInterfaceCellFive *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddInterfaceCellFive" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 8 || indexPath.row == 9){
        static NSString *cellId = @"CustomCellTwo";
        CustomCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCellTwo" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if (indexPath.row == 10){
        static NSString *cellId = @"SpecialInstructionsCell";
        SpecialInstructionsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SpecialInstructionsCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.specialInstructionTextView.delegate = self;
        return cell;
        
    }else{
        static NSString *cellId = @"addPileInterfaceSix";
        AddInterfaceCellSix *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddInterfaceCellSix" owner:self options:nil] lastObject];
        }
        [cell.operatorBtn addTarget:self action:@selector(payStyleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.weChatBtn addTarget:self action:@selector(payStyleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.aliPayBtn addTarget:self action:@selector(payStyleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.creditCardBtn addTarget:self action:@selector(payStyleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6){
        return 130;
    }else if (indexPath.row == 7 || indexPath.row == 10){
        return 140;
    }else if (indexPath.row == 8 || indexPath.row == 9) {
        return 120;
    }else{
        return 50;
    }
}

#pragma mark - textView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UIView *view = textView.superview;
    
    if (![view isKindOfClass:[UITableViewCell class]]) {
        
        view = [view superview];
        
    }
    
    UITableViewCell *cell = (UITableViewCell *)view;
    
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    
    if (rect.origin.y / 2 + rect.size.height >= self.view.frame.size.height - 216) {
        
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 216 + 50, 0);
        
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }
    
    return YES;
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return YES;
}

#pragma mark - navigationBar btnAction

- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    // 保存数据
}

- (void)rightBtnClick:(id)sender
{
    // 清空数据
}

#pragma mark - hide keyboard

-(void)hideKeyBoard{
    
    [self.tableView endEditing:YES];
    
}

#pragma mark - select btnAction

- (void)selectYesClick:(UIButton *)sender
{
    AddInterfaceCellThree *cell = (AddInterfaceCellThree *)[[sender superview] superview];
    //UIButton *takeLineBtn = [cell.contentView viewWithTag:sender.tag];
    
    if (self.yesState == NO && self.noState == NO) {
        [cell.selectYes setBackgroundImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
        [cell.selectNo setBackgroundImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
    }
    
    if (self.yesState == NO && self.noState == YES) {
        [cell.selectYes setBackgroundImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
        [cell.selectNo setBackgroundImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
        self.noState = !self.noState;
    }
    
    self.yesState = !self.yesState;
    
}

- (void)selectNoClick:(UIButton *)sender
{
    AddInterfaceCellThree *cell = (AddInterfaceCellThree *)[[sender superview] superview];
    //UIButton *takeLineBtn = [cell.contentView viewWithTag:sender.tag];
    if (self.yesState == NO && self.noState == NO) {
        [cell.selectYes setBackgroundImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
        [cell.selectNo setBackgroundImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
        
    }
    
    if (self.yesState == YES && self.noState == NO) {
        [cell.selectYes setBackgroundImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
        [cell.selectNo setBackgroundImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
        self.yesState = !self.yesState;
        
    }

    self.noState = !self.noState;

}

#pragma mark - payment btnAction

- (void)payStyleBtnClick:(UIButton *)sender
{
    AddInterfaceCellSix *cell = (AddInterfaceCellSix *)[[sender superview] superview];
    UIButton *paymentBtn = [cell.contentView viewWithTag:sender.tag];
    switch (paymentBtn.tag) {
        case operatorPay:
        {
            if (self.operatorPay == NO) {
                [cell.operatorBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_yes"] forState:UIControlStateNormal];
            }else{
                [cell.operatorBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_no"] forState:UIControlStateNormal];
            }
            self.operatorPay = !self.operatorPay;
        }
            break;
        case wechatPay:
        {
            if (self.wechatPay == NO) {
                [cell.weChatBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_yes"] forState:UIControlStateNormal];
            }else{
                [cell.weChatBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_no"] forState:UIControlStateNormal];
            }
            self.wechatPay = !self.wechatPay;
        }
            break;
        case aliPay:
        {
            if (self.aliPay == NO) {
                [cell.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_yes"] forState:UIControlStateNormal];
            }else{
                [cell.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_no"] forState:UIControlStateNormal];
            }
            self.aliPay = !self.aliPay;
        }
            break;
        case creditCardPay:
        {
            if (self.creditPay == NO) {
                [cell.creditCardBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_yes"] forState:UIControlStateNormal];
            }else{
                [cell.creditCardBtn setBackgroundImage:[UIImage imageNamed:@"checkBox_no"] forState:UIControlStateNormal];
            }
            self.creditPay = !self.creditPay;
        }
            break;
        default:
            break;
    }
}

@end
