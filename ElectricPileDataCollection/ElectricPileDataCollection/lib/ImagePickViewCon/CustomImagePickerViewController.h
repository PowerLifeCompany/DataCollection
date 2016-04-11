//
//  CustomImagePickerViewController.h
//  testPickView
//
//  Created by 陈行 on 16-1-19.
//  Copyright (c) 2016年 陈行. All rights reserved.
//

#import "GJCFAssetsPickerViewController.h"

@protocol CustomImagePickerDelegate <NSObject>

/**
 *  选择完图片之后
 *
 *  @param resultArray GJCFAsset.h
 */
- (void)customImagePickerWithChooseImage:(NSArray *)resultArray;

@end

@interface CustomImagePickerViewController : GJCFAssetsPickerViewController


@property(nonatomic,assign)NSInteger maxCount;

@property(nonatomic,weak)id<CustomImagePickerDelegate>imagePickerDelegate;

@end
