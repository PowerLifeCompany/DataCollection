//
//  FeesDetailMainView.h
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/12.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeesDetailMainViewDelegate <NSObject>

- (void)chooseAlbubmOrPhotoGraphWithIndex:(NSInteger)index;

@end

@interface FeesDetailMainView : UITableView<UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *feesDetailNameTF;
@property (weak, nonatomic) IBOutlet UITextField *workDayBeginTF;
@property (weak, nonatomic) IBOutlet UITextField *workDayEndTF;
@property (weak, nonatomic) IBOutlet UITextField *weekendBeginTF;
@property (weak, nonatomic) IBOutlet UITextField *weekendEndTF;
@property (weak, nonatomic) IBOutlet UITextField *openTimeCommentTF;
@property (weak, nonatomic) IBOutlet UIButton *unifiedTariffsBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeSharingBtn;
@property (weak, nonatomic) IBOutlet UIButton *ladderChargesBtn;
/**
 *  总体特殊说明
 */
@property (weak, nonatomic) IBOutlet UITextView *feesDetailCommentTV;
@property (weak, nonatomic) IBOutlet UILabel *parkingDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *feesDetailImageView;
/**
 *  照片（收费标准描述）
 */
@property (weak, nonatomic) IBOutlet UITextView *feesDetailTextView;


@property(nonatomic,weak)id<FeesDetailMainViewDelegate> mainViewDelegate;

@end
