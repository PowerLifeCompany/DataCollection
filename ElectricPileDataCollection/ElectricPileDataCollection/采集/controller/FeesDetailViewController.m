//
//  FeesDetailViewController.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "FeesDetailViewController.h"
#import "CustomImagePickerViewController.h"
#import "FeesDetailMainView.h"

#import "UnifiedTariffsChargeView.h"
#import "TimeSharingChargeView.h"
#import "LadderChargeView.h"
#import "NSSystemDate.h"

#import "NSFileManager+FileCategory.h"
#import "UIImageView+WebCache.h"

@interface FeesDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,CustomImagePickerDelegate,FeesDetailMainViewDelegate,CLImageEditorDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) FeesDetailMainView * tableView;

@property (weak, nonatomic) UIView * currentParkingChargeView;

@property(nonatomic,assign)BOOL isChooseImage;

@end

@implementation FeesDetailViewController

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
    self.tableView.mainViewDelegate=self;
    [self.tableView.unifiedTariffsBtn addTarget:self action:@selector(chooseParkingChargesCategory:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.timeSharingBtn addTarget:self action:@selector(chooseParkingChargesCategory:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.ladderChargesBtn addTarget:self action:@selector(chooseParkingChargesCategory:) forControlEvents:UIControlEventTouchUpInside];
    if(self.pcs){
        //名称
        self.tableView.feesDetailNameTF.text=self.pcs.parkingName;
        //照片收费标准
        if(self.pcs.chargeImagePath){
            if([self.pcs.chargeImagePath containsString:@"http"]){
                [self.tableView.feesDetailImageView sd_setImageWithURL:[NSURL URLWithString:self.pcs.chargeImagePath]];
            }else{
                NSData * data = [NSData dataWithContentsOfFile:self.pcs.chargeImagePath];
                self.tableView.feesDetailImageView.image=[UIImage imageWithData:data];
            }
        }
        self.tableView.feesDetailTextView.text=self.pcs.comment10;
        //开放时间
        NSString * openWorkStr = self.pcs.openIntervalWork;
        NSArray * openWorkArr = [openWorkStr componentsSeparatedByString:@"~"];
        if(openWorkArr && [openWorkArr count]==2){
            self.tableView.workDayBeginTF.text=openWorkArr[0];
            self.tableView.workDayEndTF.text=openWorkArr[1];
        }
        NSString * openNoWorkStr = self.pcs.openIntervalNowork;
        NSArray * openNoWorkArr = [openNoWorkStr componentsSeparatedByString:@"~"];
        if(openNoWorkArr && [openNoWorkArr count]==2){
            self.tableView.weekendBeginTF.text=openNoWorkArr[0];
            self.tableView.weekendEndTF.text=openNoWorkArr[1];
        }
        self.tableView.openTimeCommentTF.text=self.pcs.openComment;
        //停车费
        if(self.pcs.tariffTypeUnify){
            self.tableView.unifiedTariffsBtn.selected=YES;
            self.tableView.parkingDescLabel.text=self.pcs.tariffTypeUnify;
        }
        if(self.pcs.tariffTypeSplit){
            self.tableView.timeSharingBtn.selected=YES;
            self.tableView.parkingDescLabel.text=self.pcs.tariffTypeSplit;
        }
        if(self.pcs.tariffTypeLadder){
            self.tableView.ladderChargesBtn.selected=YES;
            self.tableView.parkingDescLabel.text=self.pcs.tariffTypeLadder;
        }
        //总体说明
        self.tableView.feesDetailCommentTV.text=self.pcs.comment;
    }
}

- (void)loadNavigationBar{
    self.navigationItem.title = @"收费详情";
    UIBarButtonItem * leftItem =[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancleBtnClick:)];
    self.navigationItem.leftBarButtonItem =leftItem;
    UIBarButtonItem * rightItem =[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)saveBtnClick:(UIBarButtonItem *)bbi{
    if(!self.pcs){
        self.pcs=[[ParkingChargeStandard alloc]init];
        [self.dataArray addObject:self.pcs];
    }
    //名称
    self.pcs.parkingName=self.tableView.feesDetailNameTF.text;
    //照片收费标准
    if(self.isChooseImage){
        NSData * data = UIImagePNGRepresentation(self.tableView.feesDetailImageView.image);
        NSString * imagePath = [[NSSystemDate new] descriptionWithTimeFormatter:@"HHmmssSSS"];
        [NSFileManager writeToFile:[NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_PARKING_TARIFF_FOLDER,imagePath] withData:data];
        self.pcs.chargeImagePath=[NSString stringWithFormat:@"%@/%@.png",IMAGE_PATH_PILE_PARKING_TARIFF_FOLDER,imagePath];
    }
    self.pcs.comment10=self.tableView.feesDetailTextView.text;
    //开放时间
    self.pcs.openIntervalWork=[NSString stringWithFormat:@"%@~%@",self.tableView.workDayBeginTF.text,self.tableView.workDayEndTF.text];
    self.pcs.openIntervalNowork=[NSString stringWithFormat:@"%@~%@",self.tableView.weekendBeginTF.text,self.tableView.weekendEndTF.text];
    self.pcs.openComment=self.tableView.openTimeCommentTF.text;
    //停车费
    if(self.tableView.unifiedTariffsBtn.selected){
        self.pcs.tariffTypeUnify=self.tableView.parkingDescLabel.text;
    }
    if(self.tableView.timeSharingBtn.selected){
        self.pcs.tariffTypeSplit=self.tableView.parkingDescLabel.text;
    }
    if(self.tableView.ladderChargesBtn.selected){
        self.pcs.tariffTypeLadder=self.tableView.parkingDescLabel.text;
    }
    //总体说明
    self.pcs.comment=self.tableView.feesDetailCommentTV.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancleBtnClick:(UIBarButtonItem *)bbi{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)customImagePickerWithChooseImage:(NSArray *)resultArray{
    if(resultArray.count){
        GJCFAsset * asset=[resultArray firstObject];
        self.tableView.feesDetailImageView.image=asset.fullResolutionImage;
        self.isChooseImage=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self editorImageWithImage:asset.fullResolutionImage];
        });
    }
}

#pragma mark - UIImagePickViewController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    self.tableView.feesDetailImageView.image=image;
//    NSData * data = UIImagePNGRepresentation(image);
    //加测试
    //写入到沙盒，按照一定的命名规则，暂时没做
    self.isChooseImage=YES;
    
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
    self.tableView.feesDetailImageView.image=image;
    [editor dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 私有方法
- (void)chooseParkingChargesCategory:(UIButton *)btn{//停车费单选按钮点击事件
    self.tableView.unifiedTariffsBtn.selected=NO;
    self.tableView.timeSharingBtn.selected=NO;
    self.tableView.ladderChargesBtn.selected=NO;
    btn.selected=YES;
    
    //弹出View
    if(btn==self.tableView.unifiedTariffsBtn){//统一资费
        UnifiedTariffsChargeView * chargeView = [[[NSBundle mainBundle]loadNibNamed:@"UnifiedTariffsChargeView" owner:nil options:nil] lastObject];
        chargeView.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        chargeView.backgroundColor=[UIColor colorWithWhite:0.816 alpha:0.9];
        chargeView.center=self.view.center;
        [chargeView.makeSureBtn addTarget:self action:@selector(makeSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:chargeView];
        self.currentParkingChargeView=chargeView;
    }else if (btn==self.tableView.timeSharingBtn){//分时资费
        TimeSharingChargeView * chargeView = [[[NSBundle mainBundle]loadNibNamed:@"TimeSharingChargeView" owner:nil options:nil] lastObject];
        chargeView.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        chargeView.backgroundColor=[UIColor colorWithWhite:0.816 alpha:0.9];
        chargeView.center=self.view.center;
        [chargeView.makeSureBtn addTarget:self action:@selector(makeSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:chargeView];
        self.currentParkingChargeView=chargeView;
    }else if (btn==self.tableView.ladderChargesBtn){//阶梯资费
        LadderChargeView * chargeView = [[[NSBundle mainBundle]loadNibNamed:@"LadderChargeView" owner:nil options:nil] lastObject];
        chargeView.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
        chargeView.backgroundColor=[UIColor colorWithWhite:0.816 alpha:0.9];
        chargeView.center=self.view.center;
        [chargeView.makeSureBtn addTarget:self action:@selector(makeSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:chargeView];
        self.currentParkingChargeView=chargeView;
    }
}

- (void)makeSureBtnClick:(UIButton *)btn{
    NSString * value;
    if([self.currentParkingChargeView isKindOfClass:[UnifiedTariffsChargeView class]]){//统一资费
        UnifiedTariffsChargeView * chargeView= (UnifiedTariffsChargeView *)self.currentParkingChargeView;
        if([chargeView.yuanEveryHoursBtn isSelected]){
            value=[NSString stringWithFormat:@"%.2f 元/小时",[chargeView.yuanEveryHoursTF.text doubleValue]];
        }else if ([chargeView.yuanEveryDayBtn isSelected]){
            value=[NSString stringWithFormat:@"%.2f 元/天",[chargeView.yuanEveryDayTF.text doubleValue]];
        }else{
            value=[NSString stringWithFormat:@"%.2f 元/次",[chargeView.yuanEveryTimeTF.text doubleValue]];
        }
    }else if ([self.currentParkingChargeView isKindOfClass:[TimeSharingChargeView class]]){
        TimeSharingChargeView * chargeView= (TimeSharingChargeView *)self.currentParkingChargeView;
        NSMutableString * value1 =[ NSMutableString string];
        for (NSString * content in chargeView.dataArray) {
            [value1 appendFormat:@"%@ ",content];
        }
        value=value1;
    }else if ([self.currentParkingChargeView isKindOfClass:[LadderChargeView class]]){
        LadderChargeView * chargeView= (LadderChargeView *)self.currentParkingChargeView;
        value=[NSString stringWithFormat:@"第一小时：%.2f元/小时，第二小时：%.2f元/小时，之后每小时递增：%.2f元" ,[chargeView.firstTF.text doubleValue],[chargeView.secondTF.text doubleValue],[chargeView.increasingTF.text doubleValue]];
    }
    self.tableView.parkingDescLabel.text=value;
    [self.currentParkingChargeView removeFromSuperview];
}

@end
