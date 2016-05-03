//
//  AddPileViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/23.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileViewController.h"
#import "AddInterfaceViewController.h"
#import "CustomImagePickerViewController.h"
#import "AddPileMainView.h"

#import "NSSystemDate.h"
#import "NSFileManager+FileCategory.h"

#import "CustomCellTwo.h"


/**
 接口类型
 */
typedef enum {
    
    gd = 1, // 国电
    pt,     // 普天
    tld,    // 特来电
    hssy,   // 华商三优
    nfdw,   // 南方电网
    zsh,    // 中石化
    fdkj,   // 富电科技
    atx,    // 奥特迅
    wbjt,   // 万邦集团
    wmgf,   // 万马股份
    xxcd,   // 星星充电
    ywny,   // 依威能源
    tsl,    // 特斯拉
    acw,    // 爱充网
    cdw,    // 充电网
    dz      // 电桩
    
}pileBrand;

@interface AddPileViewController ()<AddPileMainViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,CustomImagePickerDelegate, CLImageEditorDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) AddPileMainView* tableView;

@property (assign, nonatomic) BOOL isChooseLogoDetailIV;

@end

@implementation AddPileViewController

- (instancetype)init{
    
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
    [self loadNavigationBar];
    [self addNotification];
}
#pragma mark - 初始化组件
- (void)loadMainView{
    self.tableView = self.containerView.subviews[0];
    self.tableView.mainViewDelegate = self;
    self.tableView.dataArray = self.dataArray;
    self.tableView.interfaceArray = self.interfaceArray;
    
    /**
     *  数据回显
     */
    if (self.addPile) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self assignment];
        });
       
    }
        
}

- (void)assignment
{
    
    //self.tableView.addPile = _addPile;
    //return;
    
    // 电桩品牌
    switch (self.addPile.pile_pile.pileResourceBrandId) {
        case gd:
            self.tableView.pileBrandLabel.text = GD;
            break;
        case pt:
            self.tableView.pileBrandLabel.text = PT;
            break;
        case tld:
            self.tableView.pileBrandLabel.text = TLD;
            break;
        case hssy:
            self.tableView.pileBrandLabel.text = HSSY;
            break;
        case nfdw:
            self.tableView.pileBrandLabel.text = NFDW;
            break;
        case zsh:
            self.tableView.pileBrandLabel.text = ZSH;
            break;
        case fdkj:
            self.tableView.pileBrandLabel.text = FDKJ;
            break;
        case atx:
            self.tableView.pileBrandLabel.text = ATX;
            break;
        case wbjt:
            self.tableView.pileBrandLabel.text = WBJT;
            break;
        case wmgf:
            self.tableView.pileBrandLabel.text = WMGF;
            break;
        case xxcd:
            self.tableView.pileBrandLabel.text = XXCD;
            break;
        case ywny:
            self.tableView.pileBrandLabel.text = YWNY;
            break;
        case tsl:
            self.tableView.pileBrandLabel.text = TSL;
            break;
        case acw:
            self.tableView.pileBrandLabel.text = ACW;
            break;
        case cdw:
            self.tableView.pileBrandLabel.text = CDW;
            break;
        case dz:
            self.tableView.pileBrandLabel.text = DZ;
            break;
        default:
            break;
    }
    // 电桩运营商
    switch (self.addPile.pile_pile.pileResourceOperatorId) {
        case gd:
            self.tableView.pileOperatorLabel.text = GD;
            break;
        case pt:
            self.tableView.pileOperatorLabel.text = PT;
            break;
        case tld:
            self.tableView.pileOperatorLabel.text = TLD;
            break;
        case hssy:
            self.tableView.pileOperatorLabel.text = HSSY;
            break;
        case nfdw:
            self.tableView.pileOperatorLabel.text = NFDW;
            break;
        case zsh:
            self.tableView.pileOperatorLabel.text = ZSH;
            break;
        case fdkj:
            self.tableView.pileOperatorLabel.text = FDKJ;
            break;
        case atx:
            self.tableView.pileOperatorLabel.text = ATX;
            break;
        case wbjt:
            self.tableView.pileOperatorLabel.text = WBJT;
            break;
        case wmgf:
            self.tableView.pileOperatorLabel.text = WMGF;
            break;
        case xxcd:
            self.tableView.pileOperatorLabel.text = XXCD;
            break;
        case ywny:
            self.tableView.pileOperatorLabel.text = YWNY;
            break;
        case tsl:
            self.tableView.pileOperatorLabel.text = TSL;
            break;
        case acw:
            self.tableView.pileOperatorLabel.text = ACW;
            break;
        case cdw:
            self.tableView.pileOperatorLabel.text = CDW;
            break;
        case dz:
            self.tableView.pileOperatorLabel.text = DZ;
            break;
        default:
            break;
    }
    
    // 照片logo
    if (self.addPile.pile_pile.logoDetailImagePath) {
        if([self.addPile.pile_pile.logoDetailImagePath containsString:@"http"]){
            [self.tableView.logoDetailImageView sd_setImageWithURL:[NSURL URLWithString:self.addPile.pile_pile.logoDetailImagePath]];
        }else{
            NSData * data = [NSData dataWithContentsOfFile:self.addPile.pile_pile.logoDetailImagePath];
            self.tableView.logoDetailImageView.image = [UIImage imageWithData:data];
        }
    }
    
    // logo照片描述
    self.tableView.logoDetailTextView.text = self.addPile.pile_pile.comment7;
    
}


- (void)loadNavigationBar{
    self.navigationItem.title = @"新增电桩";
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.rightBarButtonItem = saveBtnItem;

}

- (void)cancelClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClick:(UIButton *)sender
{
    /**
     *  数据存储
     */
    if(!self.addPile){
        self.addPile = [[Pile alloc] init];
        [self.dataArray addObject:self.addPile];
    }
    
    // 电桩品牌
    if ([self.tableView.pileBrandLabel.text isEqualToString:GD]) {
        self.addPile.pile_pile.pileResourceBrandId = 1;
    }else if([self.tableView.pileBrandLabel.text isEqualToString:PT]){
        self.addPile.pile_pile.pileResourceBrandId = 2;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:TLD]){
        self.addPile.pile_pile.pileResourceBrandId = 3;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:HSSY]){
        self.addPile.pile_pile.pileResourceBrandId = 4;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:NFDW]){
        self.addPile.pile_pile.pileResourceBrandId = 5;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:ZSH]){
        self.addPile.pile_pile.pileResourceBrandId = 6;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:FDKJ]){
        self.addPile.pile_pile.pileResourceBrandId = 7;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:ATX]){
        self.addPile.pile_pile.pileResourceBrandId = 8;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:WBJT]){
        self.addPile.pile_pile.pileResourceBrandId = 9;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:WMGF]){
        self.addPile.pile_pile.pileResourceBrandId = 10;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:XXCD]){
        self.addPile.pile_pile.pileResourceBrandId = 11;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:YWNY]){
        self.addPile.pile_pile.pileResourceBrandId = 12;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:TSL]){
        self.addPile.pile_pile.pileResourceBrandId = 13;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:ACW]){
        self.addPile.pile_pile.pileResourceBrandId = 14;
    }else if ([self.tableView.pileBrandLabel.text isEqualToString:CDW]){
        self.addPile.pile_pile.pileResourceBrandId = 15;
    }else{
        self.addPile.pile_pile.pileResourceBrandId = 16;
    }
    
    // 电桩运营商
    if ([self.tableView.pileOperatorLabel.text isEqualToString:GD]) {
        self.addPile.pile_pile.pileResourceOperatorId = 1;
    }else if([self.tableView.pileOperatorLabel.text isEqualToString:PT]){
        self.addPile.pile_pile.pileResourceOperatorId = 2;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:TLD]){
        self.addPile.pile_pile.pileResourceOperatorId = 3;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:HSSY]){
        self.addPile.pile_pile.pileResourceOperatorId = 4;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:NFDW]){
        self.addPile.pile_pile.pileResourceOperatorId = 5;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:ZSH]){
        self.addPile.pile_pile.pileResourceOperatorId = 6;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:FDKJ]){
        self.addPile.pile_pile.pileResourceOperatorId = 7;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:ATX]){
        self.addPile.pile_pile.pileResourceOperatorId = 8;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:WBJT]){
        self.addPile.pile_pile.pileResourceOperatorId = 9;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:WMGF]){
        self.addPile.pile_pile.pileResourceOperatorId = 10;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:XXCD]){
        self.addPile.pile_pile.pileResourceOperatorId = 11;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:YWNY]){
        self.addPile.pile_pile.pileResourceOperatorId = 12;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:TSL]){
        self.addPile.pile_pile.pileResourceOperatorId = 13;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:ACW]){
        self.addPile.pile_pile.pileResourceOperatorId = 14;
    }else if ([self.tableView.pileOperatorLabel.text isEqualToString:CDW]){
        self.addPile.pile_pile.pileResourceOperatorId = 15;
    }else{
        self.addPile.pile_pile.pileResourceOperatorId = 16;
    }
    
    // 桩细节图片
    if(self.isChooseLogoDetailIV){ 
        NSData * data = UIImagePNGRepresentation(self.tableView.logoDetailImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_DETAIL_FOLDER,imagePath] withData:data];
        self.addPile.pile_pile.logoDetailImagePath = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_DETAIL_FOLDER,imagePath];
    }
    
    // 桩细节描述
    self.addPile.pile_pile.comment7 = self.tableView.logoDetailTextView.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice) name:@"reloadVC" object:nil];
}

- (void)notice{
    [self.tableView reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadVC" object:nil];
}

#pragma mark - custom delegete
- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index{
    if(index==0){
        UIImagePickerController * con=[[UIImagePickerController alloc]init];
        con.sourceType=UIImagePickerControllerSourceTypeCamera;
        con.allowsEditing=YES;
        con.delegate=self;
        [self presentViewController:con animated:YES completion:nil];
    }else if (index==1){
        CustomImagePickerViewController * con=[CustomImagePickerViewController new];
        con.imagePickerDelegate=self;
        [self presentViewController:con animated:YES completion:nil];
    }
}

- (void)customImagePickerWithChooseImage:(NSArray *)resultArray{
    if(resultArray.count){
        GJCFAsset * asset = [resultArray firstObject];
        self.tableView.logoDetailImageView.image = asset.fullResolutionImage;
        self.isChooseLogoDetailIV = YES;
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
    self.tableView.logoDetailImageView.image = image;
    [editor dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    self.tableView.logoDetailImageView.image = image;
    self.isChooseLogoDetailIV = YES;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self editorImageWithImage:image];
    }];
    
}

- (void)itemSelectedWithMainView:(AddPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath
{
    AddInterfaceViewController *addInterfaceVC  =[[AddInterfaceViewController alloc]init];
    addInterfaceVC.interface = self.interfaceArray[indexPath.row];
    [self.navigationController pushViewController:addInterfaceVC animated:YES];
    
}

- (void)addPileInterface:(AddPileMainView *)mainView
{
    AddInterfaceViewController *addInterfaceVC = [[AddInterfaceViewController alloc] init];
    addInterfaceVC.dataArray = self.interfaceArray;
    [self.navigationController pushViewController:addInterfaceVC animated:YES];
}

#pragma mark --------------------------------------------------
//- (NSMutableArray *)dataArray{
//    if(_dataArray == nil){
//        NSMutableArray * array = [PileVillageInfo sharedPileVillageInfo].sites;
//        _dataArray = array?:[[NSMutableArray alloc]init];
//    }
//    return _dataArray;
//}
//
//- (NSMutableArray *)addPileArray{
//    if(_addPileArray == nil){
//        NSMutableArray *array = self.pileGroupInfo.piles;
//        _addPileArray = array ?:[[NSMutableArray alloc] init];
//    }
//    return _addPileArray;
//}

#pragma mark --------------------------------------------------


- (NSMutableArray *)dataArray{
    if(_dataArray == nil){
        NSMutableArray *array = [PileGroupInfo sharedPileGroupInfo].piles;
        _dataArray = array ?:[[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)interfaceArray{
    if(_interfaceArray == nil){
        NSMutableArray *array = self.addPile.interfaces;
        _interfaceArray = array?:[[NSMutableArray alloc]init];
    }
    return _interfaceArray;
}

@end

