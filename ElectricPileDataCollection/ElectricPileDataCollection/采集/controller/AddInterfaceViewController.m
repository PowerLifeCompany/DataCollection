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

@interface AddInterfaceViewController ()<AddInterfaceMainViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, CustomImagePickerDelegate, CLImageEditorDelegate>

@property (weak, nonatomic) AddInterfaceMainView *tableView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (assign, nonatomic) BOOL isChooseInterfaceIV;

@property (assign, nonatomic) BOOL isChooseInterfaceDetailIV;

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
        }else{
            mainView.payOpetator.image = [UIImage imageNamed:@"checkBox_no"];
        }
        mainView.isChoosepayOpetator = !mainView.isChoosepayOpetator;
    }else if([tap view].tag == 8001){
        // 微信
        if (mainView.isChoosepayWechat == NO) {
            mainView.payWechat.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            mainView.payWechat.image = [UIImage imageNamed:@"checkBox_no"];
        }
        mainView.isChoosepayWechat = !mainView.isChoosepayWechat;

    }else if ([tap view].tag == 8002){
        // 支付宝
        if (mainView.isChoosepayAli == NO) {
            mainView.payAli.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            mainView.payAli.image = [UIImage imageNamed:@"checkBox_no"];
        }
        mainView.isChoosepayAli = !mainView.isChoosepayAli;
        
    }else{
        // 信用卡
        if (mainView.isChoosepayCreditCard == NO) {
            mainView.payCreditCard.image = [UIImage imageNamed:@"checkBox_yes"];
        }else{
            mainView.payCreditCard.image = [UIImage imageNamed:@"checkBox_no"];
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

@end
