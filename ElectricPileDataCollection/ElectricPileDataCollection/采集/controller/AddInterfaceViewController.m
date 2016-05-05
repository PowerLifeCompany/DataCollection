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


@interface AddInterfaceViewController ()<AddInterfaceMainViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, CustomImagePickerDelegate, CLImageEditorDelegate, RequestUtilDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) AddInterfaceMainView *tableView;

@property(nonatomic,strong)RequestUtil * requestUtil;

@property (assign, nonatomic) BOOL isChooseInterfaceIV;

@property (assign, nonatomic) BOOL isChooseInterfaceDetailIV;

@property (assign, nonatomic) BOOL isTakeCharingTypeYesIV;

@property (assign, nonatomic) BOOL isTakeCharingTypeNoIV;

@property (assign, nonatomic) BOOL isChooseOperatorPayIV;

@property (assign, nonatomic) BOOL isChooseWechatPayIV;

@property (assign, nonatomic) BOOL isChooseAliPayIV;

@property (assign, nonatomic) BOOL isChooseCreditCardPayIV;

@property (strong, nonatomic) NSMutableArray *payArray;

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
    
    if (!self.tableView) {
        self.tableView = self.containerView.subviews[0];
        self.tableView.mainViewDelegate = self;
    }
    
    self.payArray = [NSMutableArray array];
    
    /**
     *  数据回显
     */
    if (self.interface) {
        // 接口类型
        switch (self.interface.pileResourceInterfaceId) {
            case fastInternational:
                self.tableView.interfaceTypeLabel.text = @"快--国标";
                break;
            case fastDomestic:
                self.tableView.interfaceTypeLabel.text = @"快--非国标";
                break;
            case slowInternational:
                self.tableView.interfaceTypeLabel.text = @"慢--国标";
                break;
            case slowDomestic:
                self.tableView.interfaceTypeLabel.text = @"慢--非国标";
                break;
            default:
                break;
        }
        // 服务费
        self.tableView.serviceFeeTextField.text = self.interface.tariffService;
        
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
        self.tableView.interfaceNumTextField.text = self.interface.num;
        // 重量
        self.tableView.weightTextField.text = self.interface.weight;
        // 电压-V
        self.tableView.voltageTextField.text = self.interface.voltage;
        // 电压-A
        self.tableView.currentTextField.text = self.interface.current;
        // 充电单价-忙时
        NSArray *busyIntervalArray = [self.interface.tariffChargeBusyInterval componentsSeparatedByString:@","];
        // 开始时间
        self.tableView.busyStartTextField.text = busyIntervalArray[0];
        // 结束时间
        self.tableView.busyEndTextField.text = busyIntervalArray[1];
        // 充电单价-忙时-价格
        self.tableView.busyPriceTextField.text = self.interface.tariffChargeBusy;
        // 充电单价-闲时
        NSArray *idleIntervalArray = [self.interface.tariffChargeIdleInterval componentsSeparatedByString:@","];
        // 开始时间
        self.tableView.idleStartTextField.text = idleIntervalArray[0];
        // 结束时间
        self.tableView.idleEndTextField.text = idleIntervalArray[1];
        // 充电单价-闲时-价格
        self.tableView.idlePriceTextField.text = self.interface.tariffChargeIdle;
        
        NSArray *payTypeArray = [self.interface.paymentType componentsSeparatedByString:@","];        
        /**
         *  支付方式
         */
        // 运营商专用卡
        if ([payTypeArray containsObject:OPERATOR]) {
            self.tableView.payOpetator.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
             self.tableView.payOpetator.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 微信
        if ([payTypeArray containsObject:WECHAT]) {
            self.tableView.payWechat.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            self.tableView.payWechat.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 支付宝
        if ([payTypeArray containsObject:ALI]) {
            self.tableView.payAli.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            self.tableView.payAli.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 信用卡
        if ([payTypeArray containsObject:CREDITCARD]) {
            self.tableView.payCreditCard.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            self.tableView.payCreditCard.image = [UIImage imageNamed:@"checkBox_no"];
        }
        
        // 充电口-正片照-图片
        if (self.interface.chargingMouthImagePath) {
            if([self.interface.chargingMouthImagePath containsString:@"http"]){
                [self.tableView.interfaceImageView sd_setImageWithURL:[NSURL URLWithString:self.interface.chargingMouthImagePath]];
            }else{
                NSData * data = [NSData dataWithContentsOfFile:self.interface.chargingMouthImagePath];
                self.tableView.interfaceImageView.image=[UIImage imageWithData:data];
            }
        }
        
        // 充电口-正片照-文字
        self.tableView.interfaceTextView.text = self.interface.comment8;
        
        if (self.interface.detailImagePath) {
            // 充电把-照片
            if([self.interface.detailImagePath containsString:@"http"]){
                [self.tableView.interfaceDetailsImageView sd_setImageWithURL:[NSURL URLWithString:self.interface.detailImagePath]];
            }else{
                NSData * data = [NSData dataWithContentsOfFile:self.interface.detailImagePath];
                self.tableView.interfaceDetailsImageView.image=[UIImage imageWithData:data];
            }

        }
        
        // 充电把-文字
        self.tableView.interfaceDetailTextView.text = self.interface.comment9;
        
        // 特殊说明
        self.tableView.instructionsTextView.text = self.interface.comment;
    }
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"新增接口";
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.rightBarButtonItem = saveBtnItem;
}

- (void)saveClick:(UIButton *)sender
{
    
    if(!self.interface){
        self.interface = [[PileInterface alloc]init];
        [self.dataArray addObject:self.interface];
    }
    
    if (!self.payArray) {
        self.payArray = [NSMutableArray array];
    }
    
    /**
     *  保存数据到模型
     */
    // 接口类型
    if ([self.tableView.currentLabel.text isEqualToString:FAST_INTERNATION]) {
        self.interface.pileResourceInterfaceId = 1;
    }else if ([self.tableView.currentLabel.text isEqualToString:FAST_DOMESTIC]){
        self.interface.pileResourceInterfaceId = 2;
    }else if ([self.tableView.currentLabel.text isEqualToString:SLOW_INTERNATION]){
        self.interface.pileResourceInterfaceId = 3;
    }else if ([self.tableView.currentLabel.text isEqualToString:SLOW_DOMESTIC]){
        self.interface.pileResourceInterfaceId = 4;
    }
    
    // 服务费
    self.interface.tariffService = self.tableView.serviceFeeTextField.text;
    
    // 是否自带充电线
    if (self.isTakeCharingTypeYesIV == YES) {
        self.interface.hasChargeCable = 0;
    }
    
    if (self.isTakeCharingTypeNoIV == YES) {
        self.interface.hasChargeCable = 1;
    }
    
    // 接口个数
    self.interface.num = self.tableView.interfaceNumTextField.text;
    
    // 重量
    self.interface.weight = self.tableView.weightTextField.text;
    
    // 电压
    self.interface.voltage = self.tableView.voltageTextField.text;
    
    // 电流
    self.interface.current = self.tableView.currentTextField.text;
    
    // 忙时-时间间隔
    self.interface.tariffChargeBusyInterval = [NSString stringWithFormat:@"%@,%@", self.tableView.busyStartTextField.text, self.tableView.busyEndTextField.text];
    
    // 忙时-价格
    self.interface.tariffChargeBusy = self.tableView.busyPriceTextField.text;
    
    // 闲时-时间间隔
    self.interface.tariffChargeIdleInterval = [NSString stringWithFormat:@"%@,%@", self.tableView.idleStartTextField.text, self.tableView.idleEndTextField.text];
    
    // 闲时-价格
    self.interface.tariffChargeIdle = self.tableView.idlePriceTextField.text;
    
    // 支付方式
    self.interface.paymentType = [self.payArray componentsJoinedByString:@","];
    
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
        self.interface.detailImagePath = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_INTERFACE_HANDLER_FOLDER,imagePath];
    }
    
    // 充电把  文字描述
    self.interface.comment9 = self.tableView.interfaceDetailTextView.text;
    
    // 特殊说明
    self.interface.comment = self.tableView.instructionsTextView.text;
    
    /**
     *  发送通知
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadVC" object:nil];
    
    
    /**
     *  上传图片
     */
    NSDictionary * headerDict = @{@"__provinceid":@(0),@"__cityid":@(0),@"__districtid":@(0),@"__areaid":@(0),@"__villageid":@(0),@"__parkingid":@(0),@"__siteid":@(0),@"__pileinterfaceid":@(0)};
    self.requestUtil.headerDict = headerDict;
    
    // 正面照
    NSData *frontImageData = [NSData dataWithContentsOfFile:self.interface.chargingMouthImagePath];
    NSString *frontUrlStr = [NSString stringWithFormat:UPLOAD_IMAGE,@"pile_interface_front"];
    [self.requestUtil uploadImageWithUrl:frontUrlStr andParameters:nil andData:frontImageData andTimeoutInterval:20];
    
    // 细节特写
    NSData *detailImageData = [NSData dataWithContentsOfFile:self.interface.detailImagePath];
    NSString *detailUrlStr = [NSString stringWithFormat:UPLOAD_IMAGE,@"pile_interface_handler"];
    [self.requestUtil uploadImageWithUrl:detailUrlStr andParameters:nil andData:detailImageData andTimeoutInterval:20];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma - custom delegete
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

- (void)chooseTakeChargingType:(AddInterfaceMainView *)mainView andTap:(UITapGestureRecognizer *)tap
{
    if ([tap view].tag == 7000) {
        mainView.takeCharingTypeYesImageView.image = [UIImage imageNamed:@"select_yes"];
        mainView.takeCharingTypeNoImageView.image = [UIImage imageNamed:@"select_no"];
        self.isTakeCharingTypeYesIV = YES;
        self.isTakeCharingTypeNoIV = NO;
        
    }else{
        mainView.takeCharingTypeYesImageView.image = [UIImage imageNamed:@"select_no"];
        mainView.takeCharingTypeNoImageView.image = [UIImage imageNamed:@"select_yes"];
        self.isTakeCharingTypeNoIV = YES;
        self.isTakeCharingTypeYesIV = NO;
    }
}

#pragma mark - 多选
- (void)choosePayType:(AddInterfaceMainView *)mainView payTypeTap:(UITapGestureRecognizer *)tap
{
    if ([tap view].tag == 8000) {
        if (mainView.isChoosepayOpetator == NO) {
            mainView.payOpetator.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payArray addObject:OPERATOR];
        }else{
            mainView.payOpetator.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payArray removeObject:OPERATOR];
        }
        mainView.isChoosepayOpetator = !mainView.isChoosepayOpetator;
        
    }else if ([tap view].tag == 8001){
        if (mainView.isChoosepayWechat == NO) {
            mainView.payWechat.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payArray addObject:WECHAT];
        }else{
            mainView.payWechat.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payArray removeObject:WECHAT];
        }
        mainView.isChoosepayWechat = !mainView.isChoosepayWechat;
    }else if ([tap view].tag == 8002){
        if (mainView.isChoosepayAli == NO) {
            mainView.payAli.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payArray addObject:ALI];
        }else{
            mainView.payAli.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payArray removeObject:ALI];
        }
        mainView.isChoosepayAli = !mainView.isChoosepayAli;
    }else{
        if (mainView.isChoosepayCreditCard == NO) {
            mainView.payCreditCard.image = [UIImage imageNamed:@"checkBox_yes"];
            [self.payArray addObject:CREDITCARD];
        }else{
            mainView.payCreditCard.image = [UIImage imageNamed:@"checkBox_no"];
            [self.payArray removeObject:CREDITCARD];
        }
        mainView.isChoosepayCreditCard = !mainView.isChoosepayCreditCard;
    }
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

#pragma mark - 返回数据
- (void)response:(NSURLResponse *)response andError:(NSError *)error andData:(NSData *)data andStatusCode:(NSInteger)statusCode andURLString:(NSString *)urlString{
    
    if (statusCode == 200 && !error) {
        
        if ([urlString isEqualToString:[NSString stringWithFormat:UPLOAD_IMAGE,@"pile_interface_front"]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.interface.imageUrl8 = dic[@"url"];
        }
        
        if ([urlString isEqualToString:[NSString stringWithFormat:UPLOAD_IMAGE,@"pile_interface_handler"]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.interface.imageUrl9 = dic[@"url"];
        }
    }else{
        NSLog(@"%@",error);
    }
}

#pragma mark - 懒加载
- (RequestUtil *)requestUtil{
    if(_requestUtil == nil){
        _requestUtil = [[RequestUtil alloc]init];
        _requestUtil.delegate = self;
    }
    return _requestUtil;
}

//- (NSMutableArray *)dataArray{
//    if(_dataArray == nil){
//        //NSMutableArray *array = self.addPile.interfaces;
//        //_dataArray = array?:[[NSMutableArray alloc]init];
//        _dataArray = [[NSMutableArray alloc] init];
//    }
//    return _dataArray;
//}

@end
