//
//  AddPileViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/11.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AddPileViewController.h"
#import "AddInterfaceViewController.h"
#import "CustomImagePickerViewController.h"
#import "AddPileMainView.h"

@interface AddPileViewController ()<AddPileMainViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,CustomImagePickerDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) AddPileMainView* tableView;

@property (strong, nonatomic)NSMutableArray *dataArray;

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
}

#pragma mark - 初始化组件
- (void)loadMainView{
    self.tableView = self.containerView.subviews[0];
    self.tableView.mainViewDelegate = self;
    self.tableView.dataArray = self.dataArray;
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"新增电桩";
}

#pragma mark - 自定义代理
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

- (void)itemSelectedWithMainView:(AddPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath
{
    AddInterfaceViewController *addInterfaceVC  =[[AddInterfaceViewController alloc]init];
    addInterfaceVC.dataArray = self.dataArray;
    addInterfaceVC.interface = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:addInterfaceVC animated:YES];
}

- (NSMutableArray *)dataArray{
    if(_dataArray==nil){
        NSMutableArray * array = [PileVillageInfo sharedPileVillageInfo].parkings;
        _dataArray=array?:[[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)customImagePickerWithChooseImage:(NSArray *)resultArray{
    if(resultArray.count){
        GJCFAsset * asset=[resultArray firstObject];
        NSData * data = UIImageJPEGRepresentation(asset.aspectRatioThumbnail, 1);
        self.tableView.currentImageView.image=[UIImage imageWithData:data];
    }
}

- (void)addPileInterface:(AddPileMainView *)mainView
{    
    AddInterfaceViewController *addInterfaceVC = [[AddInterfaceViewController alloc] init];
    [self.navigationController  pushViewController:addInterfaceVC animated:YES];

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

@end
