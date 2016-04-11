//
//  CustomTabbar.m
//  封装-webView的一些内容
//
//  Created by 陈行 on 15-12-12.
//  Copyright (c) 2015年 陈行. All rights reserved.
//

#import "CustomTabbar.h"
#import "UIButton+RefreshLocation.h"

@interface CustomTabbar()

@end

@implementation CustomTabbar

+ (CustomTabbar *)tabbarWithTabbarItemArray:(NSArray *)itemArray andTabbarController:(UITabBarController *)tbc{
    return [[self alloc]initWithTabbarItemArray:itemArray andTabbarController:tbc];
}

- (CustomTabbar *)initWithTabbarItemArray:(NSArray *)itemArray andTabbarController:(UITabBarController *)tbc{
    if(self=[super initWithFrame:CGRectZero]){
        _tbc=tbc;
        tbc.tabBar.hidden=YES;
        UIImageView * bgImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        _backgroundImageView=bgImageView;
        [self addSubview:bgImageView];
        self.backgroundColor=[UIColor whiteColor];
        self.itemArray=itemArray;
    }
    return self;
}
#pragma mark - 首先设置内容
-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex=currentIndex;
    [self tabbarBtnTouch:self.btnArray[currentIndex]];
}

- (void)setItemArray:(NSArray *)itemArray{
    _itemArray=itemArray;
    
    int i=0;
    
    for (CustomTabbarItem * item in itemArray) {
        CGFloat btnW=WIDTH/itemArray.count;
        CGFloat btnH=49;
        CGFloat btnX=btnW*i;
        CGFloat btnY=0;
        
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor=[UIColor whiteColor];
        btn.tag=i;
        btn.frame=CGRectMake(btnX,btnY,btnW,btnH);
        
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        if(item.title==nil || [item.title isEqualToString:@""]){
            [btn setImage:[[UIImage imageNamed:item.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageNamed:item.selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            [btn setImage:[[UIImage imageNamed:item.selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        }else if(item.imageName!=nil && item.imageName.length){
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageNamed:item.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [btn setImage:[[UIImage imageNamed:item.selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            [btn setImage:[[UIImage imageNamed:item.selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
            btn.titleLabel.font=[UIFont systemFontOfSize:12];
            [btn refreshTopBottom];
            [btn refreshImageViewWithTop:20 andBottom:-20 andLeft:0 andRight:0];
             [btn refreshTitleLabelWithTop:-10 andBottom:10 andLeft:0 andRight:0];
        }else{
            [btn setTitle:item.title forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:12];
        }
        btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        [btn addTarget:self action:@selector(tabbarBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnArray addObject:btn];
        if(i==0){
            [self tabbarBtnTouch:btn];
        }
        i++;
    }//for end
}
#pragma mark- 设置点击item项的颜色
- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor=normalColor;
    for (UIButton * btn in self.btnArray) {
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
    }
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor=selectedColor;
    for (UIButton * btn in self.btnArray) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        [btn setTitleColor:selectedColor forState:UIControlStateHighlighted];
    }
}

#pragma mark- tabbar点击事件
- (void)tabbarBtnTouch:(UIButton *)btn{
    for (UIButton * tmpBtn in self.btnArray) {
        if(btn==tmpBtn){
            tmpBtn.selected=YES;
            tmpBtn.userInteractionEnabled=NO;
        }else{
            tmpBtn.selected=NO;
            tmpBtn.userInteractionEnabled=YES;
        }
    }
    self.tbc.selectedIndex=btn.tag;
}

#pragma mark- 设置背景图片
- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    _backgroundImageName=backgroundImageName;
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    self.backgroundImageView.image=[UIImage imageNamed:backgroundImageName];
}

- (NSMutableArray *)btnArray{
    if(_btnArray==nil){
        _btnArray=[[NSMutableArray alloc]init];
    }
    return _btnArray;
}

- (void)autolayoutMyTabbar{
    for (int i=0;i<self.btnArray.count;i++){
        UIButton * btn=self.btnArray[i];
        if(i==0){
            UIButton * nextBtn=self.btnArray[i+1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(self).offset(0);
                make.right.equalTo(nextBtn.mas_left).offset(0);
                make.width.equalTo(nextBtn.mas_width);
            }];
        }else if (i==self.btnArray.count-1){
            UIButton * preBtn=self.btnArray[i-1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(preBtn.mas_right).offset(0);
                make.right.equalTo(self).offset(0);
                make.width.equalTo(preBtn.mas_width);
            }];
        }else{
            UIButton * preBtn=self.btnArray[i-1];
            UIButton * nextBtn=self.btnArray[i+1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@0);
                make.bottom.equalTo(@0);
                make.left.equalTo(preBtn.mas_right).offset(0);
                make.right.equalTo(nextBtn.mas_left).offset(0);
                make.width.equalTo(preBtn.mas_width);
            }];
        }
    }//for end
}

@end
