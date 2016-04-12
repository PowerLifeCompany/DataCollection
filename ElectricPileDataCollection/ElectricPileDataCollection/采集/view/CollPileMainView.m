//
//  CollPileMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CollPileMainView.h"
#import "CustomChooseCityView.h"
#import "PileVillageInfo.h"
#import "CustomPickView.h"
#import "CustomPopupView.h"
#import "CustomAlertView.h"
#import "Area.h"


@interface CollPileMainView()<CustomChooseCityViewDelegate,CustomPickViewDelegate,CustomAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *regionLabel;

@property (weak, nonatomic) IBOutlet UILabel *communityLabel;

@property (weak, nonatomic) IBOutlet UIImageView *toGoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *villageEntranceImageView;

@property (weak, nonatomic) IBOutlet UITextView *toGoCommentTextView;

@property (weak, nonatomic) IBOutlet UITextView *villageEntranceTextView;

@property(nonatomic,weak)CustomChooseCityView * chooseCityView;

@property (weak, nonatomic) CustomPickView * pickView;

@end

@implementation CollPileMainView

- (void)awakeFromNib{
    self.delegate=self;
    
    //读取，回显省市区
    NSArray * cityDataArray = [CustomChooseCityModel sharedChooseCityModelList];
    NSInteger provinceid = [PileVillageInfo sharedPileVillageInfo].provinceid;
    NSInteger cityid = [PileVillageInfo sharedPileVillageInfo].cityid;
    NSInteger districtid = [PileVillageInfo sharedPileVillageInfo].districtid;
    CustomChooseCityModel * provinceModel = cityDataArray[provinceid-1];
    CustomChooseCityModel * cityModel = provinceModel.cities[cityid-1];
    CustomChooseCityModel * districtModel = cityModel.cities[districtid-1];
    self.regionLabel.text=[NSString stringWithFormat:@"%@ %@ %@",provinceModel.title,cityModel.title,districtModel.title];
    
    //回显片、小区
    self.communityLabel.text = [PileVillageInfo sharedPileVillageInfo].area.name;
    
    //toGoImageView、villageEntranceImageView
    self.toGoImageView.userInteractionEnabled=YES;
    self.villageEntranceImageView.userInteractionEnabled=YES;
    self.toGoImageView.tag=101;
    self.villageEntranceImageView.tag=102;
    
    UITapGestureRecognizer * tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
    [self.toGoImageView addGestureRecognizer:tgr];
    
    UITapGestureRecognizer * tgr2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
    [self.villageEntranceImageView addGestureRecognizer:tgr2];
    
}

- (void)chooseAlbubmOrPhotoGraphWithTgr:(UITapGestureRecognizer *)tgr{
    self.currentImageView = (UIImageView *)tgr.view;
    CustomAlertView * alertView=[CustomAlertView customAlertViewWithArray:@[@"相机",@"相册",@"取消"]];
    alertView.delegate=self;
    [self.superview.superview addSubview:alertView];
    [alertView showAlertView];
}

#pragma mark - tableView协议代理
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0 || indexPath.row==1){
        return 60;
    }else{
        return 160;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){//选择省市区
        [self.chooseCityView showPickView];
    }else if (indexPath.row==1){//选择片、小区
        [self.mainViewDelegate itemSelectedWithMainView:self andIndexPath:indexPath];
    }
}

#pragma mark - 自定义代理
- (void)customChooseCityViewAndSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray andValue:(NSString *)value{
    self.regionLabel.text=value;
    PileVillageInfo * info=[PileVillageInfo sharedPileVillageInfo];
    info.provinceid=[selectedArray[0] integerValue]+1;
    info.cityid=[selectedArray[1] integerValue]+1;
    info.districtid=[selectedArray[2] integerValue]+1;
    
    NSLog(@"%@",info);
    self.communityLabel.text=@"";
    info.areaid=0;
    info.area=nil;
}

- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    customPickView.hidden=YES;
    NSInteger num = [selectedArray[0] integerValue];
    Area * area = dataArray[num];
    self.communityLabel.text=area.name;
    [PileVillageInfo sharedPileVillageInfo].areaid=num+1;
    [PileVillageInfo sharedPileVillageInfo].area=area;
}

- (void)customPickViewCancleTouch:(CustomPickView *)customPickView{
    customPickView.hidden=YES;
}

- (void)customAlertView:(CustomAlertView *)alertView andIndex:(NSInteger)index{
    [alertView hiddenAlertView];
    if(index==2){
        return;
    }else{
        [self.mainViewDelegate chooseAlbubmOrPhotoGraphWithIndex:index];
    }
}

#pragma mark - 懒加载
- (CustomChooseCityView *)chooseCityView{
    if(_chooseCityView==nil){
        CustomChooseCityView * chooseCityView=[[CustomChooseCityView alloc]initWithFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        chooseCityView.delegate=self;
        [self.superview.superview addSubview:chooseCityView];
        _chooseCityView=chooseCityView;
    }
    return _chooseCityView;
}

- (CustomPickView *)pickView{
    if(_pickView==nil){
        CustomPickView * pickView=[CustomPickView customPickViewWithDataArray:self.villageDataArray andComponent:1 andIsDependPre:NO andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.delegate=self;
        pickView.titleKey=@"name";
//        pickView.transform=CGAffineTransformTranslate(pickView.transform, 0, HEIGHT);
        
        [self.superview.superview addSubview:pickView];
        _pickView=pickView;
    }
    return _pickView;
}

- (void)setVillageDataArray:(NSArray *)villageDataArray{
    _villageDataArray=villageDataArray;
    if(villageDataArray && [villageDataArray count]){
        self.pickView.dataArray=villageDataArray;
        [self.pickView reloadSelectArray];
        self.pickView.hidden=NO;
        [self.chooseCityView hiddenPickView];
    }else{
        [self.superview.superview addSubview:[CustomPopupView customPopupViewWithMsg:@"暂无信息！"]];
    }
}

@end
