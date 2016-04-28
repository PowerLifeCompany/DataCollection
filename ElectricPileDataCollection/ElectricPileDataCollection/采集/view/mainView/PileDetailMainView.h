//
//  PileDetailMainView.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/18.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PileGroupInfo.h"

@class PileDetailMainView;

@protocol PileDetailMainViewDelegate <NSObject>

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

- (void)itemSelectedWithMainView:(PileDetailMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

- (void)addPile:(PileDetailMainView *)mainView;

@end

@interface PileDetailMainView : UITableView<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

/**
 *  位置
 */
@property (strong, nonatomic) UILabel *locationLabel;

/**
 *  经度
 */
@property (strong, nonatomic) UITextField *longitudeTextField;

/**
 *  纬度
 */
@property (strong, nonatomic) UITextField *latitudeTextField;

/**
 *  停车位图片
 */
@property (strong, nonatomic) UIImageView *parkingImageView;

/**
 *  停车位文字描述
 */
@property (strong, nonatomic) UITextView *parkingTextView;

/**
 *  电桩全景图片
 */
@property (strong, nonatomic) UIImageView *pileImageView;

/**
 *  电桩全景文字描述
 */
@property (strong, nonatomic) UITextView *pileTextView;

/**
 *  空位图片
 */
@property (strong, nonatomic) UIImageView *emptyImageView;

/**
 *  空位文字描述
 */
@property (strong, nonatomic) UITextView *emptyTextView;

/**
 *  充电中图片
 */
@property (strong, nonatomic) UIImageView *charingImageView;

/**
 *  充电中文字描述
 */
@property (strong, nonatomic) UITextView *charingTextView;

/**
 *  大(个)
 */
@property (strong, nonatomic) UITextField *bnumTextField;

/**
 *  中(个)
 */
@property (strong, nonatomic) UITextField *mnumTextField;

/**
 *  小(个)
 */
@property (strong, nonatomic) UITextField *snumTextField;

/**
 *  微(个)
 */
@property (strong, nonatomic) UITextField *wnumTextField;

/**
 *  特殊说明
 */
@property (strong, nonatomic) UITextView *instructionsTextView;

@property(nonatomic,weak)id<PileDetailMainViewDelegate> mainViewDelegate;

@property (nonatomic, weak)UIImageView * currentImageView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *addPileArray;

@property(nonatomic,strong) PileGroupInfo *pileGroupInfo;


@end
