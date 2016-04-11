//
//  CustomImagePickerViewController.m
//  testPickView
//
//  Created by 陈行 on 16-1-19.
//  Copyright (c) 2016年 陈行. All rights reserved.
//

#import "CustomImagePickerViewController.h"
#import "CustomAlbumsCell.h"
#import "DeepCustomStyle.h"

@interface CustomImagePickerViewController ()<GJCFAssetsPickerViewControllerDelegate>

@end

@implementation CustomImagePickerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [GJCFAssetsPickerStyle removeCustomStyleByKey:@"DeepCustomStyle"];
        
        DeepCustomStyle *deepStyle = [[DeepCustomStyle alloc]init];
        [GJCFAssetsPickerStyle appendCustomStyle:deepStyle forKey:@"DeepCustomStyle"];
        
        self.mutilSelectLimitCount = self.maxCount?:1;
        self.pickerDelegate = self;
        
        /* 注入自定义相册Cell */
        [self registAlbumsCustomCellClass:[CustomAlbumsCell class] withCellHeight:65.f];
        
        /* 注入预先设置的风格 */
        [self setCustomStyleByKey:@"DeepCustomStyle"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setMaxCount:(NSInteger)maxCount{
    _maxCount=maxCount;
    self.mutilSelectLimitCount=maxCount;
}

#pragma mark - assetsPicker delegate
- (void)pickerViewController:(GJCFAssetsPickerViewController *)pickerViewController didReachLimitSelectedCount:(NSInteger)limitCount{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"超过限制%ld张数",(long)limitCount] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)pickerViewControllerRequirePreviewButNoSelectedImage:(GJCFAssetsPickerViewController *)pickerViewController{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请选择要预览的图片"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)pickerViewController:(GJCFAssetsPickerViewController *)pickerViewController didFinishChooseMedia:(NSArray *)resultArray{
    [self.imagePickerDelegate customImagePickerWithChooseImage:resultArray];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerViewControllerPhotoLibraryAccessDidNotAuthorized:(GJCFAssetsPickerViewController *)pickerViewController{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请授权访问你的相册"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}


@end
