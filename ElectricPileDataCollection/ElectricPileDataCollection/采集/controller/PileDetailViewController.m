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
#import "AddPileViewController.h"

#import "NSSystemDate.h"
#import "NSFileManager+FileCategory.h"

#import "CustomCellTwo.h"
#import "CustomCellThree.h"
#import "CustomCellFour.h"
#import "CustomCellFive.h"

@interface PileDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,PileDetailMainViewDelegate, CustomImagePickerDelegate, CLImageEditorDelegate, PileDetailMainViewDelegate,RequestUtilDelegate>

{
    int _oldOffset;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) PileDetailMainView *tableView;

@property(nonatomic,strong)RequestUtil * requestUtil;

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
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveClick:)];
    self.navigationItem.rightBarButtonItem = saveBtnItem;

}

- (void)loadMainView
{
    self.tableView = self.containerView.subviews[0];
    self.tableView.mainViewDelegate = self;
    //self.tableView.dataArray = self.dataArray;
    self.tableView.addPileArray = self.addPileArray;
    
    /**
     *  数据回显
     */
    if (self.pileGroupInfo) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            /**
             *  回显数据
             */
            [self assignment];
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.locationLabel.text = self.location;
        });
    }
    
}

- (void)assignment{
    
    self.tableView.pileGroupInfo = self.pileGroupInfo;
    
    
    /**
     *  获取第0区第0行的cell
     */
    NSIndexPath *index_one =  [NSIndexPath indexPathForItem:0 inSection:0];
    CustomCellThree *cell_one =  (CustomCellThree *)[self.tableView cellForRowAtIndexPath:index_one];
    // 位置
    cell_one.locationLabel.text = self.pileGroupInfo.pile_site.siteName;
    // 经度
    cell_one.longitudeTextField.text = self.pileGroupInfo.pile_site.x;
    // 纬度
    cell_one.latitudeTextField.text = self.pileGroupInfo.pile_site.y;
    
    
    /**
     *  获取第1区第0行的cell
     */
    NSIndexPath *index_two =  [NSIndexPath indexPathForItem:0 inSection:1];
    CustomCellTwo *cell_two =  (CustomCellTwo *)[self.tableView cellForRowAtIndexPath:index_two];
    // 停车位图片
    if (self.pileGroupInfo.pile_space.image3Path) {
        if([self.pileGroupInfo.pile_space.image3Path containsString:@"http"]){
            [cell_two.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image3Path]];
        }else{
            NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image3Path];
            cell_two.descImageView.image=[UIImage imageWithData:data];
        }
    }
    // 停车位图片描述
    cell_two.descTextView.text = self.pileGroupInfo.pile_space.comment3;
    
    
    /**
     *  获取第1区第1行的cell
     */
    NSIndexPath *index_three =  [NSIndexPath indexPathForItem:1 inSection:1];
    CustomCellTwo *cell_three =  (CustomCellTwo *)[self.tableView cellForRowAtIndexPath:index_three];
    // 电桩全景图片
    if (self.pileGroupInfo.pile_space.image4Path) {
        if([self.pileGroupInfo.pile_space.image4Path containsString:@"http"]){
            [cell_three.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image4Path]];
        }else{
            NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image4Path];
            cell_three.descImageView.image=[UIImage imageWithData:data];
        }
    }
     // 电桩全景描述
    cell_three.descTextView.text = self.pileGroupInfo.pile_space.comment4;
    
    
    /**
     *  获取第1区第2行的cell
     */
    NSIndexPath *index_four =  [NSIndexPath indexPathForItem:2 inSection:1];
    CustomCellTwo *cell_four =  (CustomCellTwo *)[self.tableView cellForRowAtIndexPath:index_four];
    // 空位图片
    if (self.pileGroupInfo.pile_space.image5Path) {
        if([self.pileGroupInfo.pile_space.image5Path containsString:@"http"]){
            [cell_four.descImageView sd_setImageWithURL:[NSURL URLWithString:self.pileGroupInfo.pile_space.image5Path]];
        }else{
            NSData * data = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image5Path];
            cell_four.descImageView.image=[UIImage imageWithData:data];
        }
    }
    // 空位图片描述
    cell_four.descTextView.text = self.pileGroupInfo.pile_space.comment5;
    

}

- (void)saveClick:(UIButton *)sender
{
    /**
     *  保存数据
     */
    if(!self.pileGroupInfo){
        self.pileGroupInfo = [[PileGroupInfo alloc]init];
        [self.dataArray addObject:self.pileGroupInfo];
    }
    
    // 位置
    self.pileGroupInfo.pile_site.siteName = self.location;

    // 经度
    self.pileGroupInfo.pile_site.x = self.tableView.longitudeTextField.text;
    
    // 纬度
    self.pileGroupInfo.pile_site.y = self.tableView.latitudeTextField.text;
    
    // 停车位图片
    if (self.isChooseparkingIV) {
        NSData * data = UIImagePNGRepresentation(self.tableView.parkingImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_SPACE_SITE_FOLDER,imagePath] withData:data];
        self.pileGroupInfo.pile_space.image3Path = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_SPACE_SITE_FOLDER,imagePath];
    }

    // 停车位文字描述
    self.pileGroupInfo.pile_space.comment3 = self.tableView.parkingTextView.text;
    
    // 电桩全景图片
    if (self.isChoosepilePanoramicIV) {
        
        NSData * data = UIImagePNGRepresentation(self.tableView.pileImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_SPACE_PILES_FOLDER,imagePath] withData:data];
        self.pileGroupInfo.pile_space.image4Path = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_SPACE_PILES_FOLDER,imagePath];
        
    }
    
    // 电桩全景文字描述
    self.pileGroupInfo.pile_space.comment4 = self.tableView.pileTextView.text;
    
    // 空位图片
    if (self.isChooseparkingVacancyIV) {
        
        NSData * data = UIImagePNGRepresentation(self.tableView.emptyImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_SPACE_EMPTY_FOLDER,imagePath] withData:data];
        self.pileGroupInfo.pile_space.image5Path = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_SPACE_EMPTY_FOLDER,imagePath];
        
    }
    
    // 空位图片描述
    self.pileGroupInfo.pile_space.comment5 = self.tableView.emptyTextView.text;
    
    // 充电图片
    if (self.isChoosecarChargingIV) {
        
        NSData * data = UIImagePNGRepresentation(self.tableView.charingImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png", IMAGE_PATH_PILE_SPACE_CHARGING_FOLDER,imagePath] withData:data];
        self.pileGroupInfo.pile_space.image6Path = [NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_SPACE_CHARGING_FOLDER,imagePath];
        
    }
    
    // 充电图片描述
    self.pileGroupInfo.pile_space.comment6 = self.tableView.charingTextView.text;
    
    // 大个
    self.pileGroupInfo.pile_space.bnum  = self.tableView.bnumTextField.text;
    
    // 中个
    self.pileGroupInfo.pile_space.mnum = self.tableView.mnumTextField.text;
    
    // 小个
    self.pileGroupInfo.pile_space.snum = self.tableView.snumTextField.text;
    
    // 微个
    self.pileGroupInfo.pile_space.tnum = self.tableView.wnumTextField.text;
    
    // 特殊说明
    self.pileGroupInfo.pile_space.comment = self.tableView.instructionsTextView.text;
    
    
    /**
     *  上传图片
     */
    NSDictionary *headerDict = @{@"__provinceid":@(0),@"__cityid":@(0),@"__districtid":@(0),@"__areaid":@(0),@"__villageid":@(0),@"__parkingid":@(0),@"__siteid":@(0)};
    self.requestUtil.headerDict = headerDict;
    
    
    // 停车位
    NSData *parkingImageData = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image3Path];
    NSString *parkingUrlStr = [NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_site"];
    [self.requestUtil uploadImageWithUrl:parkingUrlStr andParameters:nil andData:parkingImageData andTimeoutInterval:20];
    
    // 电桩全景
    NSData *pileAllImageData = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image4Path];
    NSString *pileAllUrlStr = [NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_piles"];
    [self.requestUtil uploadImageWithUrl:pileAllUrlStr andParameters:nil andData:pileAllImageData andTimeoutInterval:20];

    // 空车位
    NSData *emptyImageData = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image5Path];
    NSString *emptyUrlStr = [NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_empty"];
    [self.requestUtil uploadImageWithUrl:emptyUrlStr andParameters:nil andData:emptyImageData andTimeoutInterval:20];
    
    // 充电
    NSData *chargingImageData = [NSData dataWithContentsOfFile:self.pileGroupInfo.pile_space.image6Path];
    NSString *chargingUrlStr = [NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_charging"];
    [self.requestUtil uploadImageWithUrl:chargingUrlStr andParameters:nil andData:chargingImageData andTimeoutInterval:20];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"保存数据?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
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

- (void)addPile:(PileDetailMainView *)mainView
{
    AddPileViewController *addPileVC = [[AddPileViewController alloc] init];
    addPileVC.dataArray = self.addPileArray;
    [self.navigationController pushViewController:addPileVC animated:YES];
}

- (void)itemSelectedWithMainView:(PileDetailMainView *)mainView andIndexPath:(NSIndexPath *)indexPath
{
    AddPileViewController *addPileVC = [[AddPileViewController alloc] init];
    addPileVC.addPile = self.addPileArray[indexPath.row];
    [self.navigationController pushViewController:addPileVC animated:YES];
}

- (void)pushNextVC
{
    PileDetailViewController *pileDetailVC = [[PileDetailViewController alloc] init];
    pileDetailVC.dataArray = self.dataArray;
    [self.navigationController pushViewController:pileDetailVC animated:YES];
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

#pragma mark - 返回数据
- (void)response:(NSURLResponse *)response andError:(NSError *)error andData:(NSData *)data andStatusCode:(NSInteger)statusCode andURLString:(NSString *)urlString{
    
    if (statusCode == 200 && !error) {
        
        if ([urlString isEqualToString:[NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_site"]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.pileGroupInfo.pile_space.imageUrl3 = dic[@"url"];
        }
        
        if ([urlString isEqualToString:[NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_piles"]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.pileGroupInfo.pile_space.imageUrl4 = dic[@"url"];
        }

        if ([urlString isEqualToString:[NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_empty"]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.pileGroupInfo.pile_space.imageUrl5 = dic[@"url"];
        }
        
        if ([urlString isEqualToString:[NSString stringWithFormat:UPLOAD_IMAGE,@"pile_space_charging"]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.pileGroupInfo.pile_space.imageUrl6 = dic[@"url"];
        }
        
        NSLog(@"imageUrl3=%@,imageUrl4=%@,imageUrl5=%@,imageUrl6=%@",self.pileGroupInfo.pile_space.imageUrl3,self.pileGroupInfo.pile_space.imageUrl4,self.pileGroupInfo.pile_space.imageUrl5,self.pileGroupInfo.pile_space.imageUrl6);
        
        
    }else{
        NSLog(@"%@",error);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSMutableArray *)addPileArray{
    if(_addPileArray == nil){
        NSMutableArray *array = self.pileGroupInfo.piles;
        _addPileArray = array ?:[[NSMutableArray alloc] init];
    }
    return _addPileArray;
}

- (RequestUtil *)requestUtil{
    if(_requestUtil == nil){
        _requestUtil = [[RequestUtil alloc]init];
        _requestUtil.delegate = self;
    }
    return _requestUtil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSMutableArray *)dataArray{
//    if(_dataArray == nil){
//        NSMutableArray * array = [PileVillageInfo sharedPileVillageInfo].sites;
//        _dataArray = array?:[[NSMutableArray alloc]init];
//    }
//    return _dataArray;
//}

@end
