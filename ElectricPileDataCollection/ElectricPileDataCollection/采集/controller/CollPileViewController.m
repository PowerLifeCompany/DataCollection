//
//  CollPileViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CollPileViewController.h"
#import "CustomImagePickerViewController.h"
#import "AddPileViewController.h"
#import "UIView+LayoutCornerRadius.h"
#import "CollPileMainView.h"
#import "Area.h"
#import "PileInfoViewController.h"

@interface CollPileViewController ()<CollPileMainViewDelegate,RequestUtilDelegate,CustomImagePickerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)RequestUtil * requestUtil;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@property (weak, nonatomic) CollPileMainView * tableView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

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
    self.tableView=self.containerView.subviews[0];
    [self.nextStepBtn layoutCornerRadiusWithCornerRadius:5];
    self.tableView.mainViewDelegate=self;
    
    //测试按钮
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, HEIGHT-220, 100, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=BOY_BG_COLOR;
    [btn setTitle:@"跳转按钮" forState:UIControlStateNormal];
}

- (void)testBtn{
    AddPileViewController * con=[[AddPileViewController alloc]init];
    
    
    [self.navigationController pushViewController: con animated:YES];
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"小区信息";
}

- (IBAction)nextStep:(UIButton *)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PileInfoViewController" bundle:nil];
    PileInfoViewController *pileInfoVC = [sb instantiateViewControllerWithIdentifier:@"PileInfoViewController"];
    [self.navigationController pushViewController:pileInfoVC animated:YES];
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

- (void)customImagePickerWithChooseImage:(NSArray *)resultArray{
    if(resultArray.count){
        GJCFAsset * asset=[resultArray firstObject];
        NSData * data = UIImageJPEGRepresentation(asset.aspectRatioThumbnail, 1);
        self.tableView.currentImageView.image=[UIImage imageWithData:data];
    }
}

#pragma mark - UIImagePickViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    self.tableView.currentImageView.image=image;
//    NSData * data = UIImagePNGRepresentation(image);
    //加测试
    //写入到沙盒，按照一定的命名规则，暂时没做
    if(self.tableView.currentImageView.tag==101){//第一张图片
        
    }else if (self.tableView.currentImageView.tag==102){//第二张图片
        
    }
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 下载数据
- (void)response:(NSURLResponse *)response andError:(NSError *)error andData:(NSData *)data andStatusCode:(NSInteger)statusCode andURLString:(NSString *)urlString{
    if(statusCode==200 && !error){
        NSArray * tmpArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray * dataArray =[[NSMutableArray alloc]init];
        for (NSDictionary * dict in tmpArray) {
            [dataArray addObject:[Area areaWithDict:dict]];
        }
        self.tableView.villageDataArray=dataArray;
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

#pragma mark - 系统协议方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AppDelegate customTabbar].hidden=YES;
}
@end
