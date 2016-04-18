//
//  CollPileMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/8.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollPileMainView;


@protocol CollPileMainViewDelegate <NSObject>

- (void)itemSelectedWithMainView:(CollPileMainView *)mainView andIndexPath:(NSIndexPath *)indexPath;

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

- (void)addVillageInfoWithVillageName:(NSString *)villageName;

@end


@interface CollPileMainView : UITableView<UITableViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
/**
 *  省市区
 */
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
/**
 *  片、小区
 */
@property (weak, nonatomic) IBOutlet UILabel *communityLabel;

@property (weak, nonatomic) IBOutlet UIImageView *toGoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *villageEntranceImageView;

@property (weak, nonatomic) IBOutlet UITextView *toGoCommentTextView;

@property (weak, nonatomic) IBOutlet UITextView *villageEntranceTextView;

//@property(nonatomic,strong)NSArray * villageDataArray;

@property (nonatomic, weak)UIImageView * currentImageView;

@property(nonatomic,weak)id<CollPileMainViewDelegate> mainViewDelegate;

@end
