//
//  PileDetailMainView.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PileDetailMainViewDelegate <NSObject>

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

@end

@interface PileDetailMainView : UITableView<UITableViewDelegate, UITextFieldDelegate,UITextViewDelegate>

/**
 *  位置
 */
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

/**
 *  经度
 */
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

/**
 *  纬度
 */
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;

/**
 *  停车位图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *parkingImageView;

/**
 *  停车位文字描述
 */
@property (weak, nonatomic) IBOutlet UITextView *parkingTextView;

/**
 *  电桩全景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *pilePanoramicImageView;

/**
 *  电桩全景文字描述
 */
@property (weak, nonatomic) IBOutlet UITextView *pilePanoramicTextView;

/**
 *  空位图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *parkingVacancyImageView;

/**
 *  空位文字描述
 */
@property (weak, nonatomic) IBOutlet UITextView *parkingVacancyTextView;

/**
 *  充电中图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *carChargingImageView;

/**
 *  充电中文字描述
 */
@property (weak, nonatomic) IBOutlet UITextView *carChargingTextView;

/**
 *  大(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *bnumTextField;

/**
 *  中(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *mnumTextField;

/**
 *  小(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *snumTextField;

/**
 *  微(个)
 */
@property (weak, nonatomic) IBOutlet UITextField *tnumTextField;

/**
 *  特殊说明
 */
@property (weak, nonatomic) IBOutlet UITextView *instructionsTextView;

@property(nonatomic,weak)id<PileDetailMainViewDelegate> mainViewDelegate;

@property (nonatomic, weak)UIImageView * currentImageView;

@end
