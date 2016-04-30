//
//  AddPileMainView.h
//  ElectricPileDataCollection
//
//  Created by 温冬 on 16/4/23.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pile.h"

@class AddPileMainView;

@protocol AddPileMainViewDelegate <NSObject>

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

- (void)itemSelectedWithMainView:(AddPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

- (void)addPileInterface:(AddPileMainView *)mainView;

@end

@interface AddPileMainView : UITableView<UITableViewDelegate,UITextViewDelegate>

/**
 *  电桩品牌
 */
@property (strong, nonatomic) UILabel *pileBrandLabel;

/**
 *  电桩运营商
 */
@property (strong, nonatomic) UILabel *pileOperatorLabel;

/**
 *  细节照片
 */
@property (strong, nonatomic) UIImageView *logoDetailImageView;

/**
 *  细节描述
 */
@property (strong, nonatomic) UITextView *logoDetailTextView;

@property (strong, nonatomic) UIView *footerView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray *interfaceArray;

@property (nonatomic,weak)UIImageView * currentImageView;

@property (assign, nonatomic) NSInteger currentPickViewIndex;

@property(nonatomic,weak)id<AddPileMainViewDelegate> mainViewDelegate;

@property (strong, nonatomic) Pile *addPile;

@end
