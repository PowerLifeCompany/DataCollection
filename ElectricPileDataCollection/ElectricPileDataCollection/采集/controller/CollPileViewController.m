//
//  CollPileViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CollPileViewController.h"
#import "CustomImagePickerViewController.h"
#import "ChargeStandardViewController.h"
#import "PileInfoViewController.h"
#import "FeesDetailViewController.h"
#import "AddPileViewController.h"
#import "UIView+LayoutCornerRadius.h"
#import "CollPileMainView.h"
#import "NSSystemDate.h"
#import "Area.h"

#import "NSFileManager+FileCategory.h"

@interface CollPileViewController ()<CollPileMainViewDelegate,RequestUtilDelegate,CustomImagePickerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLImageEditorDelegate>

@property(nonatomic,strong)RequestUtil * requestUtil;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) CollPileMainView * tableView;

@property(nonatomic,assign)BOOL isChooseToGoIV;

@property(nonatomic,assign)BOOL isChooseEntranceIV;

@property(nonatomic,strong)PileVillageInfo * info;


@end

@implementation CollPileViewController

- (instancetype)init
{
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
    [self.nextStepBtn layoutCornerRadiusWithCornerRadius:5];
    self.tableView.mainViewDelegate = self;
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"小区信息(1/3)";
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.rightBarButtonItem = saveBtnItem;
    
}

- (void)backClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveClick:(UIButton *)sender
{
    [self saveData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStep:(UIButton *)sender {
    
    [self saveData];
    PileInfoViewController *pileInfoVC = [[PileInfoViewController alloc] init];
    [self.navigationController pushViewController:pileInfoVC animated:YES];
}

- (void)saveData{
    PileVillageInfo * info =self.info;
    info.pile_village.comment1=self.tableView.toGoCommentTextView.text;
    info.pile_village.comment2=self.tableView.villageEntranceTextView.text;
    
    if(self.isChooseToGoIV){
        NSData * data = UIImagePNGRepresentation(self.tableView.toGoImageView.image);
        NSString * imagePath = IMAGE_PATH_PILE_VILLAGE_ENTRY;
        [NSFileManager writeToFile:imagePath withData:data];
        info.pile_village.villagePathImagePath=imagePath;
    }
    if(self.isChooseEntranceIV){
        NSData * data = UIImagePNGRepresentation(self.tableView.villageEntranceImageView.image);
        NSString * imagePath = IMAGE_PATH_PILE_VILLAGE_GATE;
        [NSFileManager writeToFile:imagePath withData:data];
        info.pile_village.villageEntranceImagePath=imagePath;
    }
}

#pragma mark - 自定义代理
- (void)itemSelectedWithMainView:(CollPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1){
        NSString * url=[NSString stringWithFormat:GET_ALL_VILLAGE_URL,[PileVillageInfo sharedPileVillageInfo].districtid];
        [self.requestUtil asyncThirdLibWithUrl:url andParameters:nil andMethod:RequestMethodGet andTimeoutInterval:10];
    }
}

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

- (void)addVillageInfoWithVillageName:(NSString *)villageName{
    ;
    NSString * params =[NSString stringWithFormat:@"data=userId:0;areaid:%ld;name:%@;code:",self.info.areaid,villageName];
    [self.requestUtil asyncThirdLibWithUrl:ADD_VILLAGE_URL andParameters:[RequestUtil getParamsWithString:params] andMethod:RequestMethodGet andTimeoutInterval:10];
}

- (void)customImagePickerWithChooseImage:(NSArray *)resultArray{
    if(resultArray.count){
        GJCFAsset * asset=[resultArray firstObject];
        self.tableView.currentImageView.image=asset.fullResolutionImage;
        if(self.tableView.currentImageView.tag==101){//第一张图片
            self.isChooseToGoIV=YES;
        }else if (self.tableView.currentImageView.tag==102){//第二张图片
            self.isChooseEntranceIV=YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self editorImageWithImage:asset.fullResolutionImage];
        });
    }
}

#pragma mark - UIImagePickViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    self.tableView.currentImageView.image=image;
    if(self.tableView.currentImageView.tag==101){//第一张图片
        self.isChooseToGoIV=YES;
    }else if (self.tableView.currentImageView.tag==102){//第二张图片
        self.isChooseEntranceIV=YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self editorImageWithImage:image];
    }];
}

- (void)editorImageWithImage:(UIImage *)image{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image delegate:self];
    editor.title=@"图片编辑";
    [self presentViewController:editor animated:YES completion:nil];
}

- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image{
    self.tableView.currentImageView.image=image;
    [editor dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 下载数据
- (void)response:(NSURLResponse *)response andError:(NSError *)error andData:(NSData *)data andStatusCode:(NSInteger)statusCode andURLString:(NSString *)urlString{
    if(statusCode==200 && !error){
        if([urlString isEqualToString:ADD_VILLAGE_URL]){
            NSInteger villageId = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] integerValue];
            NSLog(@"小区ID：%ld",villageId);
            if(villageId==-1){
                [self.view addSubview:[CustomPopupView customPopupViewWithMsg:@"新增小区失败"]];
            }else{
                self.info.pile_village.Id=villageId;
            }
            return;
        }
//        NSArray * tmpArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSMutableArray * dataArray =[[NSMutableArray alloc]init];
//        for (NSDictionary * dict in tmpArray) {
//            [dataArray addObject:[Area areaWithDict:dict]];
//        }
//        self.tableView.villageDataArray=dataArray;
    }else{
        NSLog(@"%@",error);
        [self.view addSubview:[CustomPopupView customPopupViewWithMsg:FINAL_DATA_REQUEST_FAIL]];
    }
}
#pragma mark - 懒加载
- (RequestUtil *)requestUtil{
    if(_requestUtil==nil){
        _requestUtil=[[RequestUtil alloc]init];
        _requestUtil.delegate=self;
    }
    return _requestUtil;
}

- (PileVillageInfo *)info{
    return [PileVillageInfo sharedPileVillageInfo];
}

#pragma mark - 系统协议方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AppDelegate customTabbar].hidden=YES;
}
@end
