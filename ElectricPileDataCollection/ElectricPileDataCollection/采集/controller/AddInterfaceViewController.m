//
//  AddInterfaceViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/19.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddInterfaceViewController.h"
#import "AddInterfaceMainView.h"
#import "CustomImagePickerViewController.h"

#import "NSSystemDate.h"
#import "NSFileManager+FileCategory.h"

#define FAST_INTERNATION @"快--国际"
#define FAST_DOMESTIC @"快--非国际"
#define SLOW_INTERNATION @"慢--国际"
#define SLOW_DOMESTIC @"慢--非国际"

#define OPERATOR @"1"
#define WECHAT   @"2"
#define ALI      @"3"
#define CREDITCARD @"4"

/**
 接口类型
 */
typedef enum {
    
    fastInternational = 1, // 快--国际
    fastDomestic,      // 快--非国际
    slowInternational, // 慢--国际
    slowDomestic       // 慢--非国际
    
}interfaceType;

/**
 *  电桩是否带充电线
 */
typedef enum {
    
    takeChargingLineYes = 0, // 带充电线
    takeChargingLineNo      // 不带充电线
    
}isTakeChargingLine;

/**
 *  支付方式
 */
typedef enum {
    
    operator = 1, // 运营商专用卡
    wechat,       // 微信
    aLi,          // 支付宝
    creditCard    // 信用卡
    
}payType;


@interface AddInterfaceViewController ()<AddInterfaceMainViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, CustomImagePickerDelegate, CLImageEditorDelegate>

@property (weak, nonatomic) AddInterfaceMainView *tableView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (assign, nonatomic) BOOL isChooseInterfaceIV;

@property (assign, nonatomic) BOOL isChooseInterfaceDetailIV;

@property (strong, nonatomic) NSMutableArray *payTypeArray;

@end

@implementation AddInterfaceViewController

- (instancetype)init{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
}

#pragma mark - 初始化组件
- (void)loadMainView{
    self.tableView = self.containerView.subviews[0];
    self.tableView.mainViewDelegate = self;
    self.payTypeArray = [NSMutableArray array];
    
    /**
     *  数据回显
     */
    if (self.interface) {
        
        // 接口类型
        switch (self.interface.pileResourceInterfaceId) {
            case fastInternational:
                self.tableView.currentLabel.text = @"快--国际";
                break;
            case fastDomestic:
                self.tableView.currentLabel.text = @"慢--国际";
                break;
            case slowInternational:
                self.tableView.currentLabel.text = @"快--非国际";
                break;
            case slowDomestic:
                self.tableView.currentLabel.text = @"慢--非国际";
                break;
            default:
                break;
        }
        
        // 服务费
        self.tableView.serviceFeeTextField.text = [NSString stringWithFormat:@"%f",self.interface.tariffService];
        
        // 电桩是否自带充电线
        switch (self.interface.hasChargeCable) {
            case takeChargingLineYes:{
                self.tableView.takeCharingTypeYesImageView.image = [UIImage imageNamed:@"select_yes"];
                self.tableView.takeCharingTypeNoImageView.image = [UIImage imageNamed:@"select_no"];
            }
            break;
            case takeChargingLineNo:{
                self.tableView.takeCharingTypeYesImageView.image = [UIImage imageNamed:@"select_no"];
                self.tableView.takeCharingTypeNoImageView.image = [UIImage imageNamed:@"select_yes"];
            }
            break;
            default:
                break;
        }
        
        // 接口个数
        self.tableView.interfaceNumTextField.text = [NSString stringWithFormat:@"%ld", self.interface.num];
        
        // 重量
        self.tableView.weightTextField.text = [NSString stringWithFormat:@"%ld", self.interface.weight];
        
        // 电压-V
        self.tableView.voltageTextField.text = [NSString stringWithFormat:@"%f", self.interface.voltage];
        
        // 电压-A
        self.tableView.currentTextField.text = [NSString stringWithFormat:@"%f", self.interface.current];
        
        // 充电单价-忙时
        NSArray *busyIntervalArray = [self.interface.tariffChargeBusyInterval componentsSeparatedByString:@","];
        // 开始时间
        self.tableView.busyStartTextField.text = busyIntervalArray[0];
        // 结束时间
        self.tableView.busyEndTextField.text = busyIntervalArray[1];
        // 充电单价-忙时-价格
        self.tableView.busyPriceTextField.text = [NSString stringWithFormat:@"%f",self.interface.tariffChargeBusy];
        
        // 充电单价-闲时
        NSArray *idleIntervalArray = [self.interface.tariffChargeIdleInterval componentsSeparatedByString:@","];
        // 开始时间
        self.tableView.idleStartTextField.text = idleIntervalArray[0];
        // 结束时间
        self.tableView.idleEndTextField.text = idleIntervalArray[1];
        // 充电单价-闲时-价格
        self.tableView.idlePriceTextField.text = [NSString stringWithFormat:@"%f", self.interface.tariffChargeIdle];
        
        // 支付方式
        NSArray *payArray = [self.interface.paymentType componentsSeparatedByString:@","];
        // 运营商运营卡
        if ([payArray containsObject:OPERATOR]) {
            self.tableView.payOpetator.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
             self.tableView.payOpetator.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 微信
        if ([payArray containsObject:WECHAT]) {
            self.tableView.payWechat.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            self.tableView.payWechat.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 支付宝
        if ([payArray containsObject:ALI]) {
            self.tableView.payAli.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            self.tableView.payAli.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 信用卡
        if ([payArray containsObject:CREDITCARD]) {
            self.tableView.payCreditCard.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            self.tableView.payCreditCard.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 充电口-正片照-图片
        if([self.interface.chargingMouthImagePath containsString:@"http"]){
            [self.tableView.interfaceImageView sd_setImageWithURL:[NSURL URLWithString:self.interface.chargingMouthImagePath]];
        }else{
            NSData * data = [NSData dataWithContentsOfFile:self.interface.chargingMouthImagePath];
            self.tableView.interfaceImageView.image=[UIImage imageWithData:data];
        }
        
        // 充电口-正片照-文字
        self.tableView.interfaceTextView.text = self.interface.comment8;
        
        // 充电把-照片
        if([self.interface.detailImagePath containsString:@"http"]){
            [self.tableView.interfaceDetailsImageView sd_setImageWithURL:[NSURL URLWithString:self.interface.detailImagePath]];
        }else{
            NSData * data = [NSData dataWithContentsOfFile:self.interface.detailImagePath];
            self.tableView.interfaceDetailsImageView.image=[UIImage imageWithData:data];
        }
        
        // 充电把-文字
        self.tableView.interfaceDetailTextView.text = self.interface.comment9;
        
        // 特殊说明
        self.tableView.instructionsTextView.text = self.interface.comment;
        
    }
    
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"新增接口";
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.leftBarButtonItem = saveBtnItem;
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.rightBarButtonItem = cancelBtnItem;
}

- (void)saveClick:(UIButton *)sender
{
    if(!self.interface){
        self.interface = [[PileInterface alloc]init];
        [self.dataArray addObject:self.interface];
    }
    
    /**
     *  保存数据
     */
    
    // 接口类型
    if ([self.tableView.currentLabel.text isEqualToString:FAST_INTERNATION]) {
        self.interface.pileResourceInterfaceId = 0;
    }else if ([self.tableView.currentLabel.text isEqualToString:FAST_DOMESTIC]){
        self.interface.pileResourceInterfaceId = 1;
    }else if ([self.tableView.currentLabel.text isEqualToString:SLOW_INTERNATION]){
        self.interface.pileResourceInterfaceId = 2;
    }else{
        self.interface.pileResourceInterfaceId = 3;
    }
    
    // 服务费
    self.interface.tariffService = [self.tableView.serviceFeeTextField.text doubleValue];
    
    // 电桩是否自带充电线
    if (self.tableView.isTakeChargingLine == YES) {
        self.interface.hasChargeCable = 0;
    }else{
        self.interface.hasChargeCable = 1;
    }
    
    // 接口个数
    self.interface.num = [self.tableView.interfaceNumTextField.text integerValue];
    
    // 重量
    self.interface.weight = [self.tableView.weightTextField.text integerValue];
    
    // 电压
    self.interface.voltage = [[NSString stringWithFormat:@"%@,%@",self.tableView.currentTextField.text, self.tableView.voltageTextField.text] doubleValue];
    
    // 忙时-时间间隔
    self.interface.tariffChargeBusyInterval = [NSString stringWithFormat:@"%@,%@", self.tableView.busyStartTextField.text, self.tableView.busyEndTextField.text];
    
    // 忙时-价格
    self.interface.tariffChargeBusy = [self.tableView.busyPriceTextField.text doubleValue];
    
    // 闲时-时间间隔
    self.interface.tariffChargeIdleInterval = [NSString stringWithFormat:@"%@,%@", self.tableView.idleStartTextField.text, self.tableView.idleEndTextField.text];
    
    // 闲时-价格
    self.interface.tariffChargeIdle = [self.tableView.idlePriceTextField.text doubleValue];
    
    // 支付方式
    self.interface.paymentType = [self.payTypeArray componentsJoinedByString:@","];
    
    // 充电口 正面照
    if(self.isChooseInterfaceIV){
        NSData * data = UIImagePNGRepresentation(self.tableView.interfaceImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_INTERFACE_FRONT_FOLDER,imagePath] withData:data];
        self.interface.chargingMouthImagePath = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_INTERFACE_FRONT_FOLDER,imagePath];
    }
    
    // 充电口 文字描述
    self.interface.comment8 = self.tableView.interfaceTextView.text;
    
    // 充电把 正面照
    if(self.isChooseInterfaceDetailIV){
        NSData * data = UIImagePNGRepresentation(self.tableView.interfaceDetailsImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_INTERFACE_HANDLER_FOLDER,imagePath] withData:data];
        self.interface.chargingMouthImagePath = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_INTERFACE_HANDLER_FOLDER,imagePath];
    }
    
    // 充电把  文字描述
    self.interface.comment9 = self.tableView.interfaceDetailTextView.text;
    
    // 特殊说明
    self.interface.comment = self.tableView.instructionsTextView.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma custom delegete
- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index{
    if(index == 0){
        UIImagePickerController * con =[[UIImagePickerController alloc]init];
        con.sourceType=UIImagePickerControllerSourceTypeCamera;
        con.allowsEditing = YES;
        con.delegate = self;
        [self presentViewController:con animated:YES completion:nil];
    }else if (index==1){
        CustomImagePickerViewController * con =[CustomImagePickerViewController new];
        con.imagePickerDelegate = self;
        [self presentViewController:con animated:YES completion:nil];
    }
}

- (void)customImagePickerWithChooseImage:(NSArray *)resultArray{
    
    if(resultArray.count){
        GJCFAsset * asset = [resultArray firstObject];
        self.tableView.currentImageView.image = asset.fullResolutionImage;
        if(self.tableView.currentImageView.tag == 6000){
            // 第一张图片
            self.isChooseInterfaceIV = YES;
        }else if(self.tableView.currentImageView.tag == 6001){
            // 第二张图片
            self.isChooseInterfaceDetailIV = YES;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self editorImageWithImage:asset.fullResolutionImage];
        });
    }
}

- (void)editorImageWithImage:(UIImage *)image{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image delegate:self];
    editor.title = @"图片编辑";
    [self presentViewController:editor animated:YES completion:nil];
}

- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image{
    self.tableView.currentImageView.image=image;
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)chooseTakeChargingType:(AddInterfaceMainView *)mainView
{
    if (mainView.isTakeChargingLine == YES) {
        mainView.takeCharingTypeYesImageView.image = [UIImage imageNamed:@"select_yes"];
        mainView.takeCharingTypeNoImageView.image = [UIImage imageNamed:@"select_no"];
    }else{
        mainView.takeCharingTypeYesImageView.image = [UIImage imageNamed:@"select_no"];
        mainView.takeCharingTypeNoImageView.image = [UIImage imageNamed:@"select_yes"];
    }
}

- (void)choosePayType:(AddInterfaceMainView *)mainView payTypeTap:(UITapGestureRecognizer *)tap
{
    if ([tap view].tag == 8000) {
        // 运营商专用卡
        if (mainView.isChoosepayOpetator == NO) {
            mainView.payOpetator.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payTypeArray addObject:OPERATOR];
        }else{
            mainView.payOpetator.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payTypeArray removeObject:OPERATOR];
        }
        mainView.isChoosepayOpetator = !mainView.isChoosepayOpetator;
    }else if([tap view].tag == 8001){
        // 微信
        if (mainView.isChoosepayWechat == NO) {
            mainView.payWechat.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payTypeArray addObject:WECHAT];
        }else{
            mainView.payWechat.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payTypeArray removeObject:WECHAT];
        }
        mainView.isChoosepayWechat = !mainView.isChoosepayWechat;

    }else if ([tap view].tag == 8002){
        // 支付宝
        if (mainView.isChoosepayAli == NO) {
            mainView.payAli.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payTypeArray addObject:ALI];
        }else{
            mainView.payAli.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payTypeArray removeObject:ALI];
        }
        mainView.isChoosepayAli = !mainView.isChoosepayAli;
        
    }else{
        // 信用卡
        if (mainView.isChoosepayCreditCard == NO) {
            mainView.payCreditCard.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payTypeArray addObject:CREDITCARD];
        }else{
            mainView.payCreditCard.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payTypeArray removeObject:CREDITCARD];
        }
        mainView.isChoosepayCreditCard = !mainView.isChoosepayCreditCard;
    }
    
    
    NSLog(@"支付方式:%@", self.payTypeArray);
}

#pragma mark - UIImagePickViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    self.tableView.currentImageView.image = image;
    
    if(self.tableView.currentImageView.tag == 6000){
        // 第一张图片
        self.isChooseInterfaceIV = YES;
    }else if (self.tableView.currentImageView.tag == 6001){
        // 第二张图片
        self.isChooseInterfaceDetailIV = YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self editorImageWithImage:image];
    }];
}

@end
