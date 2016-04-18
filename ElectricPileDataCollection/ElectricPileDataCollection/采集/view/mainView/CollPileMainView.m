//
//  CollPileMainView.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "CollPileMainView.h"
#import "PileVillageInfo.h"
#import "CustomPickView.h"
#import "CustomPopupView.h"
#import "CustomAlertView.h"
#import "UIView+LayoutCornerRadius.h"
#import "UIImageView+WebCache.h"
#import "RegionAll.h"


@interface CollPileMainView()<CustomPickViewDelegate,CustomAlertViewDelegate>

@property (weak, nonatomic) CustomPickView * chooseCityView;

@end

@implementation CollPileMainView

- (void)awakeFromNib{
    self.delegate=self;
    
    PileVillageInfo * info = [PileVillageInfo sharedPileVillageInfo];
    //读取，回显省市区片
    self.regionLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",info.province.name.length?info.province.name:@"",info.city.name.length?info.city.name:@"",info.district.name.length?info.district.name:@"",info.area.name.length?info.area.name:@""];
    //回显片
    self.communityLabel.text = info.pile_village.villageName;
    
    if(info.pile_village.villagePathImagePath){
        if([info.pile_village.villagePathImagePath containsString:@"http"]){
            [self.toGoImageView sd_setImageWithURL:[NSURL URLWithString:info.pile_village.villagePathImagePath]];
        }else{
            self.toGoImageView.image=[UIImage imageWithContentsOfFile:info.pile_village.villagePathImagePath];
        }
    }
    
    if(info.pile_village.villageEntranceImagePath){
        if([info.pile_village.villageEntranceImagePath containsString:@"http"]){
            [self.villageEntranceImageView sd_setImageWithURL:[NSURL URLWithString:info.pile_village.villageEntranceImagePath]];
        }else{
            self.villageEntranceImageView.image=[UIImage imageWithContentsOfFile:info.pile_village.villageEntranceImagePath];
        }
    }
    
    //toGoImageView、villageEntranceImageView
    self.toGoImageView.userInteractionEnabled=YES;
    self.villageEntranceImageView.userInteractionEnabled=YES;
    self.toGoImageView.tag=101;
    self.villageEntranceImageView.tag=102;
    
    UITapGestureRecognizer * tgr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
    [self.toGoImageView addGestureRecognizer:tgr];
    
    UITapGestureRecognizer * tgr2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAlbubmOrPhotoGraphWithTgr:)];
    [self.villageEntranceImageView addGestureRecognizer:tgr2];
    
    self.toGoCommentTextView.text=info.pile_village.comment1.length?info.pile_village.comment1:FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
    self.villageEntranceTextView.text=info.pile_village.comment2.length?info.pile_village.comment2:FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
    
    [self setTextViewWithTextView:self.toGoCommentTextView];
    [self setTextViewWithTextView:self.villageEntranceTextView];
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
    if(indexPath.row==0){//选择省市区片
        self.chooseCityView.hidden=NO;
    }else if (indexPath.row==1){//输入小区小区
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView * av=[[UIAlertView alloc]initWithTitle:nil message:@"请输入小区名称：" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            av.alertViewStyle=UIAlertViewStylePlainTextInput;
            [av show];
        });
    }
}

#pragma mark - 自定义代理
- (void)customPickView:(CustomPickView *)customPickView andSelectedArray:(NSArray *)selectedArray andDataArray:(NSArray *)dataArray{
    customPickView.hidden=YES;
    
    NSMutableString * value =[NSMutableString string];
    PileVillageInfo * info=[PileVillageInfo sharedPileVillageInfo];
    info.provinceid=0;
    info.cityid=0;
    info.districtid=0;
    info.areaid=0;
    info.province=nil;
    info.city=nil;
    info.district=nil;
    info.area=nil;
    
    NSInteger proIndex = [selectedArray[0] integerValue];
    NSInteger cityIndex = [selectedArray[1] integerValue];
    NSInteger disIndex = [selectedArray[2] integerValue];
    NSInteger areaIndex = [selectedArray[3] integerValue];
    
    Province * pro = dataArray[proIndex];
    [value appendFormat:@"%@",pro.name];
    info.provinceid=pro.Id;
    info.province=pro;
    if([pro.cityArray count]!=0){
        City * city = pro.cityArray[cityIndex];
        [value appendFormat:@" %@",city.name];
        info.cityid=city.Id;
        info.city=city;
        if([city.districtArray count]!=0){
            District * dis = city.districtArray[disIndex];
            [value appendFormat:@" %@",dis.name];
            info.districtid=dis.Id;
            info.district=dis;
            if([dis.areaArray count]!=0){
                Area * area = dis.areaArray[areaIndex];
                [value appendFormat:@" %@",area.name];
                info.areaid=area.Id;
                info.area=area;
            }
        }
    }
    self.regionLabel.text=value;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField * tf = [alertView textFieldAtIndex:0];
    if(tf.text.length){
        [self.mainViewDelegate addVillageInfoWithVillageName:tf.text];
        [PileVillageInfo sharedPileVillageInfo].pile_village.villageName=tf.text;
        self.communityLabel.text = [NSString stringWithFormat:@"%@",tf.text];
    }
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

#pragma mark - TextView协议代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:FINAL_PLEASE_ENTER_DESCRIPTION_TEST]){
        textView.text=@"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@""]){
        textView.text=FINAL_PLEASE_ENTER_DESCRIPTION_TEST;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setTextViewWithTextView:(UITextView *)tv{
    tv.layer.borderColor = [[UIColor blackColor]CGColor];
    tv.layer.borderWidth = 1.0;
    [tv layoutCornerRadiusWithCornerRadius:5];
    tv.returnKeyType=UIReturnKeyDone;
    tv.delegate=self;
}



#pragma mark - 懒加载
- (CustomPickView *)chooseCityView{
    if(_chooseCityView==nil){
        
        CustomPickView * pickView=[CustomPickView customPickViewWithDataArray:[RegionAll provinceArrayFromDatabase] andComponent:4 andIsDependPre:YES andFrame:CGRectMake(0, HEIGHT-300, WIDTH, 300)];
        pickView.delegate=self;
        pickView.titleKey=@"name";
        pickView.dataArrayKey=@[@"cityArray",@"districtArray",@"areaArray"];
        [self.superview.superview addSubview:pickView];
        _chooseCityView=pickView;
        
    }
    return _chooseCityView;
}

@end
