//
//  PileDetailViewController.m
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "PileDetailViewController.h"
#import "PileDetailMainView.h"
#import "CustomImagePickerViewController.h"

@interface PileDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,PileDetailMainViewDelegate, CustomImagePickerDelegate, CLImageEditorDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) PileDetailMainView *tableView;

@property (assign, nonatomic) BOOL isChooseparkingIV;

@property (assign, nonatomic) BOOL isChoosepilePanoramicIV;

@property (assign, nonatomic) BOOL isChooseparkingVacancyIV;

@property (assign, nonatomic) BOOL isChoosecarChargingIV;

@end

@implementation PileDetailViewController

- (instancetype)init
{
    NSString * sbName=NSStringFromClass([self class]);
    UIStoryboard * sb=[UIStoryboard storyboardWithName:sbName bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:sbName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationBar];
    [self loadMainView];
}

- (void)loadNavigationBar
{
    self.navigationItem.title = @"电桩详情";
    
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.leftBarButtonItem = saveBtnItem;
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.rightBarButtonItem = cancelBtnItem;

}

- (void)loadMainView
{
    self.tableView = self.containerView.subviews[0];
    self.tableView.mainViewDelegate = self;
    
    /**
     *  数据回显
     */
    if (self.pileLocation) {
        
        // 位置
        self.tableView.locationTextField.text = self.pileLocation.siteName;
        // 经度
        self.tableView.longitudeTextField.text = self.pileLocation.x;
        // 纬度
        self.tableView.latitudeTextField.text = self.pileLocation.y;
        
    }
}

- (void)saveClick:(UIButton *)sender
{
    if(!self.pileLocation){
        self.pileLocation=[[PileGroupSite alloc]init];
        [self.dataArray addObject:self.pileLocation];
    }
    
    // 位置
    self.pileLocation.siteName = self.tableView.locationTextField.text;
    // 经度
    self.pileLocation.x = self.tableView.longitudeTextField.text;
    // 纬度
    self.pileLocation.y = self.tableView.latitudeTextField.text;
    
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
        if(self.tableView.currentImageView.tag == 5000){
            // 第一张图片
            self.isChooseparkingIV = YES;
        }else if (self.tableView.currentImageView.tag == 5001){
            // 第二张图片
            self.isChoosepilePanoramicIV = YES;
        }else if (self.tableView.currentImageView.tag == 5002){
            // 第三张图片
            self.isChooseparkingVacancyIV = YES;
        }else{
            // 第四张图片
            self.isChoosecarChargingIV = YES;
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

#pragma mark - UIImagePickViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    
    self.tableView.currentImageView.image = image;

    if(self.tableView.currentImageView.tag == 5000){
        // 第一张图片
        self.isChooseparkingIV = YES;
    }else if (self.tableView.currentImageView.tag == 5001){
        // 第二张图片
        self.isChoosepilePanoramicIV = YES;
    }else if (self.tableView.currentImageView.tag == 5002){
        // 第三张图片
        self.isChooseparkingVacancyIV = YES;
    }else{
        // 第四张图片
        self.isChoosecarChargingIV = YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self editorImageWithImage:image];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
